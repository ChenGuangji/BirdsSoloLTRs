# Figure 1B
rm(list = ls())

require("writexl")
require("readxl")
library("dplyr",quietly=T)
library("ggplot2",quietly = T)
library("ggtree",quietly = T)
library("ape")
library("aplot")
library("ggsci")

setwd("Source_Data/Figure_2/Figure_2A/")
ERVK_proportion<-read_excel("Figure_2A.xlsx")
Aves.Sp<-read.tree("Figure_2A.tre")

Aves.Sp.groupinfo<-split(ERVK_proportion$Tree.name,ERVK_proportion$Order)
Aves.Sp <- groupOTU(Aves.Sp,Aves.Sp.groupinfo,"Clade")
p.Aves.Sp<-ggtree(keep.tip(Aves.Sp,ERVK_proportion$Tree.name),aes(color=Clade),ladderize = T,branch.length="none")+
  theme(legend.position = "none")+
  scale_color_manual(values=c("gray",colorRampPalette(pal_npg("nrc", alpha = 0.7)(10))(37)))+scale_y_reverse()+
  geom_hline(aes(yintercept = 321.5),linetype="longdash",color="gray",alpha=0.8) + 
  geom_hline(aes(yintercept = 259.5),linetype="longdash",color="gray",alpha=0.8) +
  geom_hline(aes(yintercept = 217.5),linetype="longdash",color="gray",alpha=0.8)+
  geom_hline(aes(yintercept = 190.5),linetype="longdash",color="gray",alpha=0.8)+
  geom_hline(aes(yintercept = 19.5),linetype="longdash",color="gray",alpha=0.8)+
  geom_strip("CHATOR","QUIMEX",barsize = 1.2,color="#66c2a5",label="Neognathae",offset=2, offset.text = 5, hjust = 0,extend = .4)+ 
  geom_strip("CRYUND","STRCAM",barsize = 1.2,color="#d95f02",label="Palaeognathae",offset=2, offset.text = 3, hjust = 0,extend = .4)+ 
  geom_strip("ATRCLA","QUIMEX",barsize = 0.9,color="#2c7fb8",label="Passeri",offset=8, offset.text = 5, hjust = 0,extend = .4, fontsize=3)+ 
  geom_strip("CNELOR","QUIMEX",barsize = 0.9,color="deepskyblue4",label="Passerides",offset=11, offset.text = 3, hjust = 0,extend = .4, fontsize=3)+
  geom_strip("PROCAF","QUIMEX",barsize = 0.9,color="dodgerblue4",label="Passerida",offset=14, offset.text = 2, hjust = 0,extend = .4, fontsize=3)+
  geom_strip("ACACHL","QUIMEX",barsize = 1,color="#00A8EE",label="Passeriformes",offset=5, offset.text = 8, hjust = 0,extend = .4, fontsize=3)+ 
  geom_strip("SEMFRA","BUCCAP",barsize = 1,color="#847AFF",label="Piciformes",offset=5, offset.text = 3, hjust = 0,extend = .4, fontsize=3)+ 
  geom_strip("BUCRHI","UPUEPO",barsize = 1,color="#D37700",label="Bucerotiformes",offset=5, offset.text = 3, hjust = 0,extend = .4, fontsize=3)+ 
  geom_strip("ALELAT","TYMCUP",barsize = 1,color="#29B455",label="Galliformes",offset=5, offset.text = 3, hjust = 0,extend = .4, fontsize=3)+
  geom_strip("CHATOR","ANAZON",barsize = 1,color="#E7663E",label="Anseriformes",offset=5, offset.text = 3, hjust = 0,extend = .4, fontsize=3)+
  geom_strip("NYCLEU","OREMEL",barsize = 1,color="#C67F00",label="Caprimulgiformes",offset=5, offset.text = 3, hjust = 0,extend = .4,fontsize=3)+
  geom_strip("BURBIS","LARSMI",barsize = 1,color="#9A9300",label="Charadriiformes",offset=5, offset.text = 3, hjust = 0,extend = .4,fontsize=3)+
  geom_strip("CICMAG","NANBRA",barsize = 1,color="#1D9AFF",label="Pelecaniformes",offset=5, offset.text = 3, hjust = 0,extend = .4,fontsize=3)+
  geom_strip("CATAUR","SPITYR",barsize = 1,color="#EF5D59",label="Accipitriformes",offset=5, offset.text = 3, hjust = 0,extend = .4,fontsize=3)+
  xlim(0,88)
### Figure_2A
p.Figure_2A.pre<-ggplot(data = ERVK_proportion,
                        aes(x=Tree.name, y=detail.r.length)) + 
  geom_point(aes(color=Order),size=0.3)+
  geom_line(aes(group=Order,color=Order)) +
  coord_flip() + theme_tree2() + 
  labs(caption = "cutoff = 20k_&&_85_indentity",y="Proportion (Unit:%)") +
  theme(legend.position='none',axis.text.x =element_text(angle = 45,vjust = 0.5, hjust = 0.5)) + 
  geom_vline(aes(xintercept = 217.5),linetype="longdash",color="gray",alpha=0.8)+
  geom_vline(aes(xintercept = 190.5),linetype="longdash",color="gray",alpha=0.8)+
  geom_vline(aes(xintercept = 19.5),linetype="longdash",color="gray",alpha=0.8)+
  geom_vline(aes(xintercept = 259.5),linetype="longdash",color="gray",alpha=0.8) + 
  geom_vline(aes(xintercept = 321.5),linetype="longdash",color="gray",alpha=0.8)+
  theme(strip.background=element_rect(fill=NA,color=NA))


# p.Figure_2A<-
p.Figure_2A.pre %>% insert_left(p.Aves.Sp,width = 1) 
# p.Figure_2A
ggsave("Figure_2A.pdf",width = 5,height = 10)
