


setwd("/Users/serenwork/Desktop/Research/Glaziovii_introgression/KASP_design")
snp.sub <- read.csv("Intertek_submission.csv")

snp.sub$newseq <- NA
snp.sub$newseq <- str_replace(snp.sub$Sequence., '\\[.\\]', snp.sub$SNP.)

write.csv(snp.sub, "reformatted_SNPs.csv")
