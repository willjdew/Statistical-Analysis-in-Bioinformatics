# R Test Script
# William Dew
# Feb 11, 2021
# The purpose of this script is to learn how to work in R

count<-0
primes<-c(1,3,5,7,11)
Names<-c("Bob","Ted","Carol","Alice")
Truth<-c(TRUE,FALSE,TRUE)

organism<-c("Human","Chimpanzee","Yeast")
chromosomes<-c(23, 24, 16)
multicellular<-c(TRUE, TRUE, FALSE)

OrganismTable<-data.frame(organism, chromosomes, multicellular)

write.table(OrganismTable, file = "MyData.csv",row.names=FALSE,
            na="",col.names=FALSE, sep=",")

NewDataFrame<-read.csv("MyData.csv", header=FALSE, sep=",")

count<-0
for (val in OrganismTable$chromosomes) {
  if(val > 20) count = count+1
}
print(count)
