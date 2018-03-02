#!/usr/bin/perl
#

system "rm -rf /state4/gyuanfan/TF_model/data/orange_rank";
system "mkdir /state4/gyuanfan/TF_model/data/orange_rank";

@mat=glob "/state4/gyuanfan/TF_model/data/orange/*";


foreach $file (@mat){
	%count_val=0;
	$total=0;
	open OLD, "$file" or die;
	while ($line=<OLD>){
		chomp $line;
		$count_val{$line}++;
		$total++;
	}
	close OLD;
	
	@all_vals=keys %count_val;
	@all_vals=sort{$a<=>$b}@all_vals;
	$ref_num=0;

	%map=();
	$old=0;
	foreach $vvv (@all_vals){
		
		$ref_num+=$old;
		$ref_num+=($count_val{$vvv}/2);
		$old=($count_val{$vvv}/2);
		$map{$vvv}=$ref_num/$total;
	}
	open OLD, "$file" or die;
	$new=$file;
	@t=split '/', $file;
	$name=pop @t;
	open NEW, ">/state4/gyuanfan/TF_model/data/orange_rank/$name";
	while ($line=<OLD>){
		chomp $line;
		print NEW "$map{$line}\n";
	}
	close OLD;
	close NEW;
}

	
	
		
	

