![image](https://github.com/ChenGuangji/BirdsSoloLTRs/assets/31179245/4e8ede1c-d518-4349-acd7-1593188ec600)![image](https://github.com/ChenGuangji/BirdsSoloLTRs/assets/31179245/ba97487a-600d-4754-b15a-1c7746bc08b5)![image](https://github.com/ChenGuangji/BirdsSoloLTRs/assets/31179245/998d0aaf-ff64-4c1a-ab5c-5c01d7e80e45)![image](https://github.com/ChenGuangji/BirdsSoloLTRs/assets/31179245/94f980a4-32e9-4d98-ae9a-2ce571a47173)# Birds Solo-LTRs
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
* R package AnnotationForge v.1.42.0
* [hal2maf](https://github.com/ComparativeGenomicsToolkit/hal)
* [REVIGO tool](http://revigo.irb.hr/)
* [FindM tool](http://ccg.vital-it.ch/ssa/findm.php)
* [FIJI](https://imagej.net/Fiji)
