#!usr/bash
ltrfa=$1
wd=$2
name="`echo $3 | sed 's/_/ /g'`"
Cpu=$4

mkdir -p ${wd}/RM_result/

RepeatMasker-4.1.2/RepeatMasker -e rmblast -pa ${Cpu} -s -species "${name}" -no_is -dir ${wd}/RM_result -a -source -html -gff -u -lcambig ${ltrfa} 1>${wd}/RM_result/log.o.txt 2>${wd}/RM_result/log.e.txt

