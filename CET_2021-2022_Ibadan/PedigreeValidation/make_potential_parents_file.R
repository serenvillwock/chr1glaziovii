
setwd("~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/")

progeny <- read.table("CETaccession_list.txt")[,1]
parents <- read.table("../unique_parents_list.txt")[,1]
genotags <- read.table("sampletags.txt")[,1]

#adjust some types in the parent names
parents <- gsub("p", "P", parents)
parents <- c(parents, "TMS18F1095P0041", "TMS15F1394P0007")


prog_toselect <- c()
prog_notfound <- c()
for (i in 1:length(progeny)){
  test <- grep(progeny[i], genotags)
  if (length(test) == 0) { prog_notfound <- c(prog_notfound, progeny[i]) }
  else{
    prog_toselect <- c(prog_toselect, test)
  }
}

#length(unique(genotags[prog_toselect])) # = 435


par_toselect <- c()
par_notfound <- c()
for (i in 1:length(parents)){
  test <- grep(parents[i], genotags)
  if (length(test) != 0) {
    par_toselect <- c(par_toselect, test)}
  else{
    family_test <- grep(str_match(parents[i], "F(.*?)P")[,1], genotags)

    if (length(family_test) != 0) {
      par_toselect <- c(par_toselect, family_test)
    } else{
        par_notfound <- c(par_notfound, parents[i])
    }
  }
}


#write.csv(samplenames[toselect], file = "~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/DArTSeqCETnames.csv")
#write.csv(notfound, file = "~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/CETmissing_genotypes.csv")


# Export parent list without quotation marks for cassavabase
write.csv(gsub("\"", "", parents), file="~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/parentlist.csv")



moreparents <- read.delim("~/Downloads/ParentGenos.tsv")
moreparents_named <- moreparents

for(i in 2:ncol(moreparents)){

  geno <- str_split( colnames(moreparents)[i], "[.]" )[[1]][1]
  search <- grepl(geno, genotags)
  if (sum(search) != 0){
    print(c(i, genotags[search]))
    colnames(moreparents_named)[i]  <- genotags[search]
  }
}



write.table(moreparents_named,
            file="~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/AlphaAssign/AdtlParentsRenamed.txt",
            row.names=F,
            quote=F)



possible_parents <- c(genotags[par_toselect],
                          #colnames(moreparents_named),
                          "TMS15F1302P0020.A41433...TMS15F1302P0020") #add a similar looking name match

write.table(all_possible_parents[-47], #delete the "Marker" that got in there somehow
            file="~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/AlphaAssign/PossibleParents.txt",
            row.names=F,
            col.names = F,
            quote=F)



