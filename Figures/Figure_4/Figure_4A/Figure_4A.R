### Figure 4A
rm(list = ls())

library("ggplot2")
setwd("/Users/chenguangji/Desktop/05.内源性病毒/LTR/Solo-LTR_report/Solo-Final/Source_Data/Figure_4/Figure_4A/")
ClosestGene<-read.table("Figure_4A.txt",sep="\t",header=T)

ClosestGene$term<-factor(ClosestGene$term,levels=rev(c("all","H3K27ac","H3K4me3","H3K27me3")))
ClosestGene$distance<-factor(ClosestGene$distance,levels = c("2k","5k","10k"))

p.Figure_4A <- ggplot(ClosestGene,aes(x=closest_GeneNum,y=term,fill=distance))+
  geom_bar(width = 0.8,stat = 'identity', position = 'dodge')+
  geom_text(aes(label=scales::comma(closest_GeneNum,1)),hjust=-0.1,position = position_dodge(width = 0.9))+
  guides(fill=guide_legend((title="Distance Cutoff")))+
  theme_classic()+scale_x_continuous(expand = c(0,0),limits = c(NA,2200),labels = scales::comma)+
  labs(y="",x="Gene Number",title="A")+theme(legend.position = c(0.78,0.12))
p.Figure_4A
ggsave("Figure_4A.pdf",p.Figure_4A,h=5,w=5)
