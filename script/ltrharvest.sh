#!/usr/bash
cds=$1
gt="/software/genometools-1.6.1/bin/gt"
${gt} suffixerator -db ${cds} -indexname ${cds} -tis -suf -lcp -des -ssp -sds -dna
${gt} ltrharvest -index ${cds} -gff3 ${cds}.ltr.gff -seqids -out ${cds}.ltr.gff.fa
${gt} gff3 -sort ${cds}.ltr.gff > ${cds}.ltr.sort.gff
${gt} ltrdigest -seqfile ${cds} -hmms /database/HMMs/*.hmm -matchdescstart < ${cds}.ltr.sort.gff > ${cds}.ltr.sort.digest.gff

