# Figure 1B
rm(list = ls())

require("writexl")
library("dplyr",quietly=T)
library("ggplot2",quietly = T)
library("ggpubr",quietly = T)


setwd("Source_Data/Figure_1/Figure_1B/")
data.df.1B<-read_excel("Figure_1B.xlsx")

### Figure_2B
p.Fig1B<-ggscatter(data.df.1B %>% mutate(clade=factor(clade,levels=c("Aves","Reptilia","Mammalia"))), x = "fasize.log", y = "solo.count.log10", size = 0.8, color="clade",add = "reg.line", 
                   conf.int = T,cor.coef =T,cor.coef.size=3,
                   add.params = list(color = "clade", fill = "clade", size = 0.5),
                   show.legend.text = T) +
  scale_color_manual(values=c("#E64B35","#6a3d9a","#4DBBD5"))+
  scale_fill_manual(values=c("#E64B35","#6a3d9a","#4DBBD5"))+
  xlab("Genome size (log10 transformed)")+ylab("Solo-LTR count (log10 transformed)")+
  theme(legend.position = "none")+facet_wrap(.~clade,scales = "free_x") + 
  theme(strip.background = element_rect(fill=NA))
p.Fig1B
ggsave("Figure_1B.pdf",width = 10,height = 3)
