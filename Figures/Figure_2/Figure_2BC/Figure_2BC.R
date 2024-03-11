# Figure 2BC
rm(list = ls())

require("writexl")
require("readxl")
library("dplyr",quietly=T)
library("ggplot2",quietly = T)
library("ggtree",quietly = T)
library("ape")
library("aplot")
library("ggsci")

setwd("Source_Data/Figure_2/Figure_2BC/")
ERVK_proportion_node<-read_excel("Figure_2BC.xlsx")

### Figure_2B
p.Figure_2B<-ggplot(ERVK_proportion_node %>% filter(clade %in% c("Passeriformes")),
                    aes(x=nodes,y=proportion,group=clade,color=clade,fill=clade))+
  geom_smooth(method = "lm",alpha=0.5)+
  geom_point()+
  scale_color_manual(limits = c("Passeriformes"),
                     values = c("#0099FF"))+
  scale_fill_manual(limits = c("Passeriformes"),
                    values = c("#0099FF"))+
  theme_classic()+
  labs(x="Speciation events",y="Proportion of ERVK Solo-LTRs",
       title="B",subtitle = "B10K tree (363 species)")+
  theme(legend.position = "none",legend.title = element_blank())+
  scale_y_continuous(limits=c(0,NA))+facet_wrap(.~clade,ncol=2)
p.Figure_2B
ggsave("Figure_2B.pdf",width = 5,height = 5)
### Figure_2C
p.Figure_2C<-ggplot(ERVK_proportion_node %>% filter(clade %in% c("Passerida","Muscicapida","Sylviida","Corvides")),
                    aes(x=nodes,y=proportion,group=clade,color=clade,fill=clade))+
  geom_smooth(method = "lm",alpha=0.5)+
  geom_point()+
  scale_color_manual(limits = c("Passerida","Muscicapida","Sylviida","Corvides"),
                     values = c("#e31a1c","#fb9a99","#6a3d9a","#cab2d6"))+
  scale_fill_manual(limits = c("Passerida","Muscicapida","Sylviida","Corvides"),
                    values = c("#e31a1c","#fb9a99","#6a3d9a","#cab2d6"))+
  theme_classic()+
  labs(x="Speciation events",y="Proportion of ERVK Solo-LTRs",
       title="C",subtitle = "B10K tree (363 species)")+
  theme(legend.position = "top",legend.title = element_blank())
p.Figure_2C
ggsave("Figure_2C.pdf",width = 5,height = 5.3)
