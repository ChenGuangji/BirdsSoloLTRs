#!/usr/bin/bash
if [ $# -lt 2 ]
then
	echo "sh $0 <shell> <id>"
	echo "### please use full path of run.blastn.sh and run $0 in the output directory ###"
	exit 0
fi

shell=$1
id=$2

SHELL_FOLDER=$(dirname "$0")
Pwd=`pwd`
#faname=$(basename $fa)
source ${SHELL_FOLDER}/config.txt

cat ${shell} | awk -F ';' '{print $1" && echo "NR" done"}' > ${shell}.echo.shell
cat ${shell} | awk '{gsub(">","",$6);print "'${perl}' '${mafftIdentity}' "$6" && echo "NR" done"}'> ${shell}.identity.shell
${parallel} -j 96 < ${shell}.echo.shell > ${shell}.echo.log && echo mafft done;
${parallel} -j 96 < ${shell}.identity.shell > ${id}.mafft.identity.log && echo identity done && grep -v "done" ${id}.mafft.identity.log > ${id}.mafft.identity.out;
