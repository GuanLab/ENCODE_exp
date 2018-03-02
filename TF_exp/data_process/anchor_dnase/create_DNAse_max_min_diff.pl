#!/usr/bin/perl
#
@mat=glob "/state4/gyuanfan/TF_model/data/anchor_bam_DNAse_max_min/*";

foreach $file (@mat){
	$i=0;
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		$ref_0[$i]+=$table[0];
		$ref_1[$i]+=$table[1];
		$i++;
	}
	close OLD;
	$count++;
}

	
system "mkdir /state4/gyuanfan/TF_model/data/anchor_bam_DNAse_max_min_diff";


foreach $file (@mat){
	@t=split '/', $file;
	$name=pop @t;
	$i=0;
	open OLD, "$file" or die;
	open NEW, ">/state4/gyuanfan/TF_model/data/anchor_bam_DNAse_max_min_diff/$name" or die;
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		$avg=$ref_0[$i]/$count;
		$val=$table[0]-$avg;
		print NEW "$val";
		$avg=$ref_1[$i]/$count;
		$val=$table[1]-$avg;
		print NEW "\t$val\n";
		$i++;
	}
	close OLD;
	close NEW;
}

	
