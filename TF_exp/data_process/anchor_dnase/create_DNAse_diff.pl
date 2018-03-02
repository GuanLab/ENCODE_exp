#!/usr/bin/perl
#
@mat=glob "/state4/gyuanfan/TF_model/data/anchor_bam_DNAse/*";

foreach $file (@mat){
	$i=0;
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;
		$ref[$i]+=$line;
		$i++;
	}
	close OLD;
	$count++;
}

system "mkdir /state4/gyuanfan/TF_model/data/anchor_bam_DNAse_diff";
foreach $file (@mat){
	@t=split '/', $file;
	$name=pop @t;
	$i=0;
	open OLD, "$file" or die;
	open NEW, ">/state4/gyuanfan/TF_model/data/anchor_bam_DNAse_diff/$name" or die;
	while ($line=<OLD>){
		chomp $line;
		$avg=$ref[$i]/$count;
		$val=$line-$avg;
		print NEW "$val\n";
		$i++;
	}
	close OLD;
	close NEW;
}

	
