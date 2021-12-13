## Detailed taxa fill
library(rgbif)


grazingDB <- read.csv("data//grazingData.csv")

## find unique genus
allGenus <- unique(grazingDB$Genus)

test <- name_lookup("Euchorthippus", limit=20, verbose=F, rank="genus")
test$data$kingdom


## loop through all the species
genusDF <- data.frame()
for(i in allGenus){
  tryCatch({
  gbifDF <- name_lookup(i, limit=20)
  tempDF <- data.frame(Genus=i, kingdom = gbifDF$data$kingdom[1], 
                                 phylum=gbifDF$data$phylum[1], 
                                 order=gbifDF$data$order[1],
                                 class=gbifDF$data$class[1],
                                 family=gbifDF$data$family[1])
  genusDF <- rbind(genusDF, tempDF)
  
  }, error = function(e) e)
  print(i)
}

write.csv(genusDF, "data//genusDetails.csv", row.names=FALSE)


genusDF <- read.csv("data//genusDetails.csv")


addTaxa <- merge(grazingDB, genusDF, by="Genus")
write.csv(addTaxa, "revisedDB.csv")
