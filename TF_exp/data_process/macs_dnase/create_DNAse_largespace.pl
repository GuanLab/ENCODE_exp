#!/usr/bin/perl
#
@mat=glob "/home/hyangl/TF_model/data/DNAse/*";

system "mkdir /home/hyangl/TF_model/data/DNAse_largespace";

foreach $file (@mat){
	print "$file\n";
	open OLD, "$file" or die;
	@all=();
	while ($line=<OLD>){
		chomp $line;
		push @all, $line;
	}
	close OLD;
	@t=split '/', $file;
	$name=pop @t;

	open NEW, ">/home/hyangl/TF_model/data/DNAse_largespace/$name" or die;
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

		
