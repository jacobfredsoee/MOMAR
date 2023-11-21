library(tidyverse)
library(magrittr)
library(survival)
library(ggsurvfit)

# random data created by 02_files/02_createdata.R
# use these files if you want the same random data
geneData = read_rds("02_files/geneData.rds")
patientData = read_rds("02_files/patientData.rds")
LABKA = read_rds("02_files/LABKA.rds")
# you can also do source("02_files/02_createdata.R") if you want your own unique dataset
# as it is random generated, very little will be significant different (just like real life :D)


# Use your BMI function to add a column with BMI to the patientData
# hint: mapply for multiple arguments
patientData %<>% 
  mutate(BMI = mapply(calculateBMI, Height, Weight))

patientData = patientData %>% 
  mutate(BMI = mapply(calculateBMI, Height, Weight))

#Use it to plot something
patientData %>% 
  ggplot(aes(x = Gender, y = BMI)) +
  geom_boxplot() +
  facet_grid(~Group)



# Use apply to walk through each row and write an anonymous function that calculates the time to 
# event, or lastfollowup if there is no event, or NA if control group
# hint: apply converts input to whatever type can fit all data in a vector, most often character
# hint: you can access individual values as r["Recurrence"] for getting the Tstage value (as a character)
patientData %<>% 
  mutate(Time = apply(., 1, function(r) {
    if(r["Group"] == "Ctrl") return(NA)

    if(as.numeric(r["Recurrence"]) == 0)  {
      return(r["LastFollowup"])
    }
    else {
      return(r["TimeToRecurrence"])
    } 
  }) %>% as.numeric)


# Plot some KM plot based on BMI
with(patientData, {
  survObj = Surv(Time, Recurrence)
  
  survfit(survObj ~ BMI > median(BMI)) %>% #Split by median
    ggsurvfit +
    add_risktable() +
    scale_y_continuous(limits = c(0,1))
})


# a function for testing univariant cox regression
testCoxph = function(time, status, variable) {
  result = coxph(Surv(time, status) ~ variable) %>% summary
  
  return(result$coefficients)
}

# Write an anonymous function that takes a gene name as input (g), and calculates univariant cox regression
# hint: you may need to create some local data to use as input
# hint: lapply returns the output as a list and can be collapsed by bind_rows (if the content of the list are data.frames)
allCox = geneData$GeneName %>% 
  lapply(\(g) {
    recurrenceData = patientData %>% 
      subset(!is.na(Recurrence))
    
    data = geneData[geneData$GeneName == g, recurrenceData$PatientID]
    
    testCoxph(recurrenceData$Time, recurrenceData$Recurrence, unlist(data)) %>% 
      as.data.frame %>% 
      return
  }) %>% 
  bind_rows %>% 
  set_rownames(geneData$GeneName)

# Some code to plot all significant genes
allCox %>% 
  rownames_to_column("Genename") %>% 
  subset(`Pr(>|z|)` < 0.05) %>% 
  arrange(`Pr(>|z|)`) %>% 
  mutate(Genename = factor(Genename, levels = Genename)) %>% 
  ggplot(aes(x = Genename, y = -log10(`Pr(>|z|)`))) +
  geom_point() +
  theme(axis.text.x = element_text(angle = -90, hjust = 0))



# Add a column to LABKA which holds the date difference between sugery and SampleDate
# hint: some values may be converted to a wrong type and have to be coerced back to a date by as.Date()
LABKA %<>% 
  mutate(timeFromSurgery = apply(., 1, \(r) {
    surgeryDate = subset(patientData, PatientID == r["PatientID"])$DateOfSurgery
    
    if(is.na(surgeryDate)) return(NA)
    
    return(as.Date(r["SampleDate"]) - surgeryDate)
    
  }))



# Use sapply to loop though each PatientID and get the BMI of the patient, as well as getting the sampling
# closest to surgery. Then return BMI and the value for cholesterol (NPU01566) and the timeFromSurgery
# hint: you can return multiple values by return(c(name = value, name2 = value2))
timeTolerance = 365 #The sampling data has to be within this many days from surgery
cholesterol = sapply(patientData$PatientID, \(id) {
  BMI = subset(patientData, PatientID == id)$BMI %>% 
    as.vector
  
  LABKAdata = subset(LABKA, PatientID == id) %>% 
    subset(NPUcode == "NPU01566") %>% 
    subset(abs(timeFromSurgery) < timeTolerance) %>% 
    arrange(desc(timeFromSurgery))
  
  if(nrow(LABKAdata) > 0) {
    return(c(BMI = BMI, 
             value = LABKAdata$value[1] %>% as.vector, 
             timeFromSurgery = LABKAdata$timeFromSurgery[1] %>% as.vector))
  } else {
    return(c(BMI = NA, 
             value = NA, 
             timeFromSurgery = NA))
  }
}) %>% 
  t %>% 
  data.frame

cholesterol %>% 
  ggplot(aes(x = BMI, y = value)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
  










geneData %>% apply(1, var, na.rm = TRUE)

1:10 %>% sapply(sqrt)

