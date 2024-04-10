# Birds Solo-LTRs
Data and code used in research: "Adaptive expansion of ERVK solo-LTRs is associated with Passeriformes speciation events".

## Citation

Chen, G., Yu, D., Yang Y. *et.al.* Adaptive expansion of ERVK solo-LTRs is associated with Passeriformes speciation events. ***Nat Commun***, *in press*, (2024).

## NOTES
The genomes could also be downloaded from the NCBI database according to Supplemental Table S1. All the avian genomes used in this study are available at the Bird 10k project website: https://b10k.com/.

If any questions, contact at chenguangji@genomics.cn.

## Customized codes
- [Data used in this study](data/Supplementary%20Data%201.csv)
	- [eggNOG-mapper result](data/build/out.emapper.annotations.tsv)
	- [GO analysis build script](data/build/build_local.R)
	- [tree files](data/tree/)
	- [Supplementary Information](Figures/Supplementary%20Information/)
- [Solo-LTRs identification](script/example.sh)
	- [RepeatMasker](script/RepeatMasker/RepeatMasker.sh)
	- [LTR-harvest](script/ltrharvest.sh)
	- [Classify LTR by RBH](script/mark.ltr.sh)
	- [TSD checking](script/TSD_checking/)
- [Main Figure plot](Figures/Main_Plot.Rmd)
	- [Figure_1](Figures/Figure_1/)
	- [Figure_2](Figures/Figure_2/)
	- [Figure_3](Figures/Figure_3/)
	- [Figure_4](Figures/Figure_4/)

## Software dependencies
* R package ggtree v3.3.0.900
* R package UpSetR v.1.4.0
* R package AnnotationForge v.1.42.0
* RepeatMasker v4.1.2
* RepBase library v.20170127
* LTR-harvest v1.6.1
* bedtools v2.30.0
* blastn v2.9.0
* KneadData v0.10.0
* SILVA ribosomal RNA database v0.2
* Hisat2 v.2.2.1
* HTSeq package v.0.13.5
* DESeq2 v.1.34.0
* eggNOG-mapper
* [hal2maf](https://github.com/ComparativeGenomicsToolkit/hal)
* [REVIGO tool](http://revigo.irb.hr/)
