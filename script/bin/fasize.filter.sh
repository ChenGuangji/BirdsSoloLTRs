#!/usr/bin/bash
fai=$1
best=$2
SHELL_FOLDER=$(dirname "$0")
source ${SHELL_FOLDER}/config.txt

awk '$2 >= 10000' ${fai} > ${fai}.10k
awk '$2 >= 15000' ${fai} > ${fai}.15k
awk '$2 >= 20000' ${fai} > ${fai}.20k

${perl} ${fishInWinter} -bf table -ff table -bc 1 -fc 1 ${fai}.10k ${best} > ${best}.10k
${perl} ${fishInWinter} -bf table -ff table -bc 1 -fc 1 ${fai}.15k ${best} > ${best}.15k
${perl} ${fishInWinter} -bf table -ff table -bc 1 -fc 1 ${fai}.20k ${best} > ${best}.20k

fa=$(basename ${fai} .fai)
${bedtools} getfasta -fi $fa -bed ${best}.10k -s -name > ${best}.10k.cds
