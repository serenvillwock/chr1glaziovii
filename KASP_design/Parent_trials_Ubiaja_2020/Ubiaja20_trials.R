library(plyr)
library(stringr)

# Read in the files
setwd("~/Desktop/Research/Ubiaja_Trials (1)")
UB.UYT28 <- read.csv("20.GS.C3.UYT.28.UB.csv")
UB.PYT <- read.csv("20.GS.C4.PYT.80.SETA&SETB.CB.UB.csv")
UB.UYT30 <- read.csv("20.GS.C1.C2.C3.UYT.30.UB.csv")
UB.AYT40 <- read.csv("20.GS.C4B.AYT.40.UB.csv")
UB.AYT42 <- read.csv("20.GS.C4B.AYT.42.UB.csv")

UB.all <- rbind.fill(UB.UYT28, UB.PYT, UB.UYT30, UB.AYT40, UB.AYT42)

UBaccs <- as.character(unique(UB.all$accession_name))



DoseGlaz <- readRDS("~/Desktop/R code/Data/meanDoseGlaz_250Kwindows_AllPops.rds")
DoseGlazGG <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="GG" & DoseGlaz$Chr ==1][[1]]
DoseGlazC1 <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="C1" & DoseGlaz$Chr ==1][[1]]
DoseGlazC2 <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="C2" & DoseGlaz$Chr ==1][[1]]
DoseGlazC3 <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="C3" & DoseGlaz$Chr ==1][[1]]
DoseGlazLG <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="LG" & DoseGlaz$Chr ==1][[1]]
DoseGlazNR <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="NR" & DoseGlaz$Chr ==1][[1]]
DoseGlazUG <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="UG" & DoseGlaz$Chr ==1][[1]]
DoseGlazCIAT <- DoseGlaz$doseGlazInWindows[DoseGlaz$Group=="CIAT" & DoseGlaz$Chr ==1][[1]]

DoseGlaz.all <- rbind.fill(DoseGlazGG,DoseGlazC1,DoseGlazC2,DoseGlazC3,
                           DoseGlazLG, DoseGlazNR, DoseGlazUG, DoseGlazCIAT)

DGaccs <- as.character(unique(DoseGlaz.all$IID))


intersect(UBaccs, DGaccs)



