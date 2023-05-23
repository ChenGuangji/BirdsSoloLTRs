# Avain Solo-LTR Research
## INPORTANT NOTE
The genomes could also be download from the NCBI database according to Supplemental Table S1. All the avian genomes used in this study are available at Bird 10k project website: https://b10k.genomics.cn/.

## Customized codes
* Solo-LTRs identification
```bash
WORK="work_path"
data="data_path"
bin="bin_path"

# ******************************************
# 1. ltr-harvest
#
# ltr-harvest for paired ltr
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "mkdir -p '${WORK}/'"$1"; cd '${WORK}/'"$1"; ln -s '${data}'/fa/"$1".genomic.fa ./; sh '${bin}'/ltrharvest.sh "$1".genomic.fa"}' > step_1.sh

# ******************************************
# 2. overlap
#
# overlap the ltr-harvest and repeatmasker
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "cd '${WORK}/'"$1"/ ; sh '${bin}'/overlapped.sh "$1" "$1".genomic.fa"}' > step_2.sh

# ******************************************
# 3 & 4. cd-hit
#
# cd-hit reslut combine and re-cdhit
# ******************************************
cat short_name.xls | tail -n +2 | awk 'BEGIN{print "mkdir -p '${data}'/cdhit/raw ;"};{print "ln -s '${WORK}/'"$1"/"$1".ltr_harvest.repeatmasker.bed.cdhit.95.cds '${data}'/cdhit/raw/"};END{print "cat '${data}'/cdhit/raw/* > '${data}'/cdhit/all.362.cdhit.95.cds"}' >step_3.sh
echo "cd-hit -c 0.95 -d 50 -i '${data}'/cdhit/all.362.cdhit.95.cds -o '${data}'/cdhit/all.362.cdhit.0.95.round2.cds 1>'${data}'/cdhit/cdhit.log 2>&1" >step_4.sh

# ******************************************
# 5. blastn
#
# run blastn
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "cd '${WORK}/'"$1" ; time sh '${bin}'/run.blastn.sh 20 10 "$1".genomic.fa "$1" '${data}'/cdhit/all.362.cdhit.0.95.round2.cds "}' > step_5.sh

# ******************************************
# 6. filter scaffold less than 10k/15k/20k
#
# filter scaffold less than 10k/15k/20k
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "cd '${WORK}/'"$1" ; time sh '${bin}'/fasize.filter.sh "$1".genomic.fa.fai "$1".id.65.cov.80.blast.bed.cluster.best"}' > step_6.sh

# ******************************************
# 7. paiewise shell
#
# Generate the pairwise directory and shell
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "cd '${WORK}/'"$1" ; time perl '${bin}'/ltr.pairwise.pl "$1".id.65.cov.80.blast.bed.cluster.best.10k "$1".id.65.cov.80.blast.bed.cluster.best.10k.cds 20000 '${WORK}/'"$1}' > step_7.sh

# ******************************************
# 8. run paiewise mafft
#
# run paiewise mafft shell
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "cd '${WORK}/'"$1" ; time sh '${bin}'/cal_mafft_identity.sh run.mafft.shell "$1" > run.step_8.log "}' >step_8.sh

# ******************************************
# mark the ltr
#
# using RBH method mark the paired ltr
# ******************************************

cat short_name.xls | tail -n +2 | awk '{print "cd '${WORK}/'"$1" ; sh '${bin}'/mark.ltr.sh "$1}' > step_9_MarkLTR.sh
```
* the code for the article Figure
```R

```
