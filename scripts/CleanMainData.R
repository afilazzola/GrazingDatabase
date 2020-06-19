### Clean all the grazing data
data <- read.csv("data//grazingData.csv", stringsAsFactors = F)

names(data)

## Create a consistent taxa column based on phylum
data[data$Taxa %in% c("plants","Plants"), "Taxa"] <- "Plantae"
data[data$Taxa %in% c("Soil microbe","Soil microbia","Soil microbes"),"Taxa"] <- "Microbes"
data[data$Taxa %in% c("Arthropda", "Formicidae","Insecta","Orthoptera"),"Taxa"] <- "Arthropoda"
data[data$Taxa == "Nematode", "Taxa"] <- "Nematoda"
data[data$Taxa == "Amphibians", "Taxa"] <- "Amphibian"

## Create consistent stats terms
unique(data$Stat)
data[data$Stat == "Mean", "Stat"] <- "mean"
data[data$Stat %in% c("Count","N"), "Stat"] <- "count"
data[data$Stat %in% c("se","standard error","Standard error")  , "Stat"] <- "SE"
data[data$Stat == "sd", "Stat"] <- "StDev"
