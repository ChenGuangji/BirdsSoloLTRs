#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin $Script);

unless (@ARGV==5) {
		print "perl $0 <best.nk> <identity.file> <cutoff> <outdir.file> <fasize> \n";
		die ;
}

my ($bed,$idfile,$cutoff,$outfile,$fasize)=@ARGV;

my (%RBH,%RBHpaired,%RBHsolo,%RBHraw,%pairwise,%hash,%out,%FA);

open (FASIZE,$fasize) || die "$fasize";
while (<FASIZE>) {
	chomp;
	my($scaf,$tmp)=split(/\s/,$_,2);
	$FA{$scaf}=1;
}
close FASIZE;

open (BED,$bed) or die $!;
while (<BED>) {
	chomp;
	my ($scaffold,$start,$end,$descr,$score,$direction)=split(/\t/,$_,6);
	my $len=$end-$start;
	my $id = "$descr"."::"."$scaffold".":"."$start"."-"."$end"."("."$direction".")";
	#print "$id\n";

	if (!exists $FA{$scaffold}) {next;}

	push @{$pairwise{$scaffold}}, $id;
	$hash{$id}{"scaffold"}=$scaffold;
	$hash{$id}{"start"}=$start;
	$hash{$id}{"end"}=$end;
	$hash{$id}{"score"}=$score;
	$hash{$id}{"direction"}=$direction;
	$hash{$id}{"out"}=join("\t",$scaffold,$start,$end,$descr,$score,$direction);
}
close BED;

open (ID,"gzip -dc $idfile|") or die $!;
while (<ID>) {
	chomp;
	my ($id1,$id2,$len1,$len2,$match,$identity1,$identity2,$not_gap,$RateNotGap1,$RateNotGap2,$headGap,$tailGap)=split(/\t/,$_,12);
	$id1 =~ /^(?<descr1>.*)::(?<scaffold1>.*):(?<start1>.*)-(?<end1>.*)\((?<direction1>.*)\)$/;
	my $direction1=$+{direction1}; my $scaffold1=$+{scaffold1};
	$id2 =~ /^(?<descr2>.*)::(?<scaffold2>.*):(?<start2>.*)-(?<end2>.*)\((?<direction2>.*)\)$/;
	my $direction2=$+{direction2}; my $scaffold2=$+{scaffold2};

	if (!exists $FA{$scaffold1}) {next;}
	if (!exists $FA{$scaffold2}) {next;}


#	$RBHraw{$id1}{$id2}=$identity1;
#	$RBHraw{$id2}{$id1}=$identity2;

	#if ($identity1 < $cutoff or $identity2 < $cutoff) {next;}
	if ($direction1 ne $direction2) {next;}

	$RBH{$id1}{$id2}=$identity1;
	$RBH{$id2}{$id1}=$identity2;
}
close ID;

%RBHraw = %RBH;

foreach my $id1 (sort {$a cmp $b} keys %RBHraw) {
	if (exists $RBHpaired{$id1}) {next;}
	if (!exists $RBH{$id1}) {next;}
	my %tmp1 = %{$RBH{$id1}};
	my @arrayid2 = sort {$tmp1{$b} <=> $tmp1{$a} or $a cmp $b} keys %tmp1;
	my $value=$tmp1{$arrayid2[0]};

	if ($value < $cutoff){
		$RBHsolo{$id1}=$value;
		next;
	}

	for (my $pos = 0; $pos < scalar(@arrayid2); $pos++) {
		if ($tmp1{$arrayid2[$pos]} < $cutoff) {
			last;
		}
		my $id2=$arrayid2[$pos];
		if (!exists $RBH{$id2}) {next;}
		my %tmp2 = %{$RBH{$id2}};
		my @arrayid1 = sort {$tmp2{$b} <=> $tmp2{$a} or $a cmp $b} keys %tmp2;
		if ($arrayid1[0] eq $id1) {
			if ($tmp2{$arrayid1[0]} < $cutoff){
				next;
			}else{
				$RBHpaired{$id1}=$id2;
				$RBHpaired{$id2}=$id1;
				delete @RBH{$id1,$id2};
				last;
			}
		}
	}
}


open (OUT,">$outfile") or die $!;
foreach my $id1 (sort {$a cmp $b} keys %RBHpaired) {
	if (exists $out{$id1}) {
		next;
	}
	my $id2=$RBHpaired{$id1};
	print OUT "[paired-l1]\t$id1\t$id2\t$RBHraw{$id1}{$id2}\t$RBHraw{$id2}{$id1}\n";
	$out{$id1}=1;
	$out{$id2}=1;
}

foreach my $id (sort {$a cmp $b} keys %RBHsolo){
	print OUT "[solo-identity]\t$id\t-\t$RBHsolo{$id}\t$RBHsolo{$id}\n";
	$out{$id}=1;
}

foreach my $id (sort {$a cmp $b} keys %hash){
	if (exists $out{$id}) {
		next;
	}
	if (exists $RBH{$id}) {
		my %tmp = %{$RBH{$id}};
		my %tmp2 = %{$RBHraw{$id}};
		my @arrayid = sort {$tmp{$b} <=> $tmp{$a} or $a cmp $b} keys %tmp;
		foreach my $id2 (@arrayid){
			if (exists $out{$id2}){
				next;
			}else{

				my @realmax = sort {$tmp2{$b} <=> $tmp2{$a} or $a cmp $b} keys %tmp2;
				my $realmax_identity = $tmp2{$realmax[0]};
				my $restmax_identity = $tmp{$id2};

				if ($tmp{$id2} < $cutoff or $RBHraw{$id2}{$id} < $cutoff){
					print OUT "[solo-identity]\t$id\t-\t$restmax_identity\t$realmax_identity\n";
					$out{$id}=1;
				}else{
					print OUT "[paired-l2]\t$id\t$id2\t$tmp{$id2}\t$RBHraw{$id2}{$id}\n";
					$out{$id}=1;
					$out{$id2}=1;
				}
				last;
			}
		}
	}else{
		print OUT "[solo-20k]\t$id\t-\t-\t-\n";
	}
}

close OUT;

