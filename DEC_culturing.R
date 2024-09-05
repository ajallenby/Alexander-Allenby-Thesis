#December Culturing
library(ggplot2)
theme_set(theme_classic())
library(ggpubr)
library(stringr)
library(plyr)
setwd("D:/OneDrive/OneDrive - Queen's University Belfast/Documents/R/Consortia/Methane_Consumption")
####functions####
makeAreaLinearModel<-function(standardsDF, samplesDF, timeStamp){
  TnCal<-glm(as.numeric(sample)~Area, data = standardsDF)
  TnIntercept <- TnCal$coefficients["(Intercept)"]
  TnGradient <- TnCal$coefficients["Area"]
  TnPredictedPercentage<- samplesDF$Area * TnGradient + TnIntercept
  TnResults<-cbind(rep(timeStamp, nrow(samplesDF)),samplesDF$sample,as.numeric(TnPredictedPercentage))
  colnames(TnResults) <- c("timeStage","sampleID", "percentageMethane")
  return(TnResults)
}

####read in ####
events<-read.csv("Events.csv", row.names = 2)
#T0
T0Peaks<-read.csv("T0_InjectionResult.csv",header=T)
T0Peaks<-T0Peaks[order(T0Peaks$X.),] #order peaks by time
T0CombiPeakArea<-cbind(Area=T0Peaks$Area[T0Peaks$Signal.description =="FID1A"]/T0Peaks$Area[T0Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T0Peaks<-T0Peaks[T0Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T0Injections<-read.csv("T0_injectionIndex.csv",header=F)
colnames(T0Injections) <- c("sample")
T0AltTable<-cbind(T0Injections,T0CombiPeakArea) #combine injections and peaks
T0Table<-cbind(T0Injections,T0Peaks) #combine injections and peaks
#T0Table<-T0Table[T0Table[,2]=="",-2]
#T0AltTable<-T0AltTable[T0AltTable[,2]=="",-2]
#split into sample and standard
T0AltStandards<-T0AltTable[str_detect(T0AltTable$sample, "^[0-9]*$"),]
T0AltSamples<-T0AltTable[str_detect(T0AltTable$sample, "^[0-9]*$", negate = T),]
T0AltResults<-as.data.frame(makeAreaLinearModel(T0AltStandards, T0AltSamples, "T0")) #convert measurements to percentage methane
#split into sample and standard
T0Standards<-T0Table[str_detect(T0Table$sample, "^[0-9]*$"),]
T0Samples<-T0Table[str_detect(T0Table$sample, "^[0-9]*$", negate = T),]
T0Results<-as.data.frame(makeAreaLinearModel(T0Standards, T0Samples, "T0")) #convert measurements to percentage methane
#average measures
T0AltResults$percentageMethane<-as.numeric(T0AltResults$percentageMethane)
T0AltMeanResults<-aggregate.data.frame(T0AltResults, by =list(T0AltResults$sampleID), FUN = mean)[,c(1,4)]
T0AltResults<-cbind(timeStage = rep("T0",nrow(T0AltMeanResults)), sampleID=T0AltMeanResults$Group.1, percentageMethane=T0AltMeanResults$percentageMethane)
#average measures
T0Results$percentageMethane<-as.numeric(T0Results$percentageMethane)
T0MeanResults<-aggregate.data.frame(T0Results, by =list(T0Results$sampleID), FUN = mean)[,c(1,4)]
T0Results<-cbind(timeStage = rep("T0",nrow(T0MeanResults)), sampleID=T0MeanResults$Group.1, percentageMethane=T0MeanResults$percentageMethane)

#T1
T1Peaks<-read.csv("T1_InjectionResult.csv",header=T)
T1Peaks<-T1Peaks[order(T1Peaks$X.),] #order peaks by time
T1CombiPeakArea<-cbind(Area=T1Peaks$Area[T1Peaks$Signal.description =="FID1A"]/T1Peaks$Area[T1Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T1Peaks<-T1Peaks[T1Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T1Injections<-read.csv("T1_injectionIndex.csv",header=F)
colnames(T1Injections) <- c("sample")
T1AltTable<-cbind(T1Injections,T1CombiPeakArea) #combine injections and peaks
T1Table<-cbind(T1Injections,T1Peaks) #combine injections and peaks
T1Table<-T1Table[T1Table[,2]=="",-2]
T1AltTable<-T1AltTable[T1AltTable[,2]=="",-2]
#split into sample and standard
T1AltStandards<-T1AltTable[str_detect(T1AltTable$sample, "^[0-9]*$"),]
T1AltSamples<-T1AltTable[str_detect(T1AltTable$sample, "^[0-9]*$", negate = T),]
T1AltResults<-as.data.frame(makeAreaLinearModel(T1AltStandards, T1AltSamples, "T1")) #convert measurements to percentage methane
#split into sample and standard
T1Standards<-T1Table[str_detect(T1Table$sample, "^[0-9]*$"),]
T1Samples<-T1Table[str_detect(T1Table$sample, "^[0-9]*$", negate = T),]
T1Results<-as.data.frame(makeAreaLinearModel(T1Standards, T1Samples, "T1")) #convert measurements to percentage methane
#average measures
T1AltResults$percentageMethane<-as.numeric(T1AltResults$percentageMethane)
T1AltMeanResults<-aggregate.data.frame(T1AltResults, by =list(T1AltResults$sampleID), FUN = mean)[,c(1,4)]
T1AltResults<-cbind(timeStage = rep("T1",nrow(T1AltMeanResults)), sampleID=T1AltMeanResults$Group.1, percentageMethane=T1AltMeanResults$percentageMethane)
#average measures
T1Results$percentageMethane<-as.numeric(T1Results$percentageMethane)
T1MeanResults<-aggregate.data.frame(T1Results, by =list(T1Results$sampleID), FUN = mean)[,c(1,4)]
T1Results<-cbind(timeStage = rep("T1",nrow(T1MeanResults)), sampleID=T1MeanResults$Group.1, percentageMethane=T1MeanResults$percentageMethane)

#T2
T2Peaks<-read.csv("T2_InjectionResult.csv",header=T)
T2Peaks<-T2Peaks[order(T2Peaks$X.),] #order peaks by time
T2CombiPeakArea<-cbind(Area=T2Peaks$Area[T2Peaks$Signal.description =="FID1A"]/T2Peaks$Area[T2Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T2Peaks<-T2Peaks[T2Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T2Injections<-read.csv("T2_injectionIndex.csv",header=F)
colnames(T2Injections) <- c("sample")
T2AltTable<-cbind(T2Injections,T2CombiPeakArea) #combine injections and peaks
T2Table<-cbind(T2Injections,T2Peaks) #combine injections and peaks
#T2Table<-T2Table[T2Table[,2]=="",-2]
#T2AltTable<-T2AltTable[T2AltTable[,2]=="",-2]
#split into sample and standard
T2AltStandards<-T2AltTable[str_detect(T2AltTable$sample, "^[0-9]*$"),]
T2AltSamples<-T2AltTable[str_detect(T2AltTable$sample, "^[0-9]*$", negate = T),]
T2AltResults<-as.data.frame(makeAreaLinearModel(T2AltStandards, T2AltSamples, "T2")) #convert measurements to percentage methane
#split into sample and standard
T2Standards<-T2Table[str_detect(T2Table$sample, "^[0-9]*$"),]
T2Samples<-T2Table[str_detect(T2Table$sample, "^[0-9]*$", negate = T),]
T2Results<-as.data.frame(makeAreaLinearModel(T2Standards, T2Samples, "T2")) #convert measurements to percentage methane
#average measures
T2AltResults$percentageMethane<-as.numeric(T2AltResults$percentageMethane)
T2AltMeanResults<-aggregate.data.frame(T2AltResults, by =list(T2AltResults$sampleID), FUN = mean)[,c(1,4)]
T2AltResults<-cbind(timeStage = rep("T2",nrow(T2AltMeanResults)), sampleID=T2AltMeanResults$Group.1, percentageMethane=T2AltMeanResults$percentageMethane)
#average measures
T2Results$percentageMethane<-as.numeric(T2Results$percentageMethane)
T2MeanResults<-aggregate.data.frame(T2Results, by =list(T2Results$sampleID), FUN = mean)[,c(1,4)]
T2Results<-cbind(timeStage = rep("T2",nrow(T2MeanResults)), sampleID=T2MeanResults$Group.1, percentageMethane=T2MeanResults$percentageMethane)

#T3
T3Peaks<-read.csv("T3_InjectionResult.csv",header=T)
T3Peaks<-T3Peaks[order(T3Peaks$X.),] #order peaks by time
T3CombiPeakArea<-cbind(Area=T3Peaks$Area[T3Peaks$Signal.description =="FID1A"]/T3Peaks$Area[T3Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T3Peaks<-T3Peaks[T3Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T3Injections<-read.csv("T3_injectionIndex.csv",header=F)
colnames(T3Injections) <- c("sample")
T3AltTable<-cbind(T3Injections,T3CombiPeakArea) #combine injections and peaks
T3Table<-cbind(T3Injections,T3Peaks) #combine injections and peaks
T3Table<-T3Table[T3Table[,2]=="",-2]
T3AltTable<-T3AltTable[T3AltTable[,2]=="",-2]
#split into sample and standard
T3AltStandards<-T3AltTable[str_detect(T3AltTable$sample, "^[0-9]*$"),]
T3AltSamples<-T3AltTable[str_detect(T3AltTable$sample, "^[0-9]*$", negate = T),]
T3AltResults<-as.data.frame(makeAreaLinearModel(T3AltStandards, T3AltSamples, "T3")) #convert measurements to percentage methane
#split into sample and standard
T3Standards<-T3Table[str_detect(T3Table$sample, "^[0-9]*$"),]
T3Samples<-T3Table[str_detect(T3Table$sample, "^[0-9]*$", negate = T),]
T3Results<-as.data.frame(makeAreaLinearModel(T3Standards, T3Samples, "T3")) #convert measurements to percentage methane
#average measures
T3AltResults$percentageMethane<-as.numeric(T3AltResults$percentageMethane)
T3AltMeanResults<-aggregate.data.frame(T3AltResults, by =list(T3AltResults$sampleID), FUN = mean)[,c(1,4)]
T3AltResults<-cbind(timeStage = rep("T3",nrow(T3AltMeanResults)), sampleID=T3AltMeanResults$Group.1, percentageMethane=T3AltMeanResults$percentageMethane)
#average measures
T3Results$percentageMethane<-as.numeric(T3Results$percentageMethane)
T3MeanResults<-aggregate.data.frame(T3Results, by =list(T3Results$sampleID), FUN = mean)[,c(1,4)]
T3Results<-cbind(timeStage = rep("T3",nrow(T3MeanResults)), sampleID=T3MeanResults$Group.1, percentageMethane=T3MeanResults$percentageMethane)

#T4
T4Peaks<-read.csv("T4_InjectionResult.csv",header=T)
T4Peaks<-T4Peaks[order(T4Peaks$X.),] #order peaks by time
T4CombiPeakArea<-cbind(Area=T4Peaks$Area[T4Peaks$Signal.description =="FID1A"]/T4Peaks$Area[T4Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T4Peaks<-T4Peaks[T4Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T4Injections<-read.csv("T4_injectionIndex.csv",header=F)
colnames(T4Injections) <- c("sample")
T4AltTable<-cbind(T4Injections,T4CombiPeakArea) #combine injections and peaks
T4Table<-cbind(T4Injections,T4Peaks) #combine injections and peaks
#T4Table<-T4Table[T4Table[,2]=="",-2]
#T4AltTable<-T4AltTable[T4AltTable[,2]=="",-2]
#split into sample and standard
T4AltStandards<-T4AltTable[str_detect(T4AltTable$sample, "^[0-9]*$"),]
T4AltSamples<-T4AltTable[str_detect(T4AltTable$sample, "^[0-9]*$", negate = T),]
T4AltResults<-as.data.frame(makeAreaLinearModel(T4AltStandards, T4AltSamples, "T4")) #convert measurements to percentage methane
#split into sample and standard
T4Standards<-T4Table[str_detect(T4Table$sample, "^[0-9]*$"),]
T4Samples<-T4Table[str_detect(T4Table$sample, "^[0-9]*$", negate = T),]
T4Results<-as.data.frame(makeAreaLinearModel(T4Standards, T4Samples, "T4")) #convert measurements to percentage methane
#average measures
T4AltResults$percentageMethane<-as.numeric(T4AltResults$percentageMethane)
T4AltMeanResults<-aggregate.data.frame(T4AltResults, by =list(T4AltResults$sampleID), FUN = mean)[,c(1,4)]
T4AltResults<-cbind(timeStage = rep("T4",nrow(T4AltMeanResults)), sampleID=T4AltMeanResults$Group.1, percentageMethane=T4AltMeanResults$percentageMethane)
#average measures
T4Results$percentageMethane<-as.numeric(T4Results$percentageMethane)
T4MeanResults<-aggregate.data.frame(T4Results, by =list(T4Results$sampleID), FUN = mean)[,c(1,4)]
T4Results<-cbind(timeStage = rep("T4",nrow(T4MeanResults)), sampleID=T4MeanResults$Group.1, percentageMethane=T4MeanResults$percentageMethane)

#T5
T5Peaks<-read.csv("T5_InjectionResult.csv",header=T)
T5Peaks<-T5Peaks[order(T5Peaks$X.),] #order peaks by time
T5CombiPeakArea<-cbind(Area=T5Peaks$Area[T5Peaks$Signal.description =="FID1A"]/T5Peaks$Area[T5Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T5Peaks<-T5Peaks[T5Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T5Injections<-read.csv("T5_injectionIndex.csv",header=F)
colnames(T5Injections) <- c("sample")
T5AltTable<-cbind(T5Injections,T5CombiPeakArea) #combine injections and peaks
T5Table<-cbind(T5Injections,T5Peaks) #combine injections and peaks
T5Table<-as.data.frame(T5Table[T5Table[,2]=="",-2])
T5AltTable<-as.data.frame(T5AltTable[T5AltTable[,2]=="",-2])
#split into sample and standard
T5AltStandards<-T5AltTable[str_detect(T5AltTable$sample, "^[0-9]*$"),]
T5AltSamples<-T5AltTable[str_detect(T5AltTable$sample, "^[0-9]*$", negate = T),]
T5AltResults<-as.data.frame(makeAreaLinearModel(T5AltStandards, T5AltSamples, "T5")) #convert measurements to percentage methane
#split into sample and standard
T5Standards<-T5Table[str_detect(T5Table$sample, "^[0-9]*$"),]
T5Samples<-T5Table[str_detect(T5Table$sample, "^[0-9]*$", negate = T),]
T5Results<-as.data.frame(makeAreaLinearModel(T5Standards, T5Samples, "T5")) #convert measurements to percentage methane
#average measures
T5AltResults$percentageMethane<-as.numeric(T5AltResults$percentageMethane)
T5AltMeanResults<-aggregate.data.frame(T5AltResults, by =list(T5AltResults$sampleID), FUN = mean)[,c(1,4)]
T5AltResults<-cbind(timeStage = rep("T5",nrow(T5AltMeanResults)), sampleID=T5AltMeanResults$Group.1, percentageMethane=T5AltMeanResults$percentageMethane)
#average measures
T5Results$percentageMethane<-as.numeric(T5Results$percentageMethane)
T5MeanResults<-aggregate.data.frame(T5Results, by =list(T5Results$sampleID), FUN = mean)[,c(1,4)]
T5Results<-cbind(timeStage = rep("T5",nrow(T5MeanResults)), sampleID=T5MeanResults$Group.1, percentageMethane=T5MeanResults$percentageMethane)

#T6
T6Peaks<-read.csv("T6_InjectionResult.csv",header=T)
T6Peaks<-T6Peaks[order(T6Peaks$X.),] #order peaks by time
str(T6Peaks)
T6CombiPeakArea<-cbind(Area=T6Peaks$Area[T6Peaks$Signal.description =="FID1A"]/T6Peaks$Area[T6Peaks$Signal.description =="TCD2B"])#Combine FIDandTCD
T6Peaks<-T6Peaks[T6Peaks$Signal.description =="FID1A",] #Remove TCD peaks
T6Injections<-read.csv("T6_injectionIndex.csv",header=F)
colnames(T6Injections) <- c("sample")
T6AltTable<-cbind(T6Injections,T6CombiPeakArea) #combine injections and peaks
T6Table<-cbind(T6Injections,T6Peaks) #combine injections and peaks
T6Table<-as.data.frame(T6Table[T6Table[,2]=="",-2])
T6AltTable<-as.data.frame(T6AltTable[T6AltTable[,2]=="",-2])
#split into sample and standard
T6AltStandards<-T6AltTable[str_detect(T6AltTable$sample, "^[0-9]*$"),]
T6AltSamples<-T6AltTable[str_detect(T6AltTable$sample, "^[0-9]*$", negate = T),]
T6AltResults<-as.data.frame(makeAreaLinearModel(T6AltStandards, T6AltSamples, "T6")) #convert measurements to percentage methane
#split into sample and standard
T6Standards<-T6Table[str_detect(T6Table$sample, "^[0-9]*$"),]
T6Samples<-T6Table[str_detect(T6Table$sample, "^[0-9]*$", negate = T),]
T6Results<-as.data.frame(makeAreaLinearModel(T6Standards, T6Samples, "T6")) #convert measurements to percentage methane
#average measures
T6AltResults$percentageMethane<-as.numeric(T6AltResults$percentageMethane)
T6AltMeanResults<-aggregate.data.frame(T6AltResults, by =list(T6AltResults$sampleID), FUN = mean)[,c(1,4)]
T6AltResults<-cbind(timeStage = rep("T6",nrow(T6AltMeanResults)), sampleID=T6AltMeanResults$Group.1, percentageMethane=T6AltMeanResults$percentageMethane)
#average measures
T6Results$percentageMethane<-as.numeric(T6Results$percentageMethane)
T6MeanResults<-aggregate.data.frame(T6Results, by =list(T6Results$sampleID), FUN = mean)[,c(1,4)]
T6Results<-cbind(timeStage = rep("T6",nrow(T6MeanResults)), sampleID=T6MeanResults$Group.1, percentageMethane=T6MeanResults$percentageMethane)


#combineTimepoints
results<-data.frame(rbind(T0Results,T1Results,T2Results,T3Results,T4Results,T5Results,T6Results), altPercentageMethane=as.numeric(as.data.frame(rbind(T0AltResults,T1AltResults,T2AltResults,T3AltResults,T4AltResults,T5AltResults,T6AltResults))[,3]))

str(results)
results$percentageMethane <- as.numeric(results$percentageMethane)

####Add more data####
#Get treatment type from sampleID
sampleInfo<-as.data.frame(str_split(results$sampleID, "\\.", simplify = T))
project<-sampleInfo[,5]
project[project==""]<-"consortia"
project[project!="consortia"]<-"enrichment"
sampleInfo<-cbind(sampleInfo[,1:4], project)
colnames(sampleInfo)<-c("consortia","media","isotope","timepoint","project")
results<-cbind(results,sampleInfo)
results[sapply(results, is.character)] <- lapply(results[sapply(results, is.character)], as.factor)
results$timeStage<-factor(results$timeStage,levels(results$timeStage)[order(as.numeric(str_extract(levels(results$timeStage), "[0-9]+")))]) #order timpoints properly
str(results)

results<-cbind(results, days =events[as.character(results$timeStage),5])

####Make Figures####
results.Consortia<-results[results$project=="consortia",]
write.csv(results.Consortia,"PercentageMethane.csv")
results.Consortia<-read.csv("PercentageMethane.csv", row.names = 1)
#transform abbreviations
results.Consortia$consortia[results.Consortia$consortia=="S"]<-"Sediment"
results.Consortia$consortia[results.Consortia$consortia=="W"]<-"Wall"
results.Consortia$media[results.Consortia$media=="C"]<-"NMS+Ce"
results.Consortia$media[results.Consortia$media=="N"]<-"NMS"
results.Consortia$media[results.Consortia$media=="O"]<-"NMS+Ore"


ggplot(results.Consortia, aes(x=days, y= altPercentageMethane, group=sampleID, colour = media))+
  geom_point()+
  geom_line()+
  ylab("Percentage Methane")+
  xlab( "Days")+
  labs(colour= "Media")

ggplot(results.Consortia, aes(x=days, y= altPercentageMethane, group=sampleID, colour = media))+
  facet_grid(~consortia)+
  geom_point()+
  geom_line()+
  ylab("Percentage Methane")+
  xlab( "Days")+
  labs(colour= "Media")

ggplot(results[results$project=="consortia"& results$consortia=="S",], aes(x=days, y= altPercentageMethane, group=sampleID, colour = media))+
  geom_point()+
  geom_line()+
  ylab("Percentage Methane")+
  xlab( "Days")+
  labs(colour= "Media")

ggplot(results.Consortia, aes(x=days, y= altPercentageMethane, colour= consortia, group=sampleID, shape = media))+
  geom_point()+
  geom_line()+
  ylab("Percentage Methane")+
  xlab( "Days")+
  labs(colour ="Consortia", shape = "Media")

ggplot(results.Consortia, aes(x=timeStage, y= altPercentageMethane, colour= paste(consortia, media)))+
  geom_boxplot()+
  geom_line(aes(x=timeStage, y= altPercentageMethane, colour= consortia, group=sampleID, shape = media))
  


ggplot(results[results$project=="consortia",], aes(x=timeStage, y= altPercentageMethane, colour= consortia, group=sampleID, shape = media))+
  geom_point()+
  geom_boxplot(aes(x= timeStage, y = altPercentageMethane, colour= paste(consortia, media)))+
  geom_line()


results.Consortia<-results.Consortia[results.Consortia$sampleID!="S.O.A",] #remove outlier
meanConsortiaValues<-aggregate.data.frame(x = results.Consortia, by = list(timeStage =results.Consortia$timeStage, consortia = results.Consortia$consortia, media =results.Consortia$media ), FUN = mean)[c(1:3,6:7,13)]
sdConsortiaValues<-aggregate.data.frame(x = results.Consortia, by = list(timeStage =results.Consortia$timeStage, consortia = results.Consortia$consortia, media =results.Consortia$media ), FUN = sd)
meanConsortiaValues$percentageMethane.sd <-sdConsortiaValues$percentageMethane
meanConsortiaValues$altPercentageMethane.sd <-sdConsortiaValues$altPercentageMethane
meanConsortiaValues$umol<-meanConsortiaValues$altPercentageMethane/100*0.1/22.4*10^6
meanConsortiaValues$SDumol<-meanConsortiaValues$altPercentageMethane.sd/100*0.1/22.4*10^6
meanConsortiaValues[order(meanConsortiaValues$timeStage,meanConsortiaValues$consortia,meanConsortiaValues$media),]
meanConsortiaValues$umol.Incorporated <-meanConsortiaValues$umol[meanConsortiaValues$timeStage=="T0"]-meanConsortiaValues$umol

ggplot(data =meanConsortiaValues, aes(days, altPercentageMethane, group = paste(consortia, media), colour = media))+
  geom_line()+
  geom_pointrange(aes(ymin=altPercentageMethane-altPercentageMethane.sd, ymax=altPercentageMethane+altPercentageMethane.sd, shape = consortia))+
  ylab("Percentage Methane")+
  xlab( "Timepoint")+
  labs(colour ="Consorita and Media")

ggplot(data =meanConsortiaValues, aes(days, umol, group = paste(consortia, media), colour = media))+
  facet_wrap( ~ consortia)+
  geom_line()+
  geom_point(aes(shape = consortia), size =5)+
  geom_errorbar(aes(ymin=umol-SDumol, ymax=umol+SDumol), width=0.1)+
  ylab(expression(CH[4]~"\U03BCmol incorporated" ))+
  xlab( "Days")+
  labs(colour ="Consorita and Media")

ggplot(data =meanConsortiaValues, aes(days, umol.Incorporated, group = paste(consortia, media), colour = media))+
  facet_wrap( ~ consortia)+
  geom_line()+
  geom_point(aes(shape = consortia), size =5)+
  geom_errorbar(aes(ymin=umol.Incorporated-SDumol, ymax=umol.Incorporated+SDumol), width=0.1)+
  ylab(expression(CH[4]~"\U03BCmol incorporated" ))+
  xlab( "Days")+
  labs(colour ="Consorita and Media")

ggplot(data =meanConsortiaValues, aes(days, altPercentageMethane, group = paste(consortia, media), colour = media))+
  facet_wrap( ~ consortia)+
  geom_line()+
  geom_point(aes(shape = consortia), size =5)+
  geom_errorbar(aes(ymin=altPercentageMethane-altPercentageMethane.sd, ymax=altPercentageMethane+altPercentageMethane.sd), width=0.1)+
  ylab("Percentage Methane")+
  xlab( "Days")+
  labs(colour ="Consorita and Media")

ggplot(results.Consortia, aes(x=timeStage, y= altPercentageMethane, colour= paste(consortia, media)))+
  geom_boxplot()+
  geom_line(data =meanConsortiaValues, aes(timeStage, altPercentageMethane, group = paste(consortia, media)))+
  ylab("Percentage Methane")+
  xlab( "Timepoint")+
  labs(colour ="Consorita and Media")




geom_line(aes(group=sampleID), alpha=0.5)

ggplot(results[results$project=="enrichment",], aes(x=timeStage, y= percentageMethane, colour= consortia, group=sampleID, shape = media))+
  geom_point()+
  geom_line()

ggplot(results[results$project=="enrichment",], aes(x=timeStage, y= altPercentageMethane, colour= consortia, group=sampleID, shape = media))+
  geom_point()+
  geom_line()

ggplot(results[results$project=="enrichment"& results$consortia=="W" & results$media == "C",], aes(x=timeStage, y= altPercentageMethane, colour= timepoint, group=sampleID, shape = media))+
  geom_point()+
  geom_line()

ggplot(results[results$project=="enrichment"& results$consortia=="S",], aes(x=timeStage, y= altPercentageMethane, colour= consortia, group=sampleID, shape = media))+
  geom_point()+
  geom_line()

ggplot(results[results$project=="enrichment",], aes(x=timeStage, y= altPercentageMethane, colour=paste(consortia,media)))+
  geom_boxplot()

ggplot(results[results$project=="enrichment"& results$consortia=="W",], aes(x=timeStage, y= altPercentageMethane, colour=paste(consortia,media)))+
  geom_boxplot()


T1<-results[results$timeStage == "T1",]
T1<-T1[order(T1$sampleID),]

T6<-results[results$timeStage == "T6",]
T6<-T6[order(T6$sampleID),]

T1$sampleID==T6$sampleID

differenceTotal<-cbind(T1[,c(2,5:9)], difference=(T1$altPercentageMethane - T6$altPercentageMethane))
differenceTotal$uM.CH4.consumed <- (differenceTotal$difference/22400)*1000000

#alternative uMol carbon incorporated: and include error
summary(as.factor(results.noOutliers$timeStage))
results.noOutliers<-results.Consortia
results.noOutliers<-results.noOutliers[order(results.noOutliers$timeStage, results.noOutliers$sampleID),]
results.noOutliers$percentageMethaneIncorporated<-abs(results.noOutliers$altPercentageMethane-results.noOutliers$altPercentageMethane[results.noOutliers$timeStage=="T0"])
results.noOutliers$percentageMethaneIncorporated

meanConsortiaValues<-aggregate.data.frame(x = results.noOutliers, by = list(timeStage =results.noOutliers$timeStage, consortia = results.noOutliers$consortia, media =results.noOutliers$media ), FUN = mean)
sdConsortiaValues<-aggregate.data.frame(x = results.noOutliers, by = list(timeStage =results.noOutliers$timeStage, consortia = results.noOutliers$consortia, media =results.noOutliers$media ), FUN = sd)

meanConsortiaValues$percentageMethaneIncorporated.sd<-sdConsortiaValues$percentageMethaneIncorporated

meanConsortiaValues$umolIncorporated<-((meanConsortiaValues$percentageMethaneIncorporated/1000)/22.4)*10^6
meanConsortiaValues$SDumolIncorporated<-((meanConsortiaValues$percentageMethaneIncorporated.sd/1000)/22.4)*10^6
meanConsortiaValues<-meanConsortiaValues[,-c(4:5,8:12)]

ggplot(data =meanConsortiaValues, aes(days, umolIncorporated, group = paste(consortia, media), colour = media))+
  facet_wrap( ~ consortia)+
  geom_line()+
  geom_point(aes(shape = consortia), size =5)+
  geom_errorbar(aes(ymin=umolIncorporated-SDumolIncorporated, ymax=umolIncorporated+SDumolIncorporated), width=0.1)+
  ylab(expression(CH[4]~"\U03BCmol incorporated" ))+
  xlab( "Days")+
  labs(colour ="Consorita and Media")

meanConsortiaValues[meanConsortiaValues$timeStage=="T6",]

####stats####
results.Consortia
results.Consortia<-results.Consortia[results.Consortia$sampleID!="S.O.A",]
results.Consortia<-results.Consortia[order(results.Consortia$timeStage, results.Consortia$sampleID),]
results.Consortia$percentageMethaneIncorporated<-abs(results.Consortia$altPercentageMethane-results.Consortia$altPercentageMethane[results.Consortia$timeStage=="T0"])
results.Consortia.Final<- results.Consortia[results.Consortia$timeStage=="T6",]
aov(percentageMethaneIncorporated ~ consortia + media, data = results.Consortia.Final)
