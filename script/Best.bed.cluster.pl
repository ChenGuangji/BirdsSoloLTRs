#!/usr/bin/perl -w
use strict;

die "Usage: <bed>\n" unless @ARGV == 1;

=pop
LTR_retrotransposon1001(+)	2	68	APP-001::scaffold1680:18820-19165(+)	51.2	+	1
=cut

open (IN,$ARGV[0]) or die;
my %hash;
while(<IN>){
	 chomp;
	 my($sca,$begin,$end,$info,$score,$stand,$cluster)=split(/\s+/,$_,7);
	 if (exists $hash{$cluster}) {
	 	if($hash{$cluster}{"score"} < $score){
			#my $tempp=$hash{$cluster}{"score"};
			#print "$tempp\t$score\n";
	 		$hash{$cluster}{"sca"}=$sca;
	 		$hash{$cluster}{"begin"}=$begin;
	 		$hash{$cluster}{"end"}=$end;
	 		$hash{$cluster}{"info"}=$info;
	 		$hash{$cluster}{"score"}=$score;
	 		$hash{$cluster}{"stand"}=$stand;
	 	}elsif($hash{$cluster}{"score"} == $score && $info=~m/^NC_0/){
			$hash{$cluster}{"sca"}=$sca;
			$hash{$cluster}{"begin"}=$begin;
			$hash{$cluster}{"end"}=$end;
			$hash{$cluster}{"info"}=$info;
			$hash{$cluster}{"score"}=$score;
			$hash{$cluster}{"stand"}=$stand;
		}
	 }else{
	 	$hash{$cluster}{"sca"}=$sca;
	 	$hash{$cluster}{"begin"}=$begin;
	 	$hash{$cluster}{"end"}=$end;
	 	$hash{$cluster}{"info"}=$info;
	 	$hash{$cluster}{"score"}=$score;
	 	$hash{$cluster}{"stand"}=$stand;
	 }
}
close IN;

foreach my $cluster(sort {$a <=> $b} keys(%hash)){
	my($sca,$begin,$end,$info,$score,$stand)=($hash{$cluster}{"sca"},$hash{$cluster}{"begin"},$hash{$cluster}{"end"},$hash{$cluster}{"info"},$hash{$cluster}{"score"},$hash{$cluster}{"stand"});
	print join("\t",$sca,$begin,$end,$info,$score,$stand)."\n";
}
