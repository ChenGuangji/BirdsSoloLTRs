# Figure 3A
rm(list = ls())

require("writexl")
require("readxl")
library("dplyr",quietly=T)
library("ggplot2",quietly = T)
library("ggtree",quietly = T)
library("ape")
library("aplot")
library("ggsci")

setwd("Source_Data/Figure_3/Figure_3A/")
bed.s.df<-read_excel("Figure_3A.xlsx")
Figure_3A.tre<-read.tree("Figure_3A.tre")
p.Figure_3A.pre<-
  bed.s.df %>% ggplot(aes(counts,Tree.name,fill=type2))+
  # geom_point(aes(y=spe,x=value,color=variable))+
  geom_bar(stat="identity",position = "stack")+
  # scale_fill_d3()+
  scale_fill_manual(limits = c("MRCA of Passeri (oscines)","MRCA of Passerides","MRCA of Passerida",
                               "share","unique"),
                    values = c("#fb766d","#7cae00","#619cff",
                               "#8C5CB1","#4BBA9B"))+
  scale_x_continuous(labels = scales::comma,expand = c(0,0))+
  theme_classic()+theme(axis.text.y = element_blank(),axis.ticks.y=element_blank(),legend.title = element_blank(),legend.position = c(0.7,0.2))+
  labs(x="counts of ERVK solo-LTR insertion",y="")


P.Figure_3A.tre<-ggtree(Figure_3A.tre,ladderize = T,branch.length="none") +#%<+% Pass_Super +
  # geom_tiplab(aes(label=paste(Suborder,Infraorder,Parvorder,Superfamily,Family,label)),size=1.2)+
  geom_strip("ATRCLA","QUIMEX", barsize = 2.2, color="#fb766d", offset=0+ 3, offset.text = 1.2 +4, hjust = 0.5, extend = .4, angle=270, fontsize=4, label="Passeri (oscines)")+
  geom_strip("CNELOR","QUIMEX", barsize = 1.6, color="#7cae00", offset=0+ 12, offset.text = 1 +4, hjust = 0.5, extend = .4, angle=270, fontsize=4, label="Passerides")+
  geom_strip("PROCAF","QUIMEX", barsize = 1.2, color="#619cff", offset=0+ 17, offset.text = 1 +4, hjust = 0.5, extend = .4, angle=270, fontsize=4, label="Passerida")

require("aplot")
pdf("Figure_3A.pdf",height = 7,width=5)
p.Figure_3A.pre %>% insert_left(P.Figure_3A.tre+xlim(NA,55),1)
dev.off()
