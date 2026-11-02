setwd("G:/PROJET/Article/MODELISATION_II/HYPE/WestAfricaHYPE1.2/")
library(HYPEtools)
library(foreign)
library(tidyverse)

savePath <- "G:/PROJET/Article/HYDRO_ML/Modeling/HYPE/mouhoun/HYPEProject2"
subbasin_dbf <- read.dbf(file = "G:/PROJET/Article/HYDRO_ML/Modeling/HYPE/mouhoun/HYPEProject/gis/subbasins.dbf")

subbassin_ids <- unique(subbasin_dbf$SUBID)

Qobs <- HYPEtools::ReadPTQobs(filename = "Qobs.txt") %>% 
  select(DATE, any_of(paste0("X",subbassin_ids))) 
obsids <- sub("X","",colnames(Qobs)[-1])
attr(Qobs,"obsid") <- obsids
HYPEtools::WriteObs(x =Qobs ,filename = file.path(savePath,"Qobs.txt"))



ForcKey <- HYPEtools::ReadForcKey(filename = "ForcKey.txt")%>% 
  filter(SUBID%in%subbassin_ids) 
HYPEtools::WriteForcKey(x =ForcKey ,filename =file.path(savePath,"ForcKey.txt") )

Pobs <- HYPEtools::ReadPTQobs(filename = "Pobs.txt")%>% 
  select(DATE, any_of(paste0("X",unique(ForcKey$POBSID)))) 
obsids <- sub("X","",colnames(Pobs)[-1])
attr(Pobs,"obsid") <- obsids
HYPEtools::WriteObs(x =Pobs ,filename = file.path(savePath,"Pobs.txt"))

TMAXobs <- HYPEtools::ReadPTQobs(filename = "TMAXobs.txt")%>% 
  select(DATE, any_of(paste0("X",unique(ForcKey$TMAXOBSID)))) 

obsids <- sub("X","",colnames(TMAXobs)[-1])
attr(TMAXobs,"obsid") <- obsids
HYPEtools::WriteObs(x =TMAXobs ,filename = file.path(savePath,"TMAXobs.txt"))


TMINobs <- HYPEtools::ReadPTQobs(filename = "TMINobs.txt")%>% 
  select(DATE, any_of(paste0("X",unique(ForcKey$TMINOBSID)))) 

obsids <- sub("X","",colnames(TMINobs)[-1])
attr(TMINobs,"obsid") <- obsids
HYPEtools::WriteObs(x =TMINobs ,filename = file.path(savePath,"TMINobs.txt"))


Tobs <- HYPEtools::ReadPTQobs(filename = "Tobs.txt")%>% 
  select(DATE, any_of(paste0("X",unique(ForcKey$TMINOBSID)))) 
obsids <- sub("X","",colnames(Tobs)[-1])
attr(Tobs,"obsid") <- obsids
HYPEtools::WriteObs(x =Tobs ,filename = file.path(savePath,"Tobs.txt"))

AquiferData <- ReadAquiferData(filename = "AquiferData.txt") %>% 
  filter(SUBID%in%subbassin_ids)# RAS


CropData <- HYPEtools::ReadCropData(filename = "CropData.txt")
HYPEtools::WriteCropData(x =CropData ,filename = file.path(savePath,"CropData.txt"))


FloodData <- HYPEtools::ReadFloodData(filename = "FloodData.txt")%>% 
  filter(SUBID%in%subbassin_ids) # RAS


GeoClass <- HYPEtools::ReadGeoClass(filename = "GeoClass.txt")#RAS
HYPEtools::WriteGeoClass(x =GeoClass ,filename =file.path(savePath,"GeoClass.txt") )

GeoData <- HYPEtools::ReadGeoData(filename = "GeoData.txt")%>% 
  filter(SUBID%in%subbassin_ids) 
HYPEtools::WriteGeoClass(x =GeoData ,filename =file.path(savePath,"GeoData.txt") )

LakeData <- HYPEtools::ReadLakeData(filename = "LakeData.txt")%>% 
  filter(SUBID%in%subbassin_ids) 
HYPEtools::WriteLakeData(x = LakeData,filename = file.path(savePath,"LakeData.txt"))

MgmtData <- HYPEtools::ReadMgmtData(filename = "MgmtData.txt")%>% 
  filter(SUBID%in%subbassin_ids)
HYPEtools::WriteMgmtData(x =MgmtData ,filename = file.path(savePath,"MgmtData.txt"))

update_txt <- HYPEtools::ReadUpdate(filename = "update.txt")%>% 
  filter(SUBID%in%subbassin_ids)
write.table(x =update_txt ,file =file.path(savePath,"update.txt") ,
            append =FALSE ,quote =FALSE,sep = "\t",na = "-9999",row.names = FALSE)
