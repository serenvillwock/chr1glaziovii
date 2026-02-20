library(tidyverse)
library(AlgDesign)

setwd("~/Desktop/Research/Glaziovii_introgression/IITA_data_collection_seedling_nursery_2021/Genotype_data/")
alldata = readRDS("alldata.RDS")
selected = read.csv("CETselection_withplotname.csv")
data_parentwide = readRDS("data_parentwide.RDS")

setwd("~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/")
planted = read.csv("~/Desktop/Research/Glaziovii_introgression/CET_Dec2021/21.GS.C5.CE.1060.IB_SERE.csv")

length(planted$accession_name) #500 were planted
sum(selected$accession %in% planted$accession_name) #269 of them were from my selection list



#check OptFederov of planted CET:
data_parentwide_planted = data_parentwide[data_parentwide$accession %in% planted$accession_name,]
planted_data_N = nrow(data_parentwide_planted) #409 retained

optFed_planted = optFederov(~., data=data_parentwide_planted[,35:95], nTrials=planted_data_N) 
optFed_planted$D #0.05367834


#original D value:
data_parentwide_selected = data_parentwide[data_parentwide$accession %in% selected$accession,]
selected_data_N = nrow(data_parentwide_selected)

optFed_selected = optFederov(~., data=data_parentwide_selected[,35:95], nTrials=selected_data_N) 
optFed_selected$D #0.05711819




#plotting function:
plot_selection = function(dataset, title){
  selected = dataset
  colnames(selected)[2:11] <- seq(from=1, to=10)
  
  #order for plot:
  selected.sorted = selected %>%
    mutate(SubjectID = fct_reorder(SubjectID, row_sum)) %>%
    pivot_longer(cols=2:11, names_to="KASP") %>%
    mutate(KASP = KASP)
  
  selected.sorted$value = as.factor(selected.sorted$value)
  selected.sorted$KASP = as.numeric(selected.sorted$KASP)
  
  barwidth = 0.25
  
  #plot selection:
  selected.sorted %>% ggplot() +
    geom_segment(aes(x=KASP - barwidth, y=SubjectID, 
                     xend = KASP + barwidth, yend = SubjectID, color=value), size=0.5) +
    scale_color_manual(values=c("#FFFFFF", "#FF9900", "#0066FF", "gray")) +
    scale_x_continuous(name="KASP marker", breaks=c(unique(selected.sorted$KASP))) +
    scale_y_discrete(name="Sample") +
    theme_dark() +
    ggtitle(title) +
    theme(axis.text.y = element_blank(), axis.text.x = element_text(size=4, angle=90)) +
    labs(color = "Glaziovii allele dosage")
}
  
  
  
#visually see genotypes of selection:
  planted.genos = alldata[alldata$accession %in% planted$accession_name,]
  #nrow(planted.genos) #412 with genotypes
  plot_selection(planted.genos, "genotypes of planted CET, D=0.05368")
  ggsave(plot=last_plot(), filename="planted_CET_genotypes.png")
  
  selected.genos = alldata[alldata$accession %in% selected$accession,]
  plot_selection(selected.genos, "genotypes of optimized selection, D=0.05712")
  ggsave(plot=last_plot(), filename="optFederov_selected_genotypes.png")
  
  
  
#check the genotypes of those not selected:
not_selected_names = setdiff(selected$accession, planted$accession_name)

not_selected = alldata[alldata$accession %in% not_selected_names,]

mean(not_selected$row_sum)
#7.483871
mean(data_parentwide_selected$row_sum)
#7.495017
mean(data_parentwide_planted$row_sum)
#7.183374  

plot_selection(not_selected, "genotypes of unplanted clones")

#the mean glaziovii allele dosage is slightly higher in the unplanted set
#there was a lower mean glaziovii allele dosage in the advanced set compared to the selected set



#check average homozygosity in unplanted set:
data_notselected = data_parentwide[data_parentwide$accession %in% not_selected_names,]
data_notselected_xd = data_notselected[,45:54]
data_notselected_xd_plus1 = data_notselected_xd+1
(sum(data_notselected_xd_plus1)/2)/nrow(data_notselected) #5.419355

#check average homozygosity in optimized set:
data_selected_xd = data_parentwide_selected[,45:54]
data_selected_xd_plus1 = data_selected_xd+1
(sum(data_selected_xd_plus1)/2)/nrow(data_parentwide_selected) #5.508306

#check average homozygosity in planted set:
data_planted_xd = data_parentwide_planted[,45:54]
data_planted_xd_plus1 = data_planted_xd+1
(sum(data_planted_xd_plus1)/2)/nrow(data_planted_xd) #5.418





