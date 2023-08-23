### overlapped the repeatmasker result with ltr havest and using cd-hit to reduce redundancy
id=$1
fa=$2
SHELL_FOLDER=$(dirname "$0")
source ${SHELL_FOLDER}/config.txt

grep -v "#" ${fa}.ltr.gff | awk '$3=="long_terminal_repeat"' | awk '{gsub("Parent=","",$9);print $1"\t"$4-1"\t"$5"\t"$9"_D"2-NR%2"\t0\t+"}' > ${id}.ltr_harvest.bed
zcat ${data}/repeatmasker/${id}.RepeatMasker.out.gz | awk '$11~/LTR/' | awk '{gsub("C","-",$9) ; gsub("/","-",$11) ; print $5"\t"$6-1"\t"$7"\t'${id}'_"$15"_"$11"\t0\t"$9}' > ${id}.repeatmasker.ltr.bed
${bedtools} intersect -a ${id}.repeatmasker.ltr.bed -b ${id}.ltr_harvest.bed | awk '($3-$2) > 100' | awk '{print $1"\t"$2"\t"$3"\t"$4"_OL\t"$5"\t"$6}' > ${id}.ltr_harvest.repeatmasker.bed
${bedtools} getfasta -fi ${fa} -bed ${id}.ltr_harvest.repeatmasker.bed -s -nameOnly > ${id}.ltr_harvest.repeatmasker.bed.cds
${cdhit} -c 0.95 -d 50 -i ${id}.ltr_harvest.repeatmasker.bed.cds -o ${id}.ltr_harvest.repeatmasker.bed.cdhit.95.cds 1>cdhit.log 2>&1

