# Figure 3B
rm(list = ls())

require("writexl")
require("readxl")
library("dplyr",quietly=T)
library("ggplot2",quietly = T)
library("ape")
library("aplot")
library("pheatmap")
setwd("Source_Data/Figure_3/Figure_3B/")

annotation_col<-read.csv("Figrue_3B.annotation_col.csv",row.names="X")
ERVK_related.NorCounts<-read.csv("Figrue_3B_NorCounts.csv",row.names="X")
DEGs_ADD_ERVK_related<-read.csv("Figure_3B_DEGs.csv")

annotation_row = data.frame(DEGs = factor((DEGs_ADD_ERVK_related %>% filter(ERVK_related=="ERVK_related"))$diffexpressed,
                                          levels = c("UP","DOWN")))
rownames(annotation_row) = (ERVK_related.DEGs %>% filter(ERVK_related=="ERVK_related"))$ID

p.Figure_3B<-pheatmap::pheatmap(log10(ERVK_related.NorCounts+1),
                                color = colorRampPalette(c("#5074AF","#E0F3F8","#ffffbf","#ffeda0","#FEE090","#feb24c","#FC8D59","#fc4e2a","#D73027"))(100),
                                cluster_rows=T,cluster_cols=F,treeheight_row=0,
                                na_col = "grey80",border_color=NA,
                                annotation_col=annotation_col,
                                annotation_row=annotation_row,
                                gaps_col=14,
                                show_rownames=F,fontsize_row=4,show_colnames=F)
p.Figure_3B
ggsave("Figure_3B.pdf",p.Figure_3B,h=5,w=5)
