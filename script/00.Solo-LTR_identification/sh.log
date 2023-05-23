
# ******************************************
# 1. ltr-harvest
#
# ltr-harvest for paired ltr
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "mkdir -p /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1"; cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1"; ln -s /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/fa/"$1".genomic.fa ./; sh /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/03.ERV_of_B10K/bin/ltrharvest.sh "$1".genomic.fa"}' > step_1.sh

# ******************************************
# 2. overlap
#
# overlap the ltr-harvest and repeatmasker
# ******************************************
cat short_name.xls | tail -n +2 | awk '{print "cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1"/ ; sh /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/bin/overlapped.sh "$1" "$1".genomic.fa"}' > step_2.sh

# ******************************************
# 3 & 4. cd-hit
#
# cd-hit reslut combine and re-cdhit
# ******************************************
cat short_name.xls | tail -n +2 | grep -v "NCBI-012" | awk 'BEGIN{print "mkdir -p /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/raw ;"};{print "ln -s /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1"/"$1".ltr_harvest.repeatmasker.bed.cdhit.95.cds /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/raw/"};END{print "cat /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/raw/* > /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/all.362.cdhit.95.cds"}' >step_3.sh
echo "/hwfssz5/ST_DIVERSITY/B10K/PUB/local/basic_bio-tool/cd-hit-v4.8.1/bin/cd-hit -c 0.95 -d 50 -i /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/all.362.cdhit.95.cds -o /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/all.362.cdhit.0.95.round2.cds 1>/hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/cdhit.log 2>&1" >step_4.sh

# ******************************************
# 5. blastn
#
# run blastn
# ******************************************
cat short_name.xls | tail -n +2 | grep -v "NCBI-012" | awk '{print "cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1" ; time sh /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/bin/run.blastn.sh 20 10 "$1".genomic.fa "$1" /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/data/cdhit/all.362.cdhit.0.95.round2.cds "}' > step_5.sh

# ******************************************
# 6. filter scaffold less than 10k/15k/20k
#
# filter scaffold less than 10k/15k/20k
# ******************************************
cat short_name.xls | tail -n +2 | grep -v "NCBI-012" | awk '{print "cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1" ; time sh /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/bin/fasize.filter.sh "$1".genomic.fa.fai "$1".id.65.cov.80.blast.bed.cluster.best"}' > step_6.sh

# ******************************************
# 7. paiewise shell
#
# Generate the pairwise directory and shell
# ******************************************
cat short_name.xls | tail -n +2 | grep -v "NCBI-012" | awk '{print "cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1" ; time perl /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/bin/ltr.pairwise.pl "$1".id.65.cov.80.blast.bed.cluster.best.10k "$1".id.65.cov.80.blast.bed.cluster.best.10k.cds 20000 /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1}' > step_7.sh

# ******************************************
# 8. run paiewise mafft
#
# run paiewise mafft shell
# ******************************************
cat short_name.xls | tail -n +2 | grep -v "NCBI-012" | awk '{print "cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1" ; time sh /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/bin/cal_mafft_identity.sh run.mafft.shell "$1" > run.step_8.log "}' >step_8.sh


# ******************************************
# backup 8. generate identity shell
#
# generate identity shell for each
# ******************************************
cat short_name.xls | tail -n +2 | grep -v "NCBI-012"|awk '{print "cd /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1" ; echo \"time /hwfssz5/ST_DIVERSITY/B10K/PUB/USER/chenguangji/local/bin/parallel -j 10 < /hwfssz5/ST_DIVERSITY/B10K/USER/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1"/run.mafft.shell.identity.shell > "$1".mafft.identity.out && echo done\" > parallel.run.mafft.identity.shell"}'|sh


# ******************************************
# mark the ltr
#
# using RBH method mark the paired ltr
# ******************************************

cat short_name.xls | tail -n +2 | grep -v "NCBI-012" | awk '{print "cd /hwfssz5/ST_EARTH/P18Z10200N0100/chenguangji/02.B10K/16.Endogenous_virus/04.LTR_of_B10K/work/"$1" ; sh /hwfssz5/ST_EARTH/P18Z10200N0100/chenguangji/02.B10K/16.Endogenous_virus/05.LTR_of_Mammalia/bin/mark.ltr.sh "$1}' > step_9_MarkLTR.sh
