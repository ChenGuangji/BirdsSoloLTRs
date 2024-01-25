#!/usr/bin/perl -w
use strict;
use List::Util qw(min max);
use FindBin qw($Bin $Script);

unless (@ARGV == 5){
	print "perl $0 distance[10,15,20] InList[20k-85.list] workDir fasta OutList\n";
	exit;
}
my $dist= shift;
my $in_lst = shift;
my $WorkDir = shift;
`mkdir -p $WorkDir/tmpTSD_$dist/`;
my $fasta = shift;
my $Out_lst = shift;


open(IN,"$in_lst") or die $!;
open(OUT,">$Out_lst") or die $!;
my ($PN,$SN)=(1,1);
while(<IN>){
	chomp;
	my($tag,$info1,$info2,$trash)=split(/\t/,$_,4);
	if($tag=m/pair/){
		&PairTSD($info1,$info2,$PN);
		print OUT "$_\tPaired_$PN\n";
		$PN++;
	}else{
		&SoloTSD($info1,$SN);
		print OUT "$_\tSolo_$SN\n";
		$SN++;
	}
}
close IN;
close OUT;

sub PairTSD{
	my ($info1,$info2,$PN) = @_;
	$info1 =~ /::(?<Sid>.*?):(?<start1>.*?)-(?<end1>.*?)\((?<strand>.*?)\)/;
	my $Sid=$+{Sid}; my $start1=$+{start1}; my $end1=$+{end1}; my $strand=$+{strand};
	$info2 =~ /::(?<Sid>.*?):(?<start2>.*?)-(?<end2>.*?)\((?<strand>.*?)\)/;
	my $start2=$+{start2}; my $end2=$+{end2};
	my $min = min($start1,$end1,$start2,$end2);
	my $max = max($start1,$end1,$start2,$end2);
	&execute($Sid,$min,$max,"Paired_$PN",$strand);
}

sub SoloTSD{
	my ($info1,$SN) = @_;
	$info1 =~ /::(?<Sid>.*?):(?<start1>.*?)-(?<end1>.*?)\((?<strand>.*?)\)/;
	my $Sid=$+{Sid}; my $start1=$+{start1}; my $end1=$+{end1}; my $strand=$+{strand};
	my $min = min($start1,$end1);
	my $max = max($start1,$end1);
	&execute($Sid,$min,$max,"Solo_$SN",$strand);
}

sub execute{
	my ($Sid,$min,$max,$name,$strand)=@_;
	my $a = $min - $dist; my $b = $max + $dist;
	if ($a < 0){ $a = 0;}
	print "echo -e \"$Sid\\t$a\\t$min\\tup_$dist\_$name\\t.\\t$strand\\n$Sid\\t$max\\t$b\\tdown_$dist\_$name\\t.\\t$strand\\n\" > $WorkDir/tmpTSD_$dist/$name.bed && bedtools getfasta -bed $WorkDir/tmpTSD_$dist/$name.bed -fi $fasta -s > $WorkDir/tmpTSD_$dist/$name.bed.fasta && makeblastdb -in $WorkDir/tmpTSD_$dist/$name.bed.fasta -dbtype nucl > /dev/null && blastn -word_size 4 -query $WorkDir/tmpTSD_$dist/$name.bed.fasta -db $WorkDir/tmpTSD_$dist/$name.bed.fasta -strand plus -outfmt 7 > $WorkDir/tmpTSD_$dist/$name.bed.fasta.blastoutfmt7.out && perl $Bin/TSD_blastout.pl $WorkDir/tmpTSD_$dist/$name.bed.fasta.blastoutfmt7.out $name > $WorkDir/tmpTSD_$dist/$name.bed.fasta.blastoutfmt7.out.mark && rm -rf $WorkDir/tmpTSD_$dist/$name.bed.fasta.n* $WorkDir/tmpTSD_$dist/$name.bed.fasta $WorkDir/tmpTSD_$dist/$name.bed.fasta.blastoutfmt7.out $WorkDir/tmpTSD_$dist/$name.bed\n";
}
