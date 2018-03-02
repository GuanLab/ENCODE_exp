#!/usr/bin/perl
#
$cell=$ARGV[0];

@mat=glob "/state1/gyuanfan/DNAse_track_avg/${cell}*";

$length=3036303386;
$ratio=1000;
$total_sample=$length/$ratio;
@all=();
foreach $file (@mat){
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		$r=rand($ratio);
		if ($r<1){
			push @all, $table[1];
		}
	}
	close OLD;
}

$default=0;
$n=scalar (@all);
$i=$n;
while ($i<$total_sample){
	push @all,$default;
	$i++;
}


@all=sort{$a<=>$b}@all;
open NEW, ">${cell}.txt" or die;
foreach $aaa (@all){
	print NEW "$aaa\n";
}

