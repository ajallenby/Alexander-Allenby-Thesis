#Makes IToL Annotations for MOB genomes Hits
#dependencies
library(stringr)
library(RColorBrewer)

#get arguments
args = commandArgs(trailingOnly=TRUE)
if (length(args)!= 3){
  stop("Incorrect number of arguments: infotable, taxa_level, output", call.=FALSE)
}

####Debugging####
#setwd("~/Documents/MOBs/genomes_131223/")
#args<-vector()
#args[1]<- "testHeaders.txt"
#args[2]<- "genomes_v2_taxonomy_expanded.csv"
#args[3]<- "testOut_"
#################

raw<-read.table(args[1], header = F)$V1
headers<-str_remove(str_sub(raw, start = 0, end=127), "^>")
accessions<-str_extract(headers,"^GC[AF]_[0-9]+.[0-9]+")
protein <-str_remove_all(str_extract(headers, "prot_.*$"),"prot_|_[lg].*$")

MOBmeta<-read.csv(args[2], header = T, row.names = 1)

####Lables#####
write.table(file = paste0(args[3],"_labels.txt"), sep = ",", quote = F, row.names = F,col.names = F,
x ="LABELS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_labels.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     paste(accessions, MOBmeta[accessions,]$nameWithStrain, protein)))

write.table(file = paste0(args[3],"_gtdb_labels.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x ="LABELS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_gtdb_labels.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     paste(accessions, MOBmeta[accessions,]$gtdb.Species, protein)))

####NCBI Coloured Ranges####
#ncbi Phylum
phylumPalette.ncbi<-setNames(brewer.pal(length(unique(MOBmeta$ncbi.Phylum)), "Set3"), unique(MOBmeta$ncbi.Phylum))
write.table(file = paste0(args[3],"_ncbi_Phylum_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_ncbi_Phylum_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     phylumPalette.ncbi[MOBmeta[accessions,]$ncbi.Phylum],
                     MOBmeta[accessions,]$ncbi.Phylum))
#ncbi Class
ClassPalette.ncbi<-setNames(brewer.pal(length(unique(MOBmeta$ncbi.Class)), "Set3"), unique(MOBmeta$ncbi.Class))
write.table(file = paste0(args[3],"_ncbi_Class_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_ncbi_Class_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     ClassPalette.ncbi[MOBmeta[accessions,]$ncbi.Class],
                     MOBmeta[accessions,]$ncbi.Class))
#ncbi Order
OrderPalette.ncbi<-setNames(brewer.pal(length(unique(MOBmeta$ncbi.Order)), "Set3"), unique(MOBmeta$ncbi.Order))
write.table(file = paste0(args[3],"_ncbi_Order_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_ncbi_Order_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     OrderPalette.ncbi[MOBmeta[accessions,]$ncbi.Order],
                     MOBmeta[accessions,]$ncbi.Order))
#ncbi Family
FamilyPalette.ncbi<-setNames(brewer.pal(length(unique(MOBmeta$ncbi.Family)), "Set3"), unique(MOBmeta$ncbi.Family))
write.table(file = paste0(args[3],"_ncbi_Family_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_ncbi_Family_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     FamilyPalette.ncbi[MOBmeta[accessions,]$ncbi.Family],
                     MOBmeta[accessions,]$ncbi.Family))
#ncbi Genus
if(length(unique(MOBmeta$ncbi.Genus))<13){
  GenusPalette.ncbi<-setNames(brewer.pal(length(unique(MOBmeta$ncbi.Genus)), "Set3"), unique(MOBmeta$ncbi.Genus))
write.table(file = paste0(args[3],"_ncbi_Genus_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_ncbi_Genus_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     GenusPalette.ncbi[MOBmeta[accessions,]$ncbi.Genus],
                     MOBmeta[accessions,]$ncbi.Genus))
}
####GTDB Coloured Ranges####
#gtdb Phylum
phylumPalette.gtdb<-setNames(brewer.pal(length(unique(MOBmeta$gtdb.Phylum)), "Set3"), unique(MOBmeta$gtdb.Phylum))
write.table(file = paste0(args[3],"_gtdb_Phylum_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_gtdb_Phylum_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     phylumPalette.gtdb[MOBmeta[accessions,]$gtdb.Phylum],
                     MOBmeta[accessions,]$gtdb.Phylum))
#gtdb Class
ClassPalette.gtdb<-setNames(brewer.pal(length(unique(MOBmeta$gtdb.Class)), "Set3"), unique(MOBmeta$gtdb.Class))
write.table(file = paste0(args[3],"_gtdb_Class_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_gtdb_Class_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     ClassPalette.gtdb[MOBmeta[accessions,]$gtdb.Class],
                     MOBmeta[accessions,]$gtdb.Class))
#gtdb Order
OrderPalette.gtdb<-setNames(brewer.pal(length(unique(MOBmeta$gtdb.Order)), "Set3"), unique(MOBmeta$gtdb.Order))
write.table(file = paste0(args[3],"_gtdb_Order_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_gtdb_Order_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     OrderPalette.gtdb[MOBmeta[accessions,]$gtdb.Order],
                     MOBmeta[accessions,]$gtdb.Order))
#gtdb Family
FamilyPalette.gtdb<-setNames(brewer.pal(length(unique(MOBmeta$gtdb.Family)), "Set3"), unique(MOBmeta$gtdb.Family))
write.table(file = paste0(args[3],"_gtdb_Family_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
            x =" TREE_COLORS
SEPARATOR COMMA
DATA")

write.table(file = paste0(args[3],"_gtdb_Family_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
            x =cbind(headers,
                     rep("range", length(headers)),
                     FamilyPalette.gtdb[MOBmeta[accessions,]$gtdb.Family],
                     MOBmeta[accessions,]$gtdb.Family))
#gtdb Genus
if(length(unique(MOBmeta$gtdb.Genus))<13){
  GenusPalette.gtdb<-setNames(brewer.pal(length(unique(MOBmeta$gtdb.Genus)), "Set3"), unique(MOBmeta$gtdb.Genus))
  write.table(file = paste0(args[3],"_gtdb_Genus_range.txt"), sep = ",", quote = F, row.names = F,col.names = F,
              x =" TREE_COLORS
SEPARATOR COMMA
DATA")
  
  write.table(file = paste0(args[3],"_gtdb_Genus_range.txt"), sep = ",", quote = F, row.names = F,col.names = F, append = T,
              x =cbind(headers,
                       rep("range", length(headers)),
                       GenusPalette.gtdb[MOBmeta[accessions,]$gtdb.Genus],
                       MOBmeta[accessions,]$gtdb.Genus))
}

