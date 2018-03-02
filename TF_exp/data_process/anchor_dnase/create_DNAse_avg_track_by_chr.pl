#!/usr/bin/perl
#
$chr_id=$ARGV[0];
$cell=$ARGV[1];
@mat=glob "/state1/gyuanfan/DNAse_track/*${cell}*";

foreach $gggg (@mat){
	open OLD, "$gggg" or die;
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		$chr=$table[0];
		$start=$table[1];
		$avg=$table[2];
		if ($chr_id eq $chr){
				$all_avg[$start]+=$avg;
				$start++;
			if ($start>$max){
				$max=$start;
			}
		}
	}
	close OLD;
}

system "mkdir /state1/gyuanfan/DNAse_track_avg";
open NEW, ">/state1/gyuanfan/DNAse_track_avg/${cell}_${chr_id}.txt" or die;
$i=1;
while ($i<$max){
	if ($all_avg[$i]>0){
		$val=$all_avg[$i];
		print NEW "$i";
		print NEW "\t$val\n";
	}
	$i++;
}
close NEW;
	

