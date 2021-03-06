#!/usr/bin/perl
#

@mat=("ATF2","CTCF","E2F1","EGR1","FOXA1","FOXA2","GABPA","HNF4A","JUND","MAX","NANOG","REST","TAF1");
system "rm -rf tf_forward_ru_top3";
system "mkdir tf_forward_ru_top3";

$file="../../annotations/test_regions.blacklistfiltered.bed";
foreach $tf (@mat){
	open NEW, ">tf_forward_ru_top3/$tf" or die;
	open OLD, "$file" or die;

	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		$chr=$table[0];
		$start=$table[1];
		$end=$table[2];
		if (($tf eq $old_tf) && ($chr eq $old_chr)){}else{
			@feature=();
			print "$tf\n";
			open G, "/state3/gyuanfan/ru_by_chrom_forward/${tf}_${chr}" or die;
			$i=0;
			while ($line=<G>){
				chomp $line;
				$feature[$i]=$line;
				$i++;
			}
			close G;
			$old_chr=$chr;
			$old_tf=$tf;
			
		}

		@hat=();
		$i=$start-5;
		while ($i<$end){
			push @hat, $feature[$i];
			$i++;
		}
		@hat=sort{$b<=>$a}@hat;
		print NEW "$hat[0]\t$hat[1]\t$hat[2]\n";
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
