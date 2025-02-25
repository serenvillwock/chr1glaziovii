library(tidyverse)
setwd("~/Desktop/Research/Glaziovii_introgression/KASP_design/uplift_v6_v7/uplift_markers/")


markers = read.csv("all_markers.csv")
markers = separate(markers, col=GBSSNPID, sep="_", into= c("CHROM_S", "POS"), remove=FALSE)
markers$CHROM = str_replace(markers$CHROM_S, "S", "")
markers = markers %>% select(GBSSNPID, CHROM, POS,  INTERTEK_SNP_ID, TYPE)


write.csv(markers, file="all_markers_to-uplift.csv")
