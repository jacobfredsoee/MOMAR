library(tidyverse)
library(magrittr)

nPatients = 120
nGenes = 1000


generateGeneName = function() {
  nameLength = sample(3:7, 1)
  geneName = LETTERS[sample(1:26, size = nameLength)] %>% 
    paste0(collapse = "")
  
  if(sample(c(TRUE, FALSE), 1)) {
    geneName = paste0(geneName, sample(1:8, 1))
  }
  
  return(geneName)
}

i = 1
genes = character(length = nGenes)
while(i <= nGenes) {
  geneName = generateGeneName()
  
  #To avoid duplicates
  if(geneName %in% genes) {
    next
  }
  
  genes[i] = geneName
  i = i + 1
}

geneData = matrix(NA, nrow = nGenes, ncol = nPatients)

for(i in 1:nrow(geneData)) {
  geneData[i,] = rnorm(ncol(geneData), mean = sample(1:5, 1), sd = sample(1:3, 1))
}

geneData %<>% 
  data.frame %>% 
  set_colnames(paste0("Patient", 1:nPatients)) %>% 
  add_column(GeneName = genes, .before = 1)



patientData = data.frame(PatientID = paste0("Patient", 1:nPatients),
                         Gender = sample(c("M", "F"), nPatients, replace = TRUE),
                         Group = sample(c("Tumor", "Tumor", "Ctrl"), nPatients, replace = TRUE)) %>% 
  mutate(Height = sapply(Gender, \(g) {
    if(g == "M") height = pmax(pmin(rnorm(1, mean = 170, sd = 30), 210), 130) %>% round(0)
    if(g == "F") height = pmax(pmin(rnorm(1, mean = 150, sd = 30), 190), 120) %>% round(0)
    
    if(sample(c(0,0,0,1), 1)) height = height/100
    
    return(height)
  })) %>% 
  mutate(Weight = sapply(Gender, \(g) {
    if(g == "M") return(pmax(pmin(rnorm(1, mean = 86.4, sd = 30), 150), 55) %>% round(0))
    if(g == "F") return(pmax(pmin(rnorm(1, mean = 71.4, sd = 30), 120), 50) %>% round(0))
  })) %>% 
  mutate(Tstage = sapply(Group, \(g) {
    if(g == "Ctrl") return(NA)
    return(sample(c("T1", "T2", "T2", "T3", "T4"), 1))
  })) %>% 
  mutate(DateOfSurgery = sapply(Group, \(g) {
    if(g == "Ctrl") return(NA)
    as.Date(sample(12000:15000, size = 1), origin = "1970-01-01")
  })) %>% 
  mutate(Recurrence = sapply(Group, \(g) {
    if(g == "Ctrl") return(NA)
    return(sample(c(0, 0, 1), 1))
  })) %>% 
  mutate(TimeToRecurrence = sapply(Recurrence, \(r) {
    if(is.na(r) || r == 0) return(NA)
    return(sample(c(3:24, 10:24), 1))
  })) %>% 
  mutate(LastFollowup = apply(., 1, \(tr) {
    if(is.na(tr["Recurrence"])) return(NA)

    total = sample(c(16:48, 10:36), 1)
    if(is.na(tr["TimeToRecurrence"])) return(total)
    
    while(tr["TimeToRecurrence"] > total) {
      total = sample(c(16:48, 10:36), 1)
    }
    return(total)
  })) %>% 
  mutate(DateOfSurgery = as.Date(DateOfSurgery, origin = "1970-01-01"))

analyses = data.frame(NPUcode = c("NPU18016", "NPU02319", "NPU03429", "NPU02593", "NPU01566"),
                      AnalysisName = c("P-Kreatinin", "B-Hæmoglobin", "P-Natrium", "B-Leukocytter", "P-Kolesterol"),
                      RefInterval = c("60-105", "8.3-10.5", "137-145", "3.50-10.0","<5.0"))


LABKA = data.frame(PatientID = paste0("Patient", sample(1:nPatients, nPatients * 15, replace = TRUE))) %>% 
  mutate(SampleDate = sapply(1:nrow(.), \(i) {
    as.Date(sample(12000:15000, size = 1), origin = "1970-01-01")
  })) %>% 
  cbind(lapply(1:nrow(.), \(i) {
    analyses[sample(1:nrow(analyses), 1),]
  }) %>% 
    bind_rows) %>% 
  mutate(value = sapply(RefInterval, \(ri) {
    if(grepl("<", ri)) {
      upperBound = as.numeric(gsub("<", "", ri))
      lowerBound = 2
      avg = mean(c(upperBound, lowerBound))
      dev = upperBound - avg
      max = upperBound * 2.5
      min = lowerBound / 2.5
    }
    
    if(grepl("-", ri)) {
      interval = strsplit(ri, "-")[[1]] %>% as.numeric
      upperBound = max(interval)
      lowerBound = min(interval)
      avg = mean(c(upperBound, lowerBound))
      dev = upperBound - avg
      max = upperBound * 2.5
      min = lowerBound / 2.5
    }
    
    pmax(pmin(rnorm(1, mean = avg, sd = dev), max), min) %>% round(1)
  })) %>% 
  mutate(SampleDate = as.Date(SampleDate, origin = "1970-01-01"))

# write data to files
# write_rds(geneData, "02_files/geneData.rds")
# write_rds(LABKA, "02_files/LABKA.rds")
# write_rds(patientData, "02_files/patientData.rds")

rm(geneName, genes, i, nGenes, nPatients, generateGeneName, analyses)




