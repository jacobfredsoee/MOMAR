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
  mutate(BMI = your_code_here)

# Then use BMI to plot something (does not necessarily have to be changed)
patientData %>% 
  ggplot(aes(x = Gender, y = BMI)) +
  geom_boxplot() +
  facet_grid(~Group)



# Use apply to walk through each row and write an anonymous function that calculates the time to 
# event, or lastfollowup if there is no event, or NA if control group
# hint: apply converts input to whatever type can fit all data in a vector, most often character
# hint: you can access individual values as r["Recurrence"] for getting the Tstage value (as a character)
patientData %<>% # this pipe operator overwrites the object to the left with the output from the right
  mutate(Time = apply(., 1, function(r) {
    if(r["Group"] == "Ctrl") {
      # do someting
    } 
    # more code here
  }) %>% as.numeric) # convert output to numeric


# Plot some KM plot based on BMI (does not necessarily have to be changed)
with(patientData, { # with just makes the internal variables of patientData available within the { }, so you can write Time, instead of patientData$Time
  survObj = Surv(Time, Recurrence)
  
  survfit(survObj ~ BMI > median(BMI)) %>% #Split BMI by median
    ggsurvfit +
    add_risktable() +
    scale_y_continuous(limits = c(0,1))
})


# a function that can be used to test univariant cox regression (does not necessarily have to be changed)
testCoxph = function(time, status, variable) {
  result = coxph(Surv(time, status) ~ variable) %>% summary
  
  return(result$coefficients)
}

# Write an anonymous function that takes a gene name as input (g), and calculates univariant cox regression
# This is a way to calculate cox regression for all your genes
# hint: you may need to create some local data to use as input
# hint: lapply returns the output as a list and can be collapsed by bind_rows (if the content of the list are data.frames)
allCox = geneData$GeneName %>% 
  lapply(\(g) {
    #some code here
  }) %>% 
  bind_rows %>% 
  set_rownames(geneData$GeneName)

# Some code to plot all significant genes (does not necessarily have to be changed)
allCox %>% 
  rownames_to_column("Genename") %>% 
  subset(`Pr(>|z|)` < 0.05) %>% 
  arrange(`Pr(>|z|)`) %>% 
  mutate(Genename = factor(Genename, levels = Genename)) %>% 
  ggplot(aes(x = Genename, y = -log10(`Pr(>|z|)`))) +
  geom_point() +
  theme(axis.text.x = element_text(angle = -90, hjust = 0))



# Add a column to LABKA which holds the date difference between sugery and SampleDate
# This is useful when you have different data in different objects and merge/joins are not good options
# hint: some values may be converted to a wrong type and have to be coerced back to a date by as.Date()
LABKA %<>% 
  mutate(timeFromSurgery = apply(., 1, \(r) {
    #some code here
  }))



# Use sapply to loop though each PatientID and get the BMI of the patient, as well as getting the sampling
# closest to surgery. Then return BMI and the value for cholesterol (NPU01566) and the timeFromSurgery
# hint: you can return multiple values by return(c(name = value, name2 = value2))
timeTolerance = 365 #The sampling data has to be within this many days from surgery
cholesterol = sapply(patientData$PatientID, \(id) {

  if() { #if data was found
    return(c(BMI = ?, 
             value = ?, 
             timeFromSurgery = ?))
  } else { #return some standard
    return(c(BMI = NA, 
             value = NA, 
             timeFromSurgery = NA))
  }
}) %>% 
  t %>% 
  data.frame

# Plot something based on BMI and cholesterol (does not necessarily have to be changed)
cholesterol %>% 
  ggplot(aes(x = BMI, y = value)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)



