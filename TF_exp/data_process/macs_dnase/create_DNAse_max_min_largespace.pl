#!/usr/bin/perl
#
@mat=glob "/home/hyangl/TF_model/data/DNAse_max_min/*";

system "mkdir /state3/hyangl/TF_model/data/DNAse_max_min_largespace";

foreach $file (@mat){
	print "$file\n";
	open OLD, "$file" or die;
	@all1=();
	@all2=();
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		push @all1, $table[0];
		push @all2, $table[1];
	}
	close OLD;
	@t=split '/', $file;
	$name=pop @t;

	open NEW, ">/state3/hyangl/TF_model/data/DNAse_max_min_largespace/$name" or die;
	$i=0;
	foreach $aaa (@all1){
		printf NEW "%.4f", $aaa;
		$j=1;
		while ($j<15){
			if (defined $all1[$i-$j]){
				printf NEW "\t%.4f", $all1[$i-$j];
			}else{
				printf NEW "\t0";
			}

			if (defined $all1[$i+$j]){
				printf NEW "\t%.4f", $all1[$i+$j];
			}else{
				printf NEW "\t0";
			}
			$j++;
			$j++;
		}

		printf NEW "\t%.4f", $all2[$i];
		$j=1;
		while ($j<15){
			if (defined $all2[$i-$j]){
				printf NEW "\t%.4f", $all2[$i-$j];
			}else{
				printf NEW "\t0";
			}

			if (defined $all2[$i+$j]){
				printf NEW "\t%.4f", $all2[$i+$j];
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

		
