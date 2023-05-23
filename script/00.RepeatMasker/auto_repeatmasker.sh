export PATH=/usr/bin:$PATH
fa=$1
mkdir -p known/repeatmasker;
cd known/repeatmasker;
nohup perl /GACP_2016a/01.repeat_finding/find_repeat/bin/find_repeat.pl  --queue st.q -repeatmasker -cpu 70 -cutf 40 -run qsub -resource vf=3G -lib /database/repbase/repeatmaskerlibraries-20170127/Libraries/RepeatMaskerLib.embl.lib ${fa} &
