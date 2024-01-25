# Script for target site duplications(TSD) checking
## TSD_shell_generate.pl
example: `perl TSD_shell_generate.pl [10|15|20] input_LTRs.txt genome.fa  input_LTRs.txt.tmp > TSD_all.shell`
using the `paralleltask` to run the shell
example: `nohup paralleltask -t local -l 1 -p 1 -m 50 -M 20G -r 10 TSD_all.shell &`

## TSD_blastout.pl
Determine whether TSD(4-6bp) exists according to blast results(-outfmt 7 -word_size 4)
example: `perl TSD_blastout.pl blastOutfmt7 prefixTag`
