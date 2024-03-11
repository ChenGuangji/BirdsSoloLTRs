# Figure 1
rm(list = ls())

require("writexl")
library("dplyr",quietly=T)
library("ggplot2",quietly = T)
library("ggtree",quietly = T)
library("ggnewscale",quietly = T)
library("ggtreeExtra",quietly = T)

setwd("Source_Data/Figure_1/Figure_1A/")

data.df<-read_excel("Figure_1A.xlsx")
All.Sp = read.tree("Figure_1A.all.spe.tre")

groupinfo<-split(data.df$Tree.name,data.df$clade)
All.Sp <- groupOTU(All.Sp,groupinfo,"Clade")

pdf("./Figure_1A.pdf",useDingbats = F,height=10,width=10)
Clade<-NULL
p.FigTree<-ggtree(All.Sp,aes(color=Clade),ladderize = T,branch.length="none",layout="fan",open.angle=180,size=0.3)+
  scale_color_manual(values=c("gray","#E64B35","#4DBBD5","#6a3d9a"))+#geom_tiplab2(size=.5)+
  geom_fruit(data=data.df,
             geom=geom_point,
             mapping=aes(y=Tree.name, x=proportion,color=clade),
             pwidth=0.5,
             size=0.8,alpha=0.8,
             stat="identity",
             # orientation="y",
             axis.params=list(
               axis       = "x",
               text.angle = 45,
               text.size  = 2,
               hjust      = 0.5,
               vjust      = 2,
               nbreak     = 4
             ),
             grid.params=list(color="gray90"),
             position="auto",
             offset = 0.04) +
  geom_strip("CHATOR","QUIMEX",barsize = 1.2,color="#66c2a5",     label="Neognathae",      offset=25, offset.text = 2 , hjust = 0.5,extend = .4, angle=13,  fontsize=2.8)+ 
  geom_strip("CRYUND","STRCAM",barsize = 1.2,color="#d95f02",     label="Palaeognathae",   offset=25, offset.text = 2 , hjust = 0  ,extend = .4, angle=0 ,  fontsize=2.8)+ 
  geom_strip("NEOCOR","TYRSAV", barsize = 0.9, color="#ff7f00", offset= 9 , offset.text = 1.5 , hjust = 0.5, extend = .4, angle=20, fontsize=2, label="Tyranni (suboscines)")+
  geom_strip("ATRCLA","QUIMEX", barsize = 0.9, color="#6a3d9a", offset= 9 , offset.text = 1.5 , hjust = 0.5, extend = .4, angle=58, fontsize=2, label="Passeri (oscines)")+
  geom_strip("PTILEU","VIRALT", barsize = 0.8, color="#cab2d6", offset= 12.5, offset.text = 1.5 , hjust = 0.5, extend = .4, angle=40, fontsize=2, label="Corvides")+
  geom_strip("CNELOR","QUIMEX", barsize = 0.8, color="#1f78b4", offset= 12.5, offset.text = 1.5 , hjust = 0.5, extend = .4, angle=67, fontsize=2, label="Passerides")+
  geom_strip("ANTMIN","LEILUT", barsize = 0.6, color="#6a3d9a", offset= 16, offset.text = 1.5 , hjust = 0.5, extend = .4, angle=53, fontsize=2, label="Sylviida")+
  geom_strip("BOMGAR","SAXMAU", barsize = 0.6, color="#fb9a99", offset= 16, offset.text = 1.5 , hjust = 0.5, extend = .4, angle=66, fontsize=1.8, label="Muscicapida")+
  geom_strip("PROCAF","QUIMEX", barsize = 0.6, color="#e31a1c", offset= 16, offset.text = 1.5 , hjust = 0.5, extend = .4, angle=81, fontsize=2, label="Passerida")+
  geom_strip("RHOROS","QUIMEX", barsize = 0.6, color="#08519c", offset= 19, offset.text = 1.5 , hjust = 0.5, extend = .4, angle=88, fontsize=1.5, label="Emberizoidea")+
  geom_strip("ACACHL","QUIMEX",barsize = 1  ,color="#00A8EE",     label="Passeriformes",   offset=29, offset.text = 2 , hjust = 0.5,extend = .4, angle=49,  fontsize=2.8)+ 
  geom_strip("SEMFRA","BUCCAP",barsize = 1  ,color="#847AFF",     label="Piciformes",      offset=18, offset.text = 2 , hjust = 0.5,extend = .4, angle=07,  fontsize=2.8)+ 
  geom_strip("BUCRHI","UPUEPO",barsize = 1  ,color="#D37700",     label="Bucerotiformes",  offset=18, offset.text = -2 , hjust = 0.1,extend = .4, angle=0,  fontsize=2.8)+ 
  geom_strip("ALELAT","TYMCUP",barsize = 1  ,color="#29B455",     label="Galliformes",     offset=29, offset.text = 2 , hjust = 0,  extend = .4, angle=0 ,  fontsize=2.8)+
  geom_strip("CHATOR","ANAZON",barsize = 1  ,color="#E7663E",     label="Anseriformes",    offset=29, offset.text = 2 , hjust = 0,  extend = .4, angle=0 ,  fontsize=2.8)+
  geom_strip("NYCLEU","OREMEL",barsize = 1  ,color="#C67F00",     label="Caprimulgiformes",offset=29, offset.text = 2 , hjust = 0,  extend = .4, angle=0 ,  fontsize=2.8)+
  geom_strip("BURBIS","LARSMI",barsize = 1  ,color="#9A9300",     label="Charadriiformes", offset=29, offset.text = 2 , hjust = 0,  extend = .4, angle=0 ,  fontsize=2.8)+
  geom_strip("Alligator_mississippiensis","Gavialis_gangeticus",barsize = 1  ,color="#6a2d5a",     label="Crocodilia",  offset=29, offset.text = 7, hjust = 0.5,extend = .4, angle=10, fontsize=2.5)+
  geom_strip("Pelodiscus_sinensis","Gopherus_evgoodei",barsize = 1  ,color="#7a5d5a",     label="Testudines",  offset=29, offset.text = 7, hjust = 0.5,extend = .4, angle=10, fontsize=2.5)+
  geom_strip("Sphenodon_punctatus","Alligator_mississippiensis",barsize = 2,color="#6a3d9a",label="Reptilia",offset=24, offset.text = 4,hjust = 0.5,extend=.4,angle=-75, fontsize=2.8)+
  geom_strip("Monodelphis_domestica","Mus_musculus",barsize = 2,color="#4DBBD5",label="Mammalia",offset=24, offset.text = 4,hjust = 0.5,extend=.4,angle=-85, fontsize=2.8)+
  geom_fruit(data=data.df,
             geom=geom_point,
             mapping=aes(y=Tree.name, x=frequency,color=clade),
             pwidth=0.4,
             size=0.8,alpha=0.8,
             stat="identity",
             # orientation="y",
             axis.params=list(
               axis       = "x",
               text.angle = 45,
               text.size  = 2,
               hjust      = 0.5,
               vjust      = 2,
               nbreak     = 4
             ),
             grid.params=list(color="gray90"),
             position="auto",
             offset = 0.3) 
p.FigTree
dev.off()
