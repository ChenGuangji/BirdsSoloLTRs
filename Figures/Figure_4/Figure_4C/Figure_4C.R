# Figure_4C
require( ggplot2 );
require( scales );
require( ggrepel );
require( dplyr )

setwd("Source_Data/Figure_4/Figure_4C/")
Brian_compare.DEGs.df<-read.csv("Figure_4C.csv")
p.Volcano<- ggplot(Brian_compare.DEGs.df,
                   aes(log2FoldChange,-1*log10(padj)))+ 
  geom_point(aes(color = diffexpressed),alpha=0.4,size = 1) +
  scale_color_manual(values=c("blue","black", "red")) +
  labs(x = expression(log[2](FoldChange)), y = expression(-log[10](p.adj))) +
  geom_vline(xintercept=c(-1, 1), lty=2,col="black",lwd=0.5) + 
  geom_hline(yintercept=-log10(0.05), lty=2,col="red",lwd=0.5) +
  geom_point(data=Brian_compare.DEGs.df %>% filter(ERVK_regulated =="ERVK_regulated") ,aes(log2FoldChange,-1*log10(padj),color = "ERVK_regulated"),alpha=0.8,size = 1) +
  geom_label_repel(data=Brian_compare.DEGs.df %>% filter(name!="NA"),
                   aes(log2FoldChange,-1*log10(padj),label=name),size = 2,label.padding = 0.15,min.segment.length = unit(0, 'lines'), nudge_y = 40,nudge_x = c(5,-5))+
  theme_classic()
ggsave("Figure_4C.pdf",p.Volcano,width = 5,height = 3.2)
