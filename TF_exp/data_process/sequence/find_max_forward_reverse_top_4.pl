#!/usr/bin/perl
#
@mat=glob "/state4/gyuanfan/TF_model/data/tf_reverse_ru_top3/*";

system "mkdir /state4/gyuanfan/TF_model/data/tf_ru_max_top4/";

foreach $file1 (@mat){
	$file2=$file1;
	$file2=~s/reverse/forward/g;
	$new=$file1;
	$new=~s/tf_reverse_ru_top3/tf_ru_max_top4/g;
	open OLD1, "$file1" or die;
	open OLD2, "$file2" or die;
	open NEW, ">$new" or die;

	while ($line1=<OLD1>){
		chomp $line1;
		@table1=split "\t", $line1;
		$line2=<OLD2>;
		chomp $line2;
		@table2=split "\t", $line2;
		push @table1, @table2;
	
		@all=sort{$b<=>$a}@table1;
		print NEW "$all[0]\t$all[1]\t$all[2]\t$all[3]\n";

	
	}
	close OLD1;
	close OLD2;
	close NEW;
}

		
