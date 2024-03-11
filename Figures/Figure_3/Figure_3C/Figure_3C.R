### Figure 3C
rm(list = ls())

library("UpSetR")
library("ComplexHeatmap")

### upset R
setwd("Source_Data/Figure_3/Figure_3C/")
upset.df<-read.csv("Figure_3C.csv",header = T,row.names=1)
names(upset.df)[1]="taeGut1"

m = make_comb_mat(upset.df)
m2 = m[comb_size(m) <= 60]
m3 = m2[comb_size(m2) >= 2]

pdf("Figure_3C.pdf",width = 15,height = 7)
ht2 = draw(UpSet(m[comb_size(m) >= 2],
                 pt_size = unit(3, "mm"),
                 comb_order = order(comb_size(m[comb_size(m) >= 2]),decreasing = T),
                 top_annotation = HeatmapAnnotation(
                   "ERVK\nsolo-LTR\nCounts" = anno_barplot(
                     comb_size(m[comb_size(m) >= 2]),border = FALSE,gp = gpar(fill = "black"), 
                     height = unit(7, "cm"),ylim=c(0,27000)
                   ), 
                   annotation_name_side = "left",
                   annotation_name_rot = 0),
                 right_annotation=NULL))
od2 = column_order(ht2)
cs2 = comb_size(m[comb_size(m) >= 2])

decorate_annotation("ERVK\nsolo-LTR\nCounts", {
  grid.text(cs2[od2], x = seq_along(cs2), y = unit(cs2[od2], "native") + unit(3, "pt"), 
            default.units = "native", just = "bottom", gp = gpar(fontsize = 10),rot=45,hjust=0,vjust=0.2)
})
dev.off()
