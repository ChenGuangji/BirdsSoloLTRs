# Figrue_4B

# A plotting R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# The axes in the plot have no intrinsic meaning. Revigo uses Multidimensional Scaling (MDS) to reduce the dimensionality of a matrix of the GO terms pairwise semantic similarities. The resulting projection may be highly non linear. The guiding principle is that semantically similar GO terms should remain close together in the plot. Repeated runs of Revigo may yield different arrangements, but the term distances will remain similar.
# 
# Would you like to remove obsolete GO terms: No
# What species would you like to work with: Gallus gallus (9031)
# What semantic similarity measure would you like to use: Resnik (normalized)

# --------------------------------------------------------------------------
require( ggplot2 );
require( scales );
require( ggrepel );
require( dplyr )

# --------------------------------------------------------------------------
setwd("/Users/chenguangji/Desktop/05.内源性病毒/LTR/Solo-LTR_report/Solo-Final/Source_Data/Figure_4/Figure_4B/")
revigo.data.tsv<-read.table("Figure_4B.tsv",header = T,sep="\t")

# one.data <- data.frame(revigo.data.tsv);
# names(one.data) <- revigo.names;

one.data<-revigo.data.tsv
one.data <- one.data [(one.data$PC_0 != "null" & one.data$PC_1 != "null"), ];
one.data$plot_X <- as.numeric( as.character(one.data$PC_0) );
one.data$plot_Y <- as.numeric( as.character(one.data$PC_1) );
one.data$log_size <- as.numeric( as.character(one.data$LogSize) );
one.data$value <- as.numeric( as.character(one.data$Value) );
one.data$frequency <- as.numeric( as.character(one.data$Frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$Uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$Dispensability) );
#head(one.data);


# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below
ex <- one.data [ one.data$dispensability < 0.35, ];
one.x_range = max(one.data$value) - min(one.data$value);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);

one.data.MF<-one.data %>%filter(Aspects=="Molecular Function")
ex.MF <- one.data.MF [ one.data.MF$dispensability < 0.4, ];
p.revigo.MF <- ggplot( data = one.data.MF )+
  geom_point( aes( plot_X, plot_Y, colour = value, size = log_size))+ 
  scale_colour_gradientn( colours = rev(c("blue","green", "yellow", "red")), limits = c( min(one.data$value), max(one.data$value)) )+
  geom_point( aes( plot_X, plot_Y, size = log_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.8) )) +
  geom_text_repel( data = ex.MF , aes(plot_X, plot_Y, label = Name), size = 3,max.overlaps=500,min.segment.length=0,direction="both",nudge_y=ifelse(ex.MF$plot_Y>0,-0.4,0.4))+
  scale_size(name="LogSize",range=c(3, 15)) + 
  labs (y = "semantic space Y", x = "semantic space X",title="B")+
  theme_classic()+
  theme(legend.key = element_blank(),legend.position = "top")
p.revigo.MF
ggsave("Figure_4B.pdf",w=5,h=5)
