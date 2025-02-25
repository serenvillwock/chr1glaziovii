longnames <- read.csv("~/Desktop/Research/long-reads-list.csv")
intrsummary <- read.csv("~/Desktop/Research/UBclones_intro_summary.csv")

long.names <- longnames$Long.names

for(i in 1:length(long.names)){
  lines <- grepl(long.names[i], intrsummary$accession)
  print(intrsummary[lines,])
}