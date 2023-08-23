#!/usr/bin/bash
if [ $# -lt 5 ]
then
	echo "sh $0 <cut> <cpu> <species.fa> <species_id> <db>"
	echo "### please use full path of run.blastn.sh and run $0 in the output directory ###"
	exit 0
fi

Cut=$1
Cpu=$2
fa=$3
id=$4
ref=$5

SHELL_FOLDER=$(dirname "$0")
Pwd=`pwd`
faname=$(basename $fa)
source ${SHELL_FOLDER}/config.txt

${perl} ${fastaDeal} -cutf $Cut $fa -outdir ${Pwd};
ls ${Pwd}/${faname}.cut/*fa*[0-9] | awk '{print " '${formatdb}' -p F -o T -i "$1" ;'${blastn}' -task blastn -db "$1" -query '${ref}' -out "$1".id.65.cov.80.blast -outfmt \"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs qcovhsp\" -perc_identity 65 -qcov_hsp_perc 80 -num_threads 3 && echo \""$1" done\" || echo \""$1" unfinished\" "}' > ${Pwd}/run.blastn.${Cpu}.parallel
${parallel} -j ${Cpu} < run.blastn.${Cpu}.parallel > run.blastn.${Cpu}.parallel.log
source ${SHELL_FOLDER}/config.txt
ls ${Pwd}/${faname}.cut/${id}*.id.65.cov.80.blast | awk '{print "sh '${blast2best}' "$1" && echo "$1" done"}' > ${Pwd}/run.blast2best.${Cpu}.parallel
${parallel} -j ${Cpu} < run.blast2best.${Cpu}.parallel > run.blastn2best.${Cpu}.parallel.log
cat ${Pwd}/${faname}.cut/${id}*.id.65.cov.80.blast.bed.cluster.best > ${Pwd}/${id}.id.65.cov.80.blast.bed.cluster.best

