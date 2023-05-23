blast=$1
SHELL_FOLDER=$(dirname "$0")
source ${SHELL_FOLDER}/config.txt

cat ${blast} | awk '{if($9>$10) print $2"\t"$10-1"\t"$9"\t"$1"\t"$14"\t-" ; if($9<$10) print $2"\t"$9-1"\t"$10"\t"$1"\t"$14"\t+"}' > ${blast}.bed
${bedtools} sort -i ${blast}.bed | ${bedtools} cluster -i stdin -s > ${blast}.bed.cluster
${perl} ${cluster} ${blast}.bed.cluster > ${blast}.bed.cluster.best
