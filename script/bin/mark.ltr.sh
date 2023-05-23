
#!/usr/bin/bash
if [ $# -lt 1 ]
then
        echo "sh $0 <id>"
        echo "### please run $0 in the output directory ###"
        exit 0
fi

PREFIX=$1

SHELL_FOLDER=$(dirname "$0")
Pwd=`pwd`
source ${SHELL_FOLDER}/config.txt

fai=`ls ${PREFIX}*.fa.fai|head -n 1`

cat ${cutoff} | awk '{print "perl '${markLTR}' '${PREFIX}'.id.65.cov.80.blast.bed.cluster.best."$1" '${PREFIX}'.mafft.identity.out.gz "$2" '${PREFIX}'.mafft.identity.out.paired."$1"."$2".txt '${fai}'."$1}'|sh


#for length, identity in `cat ${cutoff}`
#do
#	perl ${markLTR} ${PREFIX}.id.65.cov.80.blast.bed.cluster.best.${length} ${PREFIX}.mafft.identity.out ${identity} ${PREFIX}.mafft.identity.out.paired.${length}.${identity}.txt
#done
