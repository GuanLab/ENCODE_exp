#!/usr/bin/perl

## creating training and test samples from ChIPseq data

srand(3.14*4); # PARAMETER: change the seed and sample different lines
$path="/home/hyangl/TF_model/data/sample/04/"; # change the directory names 01,02,..

$tf=$ARGV[0];
system "mkdir ${path}${tf}";
@mat=glob "/home/gyuanfan/2017/TF/data/raw/ChIPseq/labels/$tf*";

foreach $file (@mat){
	open INPUT, "$file" or die;
	$line=<INPUT>;
	chomp $line;
	@header=split "\t", $line;
	shift @header;
	shift @header;
	shift @header;
	foreach $cell (@header){
		open $cell, ">${path}${tf}/F.${tf}.${cell}.tab" or die;
	}
	while($line=<INPUT>){
		chomp $line;
		@tmp=split "\t", $line;
		$chr=shift @tmp;
		$start=shift @tmp;
		$end=shift @tmp;
		foreach $cell (@header){
			$val=shift @tmp; # exclude "Ambiguous" peaks, result in different number of rows in tf_cell files
			if($val eq "U"){
				$rand=rand(300); # subsample 1/300
				if($rand<1){
					print $cell "$chr\t$start\t$end\t0\n";
				}
			}
			if($val eq "B"){
				print $cell "$chr\t$start\t$end\t1\n";
			}
		}
	}
	close INPUT;
	foreach $cell (@header){
		close $cell;
	}
}


#[guanlab11]/state4/hongyang/TF/code_new13/orange_xxx_top20/ATF2		
	
	
