#!/usr/bin/perl

@mat=glob "/home/hyangl/TF_model/data/DNAse_max_min/*"; # max & min
system "mkdir /home/hyangl/TF_model/data/DNAse_max_min_diff";

@count=0;
@ref_0=();
@ref_1=();
foreach $file (@mat){
	print "$file\n"; 
	$i=0;
        open OLD, "$file" or die;
        while ($line=<OLD>){
                chomp $line;
                @table=split "\t", $line;
                $ref_0[$i]+=$table[0];
                $ref_1[$i]+=$table[1];
                $i++;
        }
        close OLD;
        $count++;
}
foreach $file (@mat){
	print "$file\n";
        @t=split '/', $file;
        $name=pop @t;
        $i=0;
        open OLD, "$file" or die;
        open NEW, ">/home/hyangl/TF_model/data/DNAse_max_min_diff/$name" or die;
        while ($line=<OLD>){
                chomp $line;
                @table=split "\t", $line;
                $avg=$ref_0[$i]/$count;
                $val=$table[0]-$avg;
                print NEW "$val";
                $avg=$ref_1[$i]/$count;
                $val=$table[1]-$avg;
                print NEW "\t$val\n";
                $i++;
        }
        close OLD;
        close NEW;
}

