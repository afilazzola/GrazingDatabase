#### Clean up the studyData file

studyData <- read.csv("data//StudyData.csv", stringsAsFactors = F)

## Drop old columns
names(studyData)
studyData <- studyData[,!names(studyData) %in% c("grazer.spp","indigenous.grazers","grazing.frequency","DataExtract","reason","contrast")]

#### Check for misspellings
unique(studyData$exclude)
unique(studyData$grazer.status)

## Correct domesticated
studyData[studyData$grazer.status %in% c("domestic","domesticated/managed","domestivated","sheep","cattle"),"grazer.status"] <- "domesticated"
studyData[studyData$grazer.status %in% c("both","domestic, wild","mixture of domesticated and native","domesticated, native","domestic and native","cattle and indigenous"),"grazer.status"] <- "domesticated and indigenous"
studyData[studyData$grazer.status %in% c("native","wild","native grazers"),"grazer.status"] <- "indigenous"

## Correct study duration
studyData[,"study.duration"] <- as.numeric(studyData$year.finished)-as.numeric(studyData$year.initiated)+1

unique(studyData$fertilization)

## Correct inverse categories categorization
studyData[studyData$fertilization == "no;yes", "fertilization"] <- "yes;no"
studyData[studyData$publicvsprivate == "private;public", "publicvsprivate"] <- "public;private"

## Add a column whether data is present within this database
studyData <- merge(studyData, studyList, by="uniqueID", all.y=T)

