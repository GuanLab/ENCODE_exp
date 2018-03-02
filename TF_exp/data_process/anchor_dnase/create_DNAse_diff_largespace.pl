#!/usr/bin/perl
#
@mat=glob "/state4/gyuanfan/TF_model/data/anchor_bam_DNAse_diff/*";

system "mkdir /state4/gyuanfan/TF_model/data/anchor_bam_DNAse_diff_largespace";

foreach $file (@mat){
	open OLD, "$file" or die;
	@all=();
	while ($line=<OLD>){
		chomp $line;
		push @all, $line;
	}
	close OLD;
	@t=split '/', $file;
	$name=pop @t;

	open NEW, ">/state4/gyuanfan/TF_model/data/anchor_bam_DNAse_diff_largespace/$name" or die;
	$i=0;
	foreach $aaa (@all){
		printf NEW "%.4f", $aaa;
		$j=1;
		while ($j<15){
			if (defined $all[$i-$j]){
				printf NEW "\t%.4f", $all[$i-$j];
			}else{
				printf NEW "\t0";
			}

			if (defined $all[$i+$j]){
				printf NEW "\t%.4f", $all[$i+$j];
			}else{
				printf NEW "\t0";
			}
			$j++;
			$j++;
		}
		print NEW "\n";
		$i++;
	}
	close NEW;
		
}

		
