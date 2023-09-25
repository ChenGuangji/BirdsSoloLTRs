# A plotting R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# --------------------------------------------------------------------------
# If you don't have the ggplot2 package installed, uncomment the following line:
# install.packages( "ggplot2" );
library( ggplot2 );

# --------------------------------------------------------------------------
# If you don't have the scales package installed, uncomment the following line:
# install.packages( "scales" );
library( scales );

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","plot_X","plot_Y","log_size","value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0015267","channel activity",3.16020482809071,4.13041416114444,2.22759099761207,2.63648789635337,-2.34915579045561,0.521929176886414,0),
c("GO:0004930","G protein-coupled receptor activity",3.62838332114118,-4.9426112457436,2.14688730640721,2.69635638873333,-1.8660419549022,0.924139050970712,0.01623262),
c("GO:0004888","transmembrane signaling receptor activity",6.11558156547184,-5.11876081123752,-1.07879660753604,2.92272545799326,-1.61966423718917,0.952969194347434,0.28558307),
c("GO:0022803","passive transmembrane transporter activity",3.16020482809071,2.74672670438067,-1.50451106634788,2.63648789635337,-2.34915579045561,0.575785582078655,0.2878103),
c("GO:0046873","metal ion transmembrane transporter activity",2.65544989027067,5.75229894038267,-1.58952968857852,2.56110138364906,-2.08999590327708,0.527134645712421,0.2878103),
c("GO:0008324","cation transmembrane transporter activity",4.12582297000732,4.71009901546663,-2.40232901940226,2.75204844781944,-1.78409509697398,0.53683050390306,0.34449313),
c("GO:0022890","inorganic cation transmembrane transporter activity",3.73811265544989,4.17311958291575,-1.50197287652218,2.70926996097583,-1.71332437293347,0.533985623882805,0.34612235),
c("GO:0005216","ion channel activity",2.89685442574982,5.7451229402216,1.25548919090278,2.59879050676312,-2.08999590327708,0.501607561022712,0.37507119),
c("GO:0005261","cation channel activity",2.27505486466715,4.10695068111249,0.288712472106531,2.49415459401844,-2.08999590327708,0.490801207908046,0.37507119),
c("GO:0022836","gated channel activity",2.15801024140454,5.14736594981205,2.24391323443788,2.47129171105894,-1.64519674122024,0.521929176886414,0.37507119),
c("GO:0022839","ion gated channel activity",0.234089246525238,3.43211847575445,1.44185560793064,1.51851393987789,-1.70687040655963,0.521929176886414,0.37507119),
c("GO:0005272","sodium channel activity",0.307242136064375,5.46845915077406,0.174000648843017,1.63346845557959,-1.78409509697398,0.471791245868758,0.38451833),
c("GO:0015081","sodium ion transmembrane transporter activity",0.899780541331383,6.28127880159892,-0.546311699242424,2.09342168516224,-1.46615414959179,0.510314670541161,0.50910914));

one.data <- data.frame(revigo.data);
names(one.data) <- revigo.names;
one.data <- one.data [(one.data$plot_X != "null" & one.data$plot_Y != "null"), ];
one.data$plot_X <- as.numeric( as.character(one.data$plot_X) );
one.data$plot_Y <- as.numeric( as.character(one.data$plot_Y) );
one.data$log_size <- as.numeric( as.character(one.data$log_size) );
one.data$value <- as.numeric( as.character(one.data$value) );
one.data$frequency <- as.numeric( as.character(one.data$frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$dispensability) );
#head(one.data);


# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, plot_Y, colour = value, size = log_size), alpha = I(0.6) );
p1 <- p1 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$value), 0) );
p1 <- p1 + geom_point( aes(plot_X, plot_Y, size = log_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) ));
p1 <- p1 + scale_size( range=c(5, 30)) + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
ex <- one.data [ one.data$dispensability < 0.15, ];
p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + labs (y = "semantic space x", x = "semantic space y");
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);


# --------------------------------------------------------------------------
# Output the plot to screen

p1;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

ggsave("/path_to_your_file/revigo-plot.pdf");

