#!/usr/bin/perl -w
use strict;

unless (@ARGV == 2){
	print "perl $0 blastoutFile TagName\n";
	exit;
}
my $file = shift;
my $name = shift;

my %hash;
my ($id1,$id2,$ident,$TSD,$trash);

open(IN,$file) or die $!;
while(<IN>){
	chomp;
	next if(/^#/);
	($id1,$id2,$ident,$TSD,$trash) = split(/\t/,$_,5);
	next if ($id1 eq $id2);
	if (exists $hash{$id1}{$id2}){
		next if ($TSD < $hash{$id1}{$id2});
		$hash{$id1}{$id2}=$TSD;$hash{$id2}{$id1}=$TSD;
	}else{$hash{$id1}{$id2}=$TSD;$hash{$id2}{$id1}=$TSD;}
}
close IN;

if(exists $hash{$id1}{$id2}){
	my $TSD=$hash{$id1}{$id2};
	if($TSD >= 6){
		print "$name\tWithOutTSD\t$TSD\n";
	}else{
		print "$name\tWithTSD\t$TSD\n";
	}
}else{
	print "$name\tWithOutTSD\t-\n";
}

