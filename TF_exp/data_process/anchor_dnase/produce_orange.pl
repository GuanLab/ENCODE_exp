#!/usr/bin/perl
#

@mat=glob "/home/gyuanfan/2017/TF/data/raw/essential_training_data/DNASE/fold_coverage_big/*";
system "rm -rf /state4/gyuanfan/TF_model/data/orange";
system "mkdir /state4/gyuanfan/TF_model/data/orange";

$file="../../annotations/test_regions.blacklistfiltered.bed";
foreach $gggg (@mat){
	@t=split '\.', $gggg;
	$cell=$t[1];
	open NEW, ">/state4/gyuanfan/TF_model/data/orange/$cell" or die;
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		$chr=$table[0];
		$start=$table[1];
		$end=$table[2];
		if (($cell eq $old_cell) && ($chr eq $old_chr)){}else{
			@feature=();
			print "$cell\n";
			open G, "$gggg" or die;
			while ($line=<G>){
				chomp $line;
				@table=split "\t", $line;
				if ($table[0] eq $chr){
					$i=int($table[1]/50)*50;
					$table[2]=int($table[2]/50)*50+50;
					while ($i<$table[2]){
						$feature[$i]++;
						$i=$i+50;
					}
				}
			}
			close G;
			$old_chr=$chr;
			$old_cell=$cell;
			
		}
		if (defined $feature[$start]){
			print NEW "$feature[$start]\n";
		}else{
			print NEW "0\n";
		}
	}
	close OLD;
	close NEW;
}

	

