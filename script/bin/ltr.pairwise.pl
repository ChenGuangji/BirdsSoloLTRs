#!/usr/bin/perl -w
use strict;
use FindBin qw($Bin $Script);

unless (@ARGV==4) {
	print "perl $0 <best.nk> <cds> <distance> <outdir>\n";
	die ; 
}

my %config;
parse_config("$Bin/config.perl.txt",\%config);

my ($bed,$cds,$distance,$outdir)=@ARGV;
my (%pairwise,%hash,%genome);

open (IN,$bed) or die $!;
while (<IN>) {
	chomp;
	my ($scaffold,$start,$end,$descr,$score,$direction)=split(/\t/,$_,6);
	my $len=$end-$start;
	my $id = "$descr"."::"."$scaffold".":"."$start"."-"."$end"."("."$direction".")";
	#print "$id\n";
	push @{$pairwise{$scaffold}}, $id;
	$hash{$id}{"scaffold"}=$scaffold;
	$hash{$id}{"start"}=$start;
	$hash{$id}{"end"}=$end;
	$hash{$id}{"score"}=$score;
	$hash{$id}{"direction"}=$direction;
}
close IN;

open (CDS,$cds) || die "$!\n";
$/=">";<CDS>;$/="\n";
while(<CDS>){
	my ($scaf,$seq);
	$scaf=$1 if (/^(\S+)/);
	$/=">";
	$seq=<CDS>;
	chomp($seq);
	$seq=~s/\s+//g;
	$seq=~tr/atcg/ATCG/;
	$/="\n";
	$genome{$scaf}=$seq;
}
close CDS;


my $parentdir="00";
my $subdir = "000";
my $parentloop=0;
my $loop = 0;
my $output="$outdir/pairwise";
mkdir "$output" unless (-d "$output");

my $cmd;

open (OUT,">$outdir/run.mafft.shell") or die $!;

foreach my $scaffold (sort keys %pairwise) {
	my @arr = @{$pairwise{$scaffold}};
	if (@arr==1) {
		next;
	}
	my ($xid,$yid,$alnin,$alnout,$alnlog);
	for (my $x = 0; $x <= $#arr; $x++) {
		for (my $y = $x + 1; $y <= $#arr; $y++) {
			$xid=$arr[$x];
			$yid=$arr[$y];
			my @position = ($hash{$xid}{"start"}, $hash{$xid}{"end"},$hash{$yid}{"start"},$hash{$yid}{"end"});
			my @sorted_position = sort { $a <=> $b } @position;

			my $real_distance = $sorted_position[2] - $sorted_position[1] ;

			if ($real_distance > $distance) {
				next;
			}

			if($loop % 100 == 0){
				if($parentloop % 100 ==0){
					$parentdir++;
					mkdir ("$output/$parentdir");
					$subdir="000";
				}
				$subdir++;
				mkdir("$output/$parentdir/$subdir");
				$parentloop++;
			}

			$alnin="$output/$parentdir/$subdir/$scaffold.$x\_$y.fa";
			$alnout="$output/$parentdir/$subdir/$scaffold.$x\_$y.mafft_ginsi.fa";
			$alnlog="$output/$parentdir/$subdir/$scaffold.$x\_$y.log";

			open (PRE,">$alnin") or die $!;
			print PRE ">$xid\n$genome{$xid}\n>$yid\n$genome{$yid}\n";
			close PRE;

			$cmd = "$config{mafft} --anysymbol --thread 3 $alnin >$alnout 2>$alnlog;\n";
			print OUT $cmd;
			$loop++;
		}
	}
}
#open (OUT,">$outdir/run.mafft.shell") or die $!;
#print OUT $cmd;

close OUT;

sub parse_config{
	my $conifg_file = shift;
	my $config_p = shift;
	my $error_status = 0;
	open IN,$conifg_file || die "fail open: $conifg_file";
	while (<IN>) {
		next if /^#/;
		if (/(\S+)\s*=\s*(\S+)/) {
			my ($software_name,$software_address) = ($1,$2);
			$config_p->{$software_name} = $software_address;
			if (! -e $software_address){
				warn "Non-exist:  $software_name  $software_address\nPlease re-configure the config.txt file\n";
				$error_status = 1;
			}
		}
	}
	close IN;
	die "\nExit due to error of software configuration\n" if($error_status);
}

