####Parameters####
args = commandArgs(trailingOnly=TRUE)
if (length(args)!= 2){
  stop("Incorrect number of arguments", call.=FALSE)
}
#args[1] = input file
#args[2] = out prefix

####Dependencies####
if(!require("taxize")) install.packages("taxize")
library(taxize)
Sys.setenv(ENTREZ_KEY= "8c93f74a2e39daba090d57176061651dcb08")

####read in####
#setwd("~/R/Kaiju_wrangling/")
#rawTable<-read.csv("Kaiju_nr_euk_TaxaAbundance.csv", header = F)

rawTable<-read.csv(args[1], header = F)
colnames(rawTable)<- c("sample","count","txid")

####Retrieve taxa information####
# retreive all unique Taxa discounting the unclassified
txID<-levels(as.factor(rawTable$txid))[-1]

#batch classifiying using Taxize
classifyBatch <-function(start, end , txID){
  tryCatch({
    classified<-classification(sci_id = txID[start:end], db = "ncbi")
    return(classified)
  }, warning = function(w) {
    print(w)
  }, error = function(e) {
    print(paste0(e," start:",start, " end:", end))
    return(classifyBatch(start, end, txID))
  }, finally = {
    #cleanup-code
  })
}

taxaTable<- list()
for(i in c(1:round(length(txID)/100, digits = 0))){
  start<- ((i-1)*100)+1
  end<- i*100
  if( end > length(txID)) end <- length(txID)
  taxaTable<-c(taxaTable,classifyBatch(start, end, txID))
}

####Format as Table####
#set ranks to retrieve
desiredRanks<- c("superkingdom","phylum","class","order","family","genus","species")
newTaxaTable<- data.frame()

for(i in 1:length(taxaTable)){
  taxEntry<-as.data.frame(taxaTable[i])
colnames(taxEntry)<- c("name","rank","id")
row<-c(txID[i])
for (rank in desiredRanks) {
  name<-taxEntry$name[taxEntry$rank == rank]
  if(length(name)==0) name <- NA
  id<-taxEntry$id[taxEntry$rank == rank]
  if(length(id)==0) id <- NA
  
  row<-c(row,name,id)
}
newTaxaTable<-rbind(newTaxaTable,row)
}

colnames(newTaxaTable)<-c("txid",rbind(desiredRanks,gsub(pattern = "$", replacement = ".id", x = desiredRanks)))

####Make Phyloseq Tables####
#otuTable
#reshape data
otuTable<-as.matrix(reshape(rawTable, direction = "wide", timevar = "sample", idvar = "txid", v.names = "count"))
#change NA to 0
otuTable[is.na(otuTable)]<- 0
#alter column and row names
colnames(otuTable) <- gsub( pattern = "^count.", "", colnames(otuTable))
row.names(otuTable)<-otuTable[,1]
otuTable<-otuTable[,-1]

#taxaTable
taxaTable<- as.matrix(newTaxaTable[,which(colnames(newTaxaTable) %in% desiredRanks)])
rownames(taxaTable)<-newTaxaTable[,1]

#write to file
write.csv(otuTable,paste0(args[2], "_OTUtable.csv"), quote = F)
write.csv(taxaTable,paste0(args[2], "_TAXtable.csv"), quote = F)
