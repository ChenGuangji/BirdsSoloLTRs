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
