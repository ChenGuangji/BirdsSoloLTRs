# Birds Solo-LTRs
Data and code used in this research
## NOTES
The genomes could also be downloaded from the NCBI database according to Supplemental Table S1. All the avian genomes used in this study are available at the Bird 10k project website: https://b10k.com/.

If any questions, contact at chenguangji@genomics.cn.

## Customized codes
- [Data used in this study](data/Supplementary%20Table%20-%20Table%20S1.csv)
	- [eggNOG-mapper result](data/build/out.emapper.annotations.tsv)
	- [GO analysis build script](data/build/build_local.R)
	- [tree files](data/tree/)
- [Solo-LTRs identification](script/example.sh)
	- [RepeatMasker](script/RepeatMasker/RepeatMasker.sh)
	- [LTR-harvest](script/ltrharvest.sh)
	- [Classify LTR by RBH](script/mark.ltr.sh)
	- [TSD checking](script/TSD_checking/)
- [Main Figure plot](plot/Main_Plot.Rmd)
	- [Revigo_visualization](plot/Revigo_MF.r)

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
