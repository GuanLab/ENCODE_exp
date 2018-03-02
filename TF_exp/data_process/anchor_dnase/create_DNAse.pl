#!/usr/bin/perl
#

@mat=glob "/home/gyuanfan/2017/TF/data/raw/essential_training_data/DNASE/fold_coverage_big/*MC*";
system "mkdir /state4/gyuanfan/TF_model/data/anchor_bam_DNAse";

$file="../../../annotations/test_regions.blacklistfiltered.bed";
foreach $gggg (@mat){
	@t=split '\.', $gggg;
	$cell=$t[1];
	open NEW, ">/state4/gyuanfan/TF_model/data/anchor_bam_DNAse/$cell" or die;
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
				$cell_tmp=$cell;
			if ($cell =~/IM/){
				$cell_tmp=~s/-//g;
			}
			open G, "/state1/gyuanfan/DNAse_track_avg_anchor/${cell_tmp}_${chr}.txt" or die;
			while ($line=<G>){
				chomp $line;
				@table=split "\t", $line;
				$i=$table[0];
				$feature[$i]=$table[1];
			}
			close G;
			$old_chr=$chr;
			$old_cell=$cell;
			
		}

		$c=0;
		$t=0;
		$i=$start;
		while ($i<$end){
			$t+=$feature[$i];
			$c++;
			$i++;
		}
		$avg=$t/$c;
		$avg=int(10000*$avg)/10000;
		print NEW "$avg\n";
	}
	close OLD;
	close NEW;
}

	

sub reverse_complement {
        my $dna = shift;

	         my $revcomp = reverse($dna);
	
		$revcomp =~ tr/ACGTacgt/TGCAtgca/;
	         	               return $revcomp;
}
