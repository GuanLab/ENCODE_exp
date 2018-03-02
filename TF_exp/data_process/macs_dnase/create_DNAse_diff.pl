#!/usr/bin/perl

# subtract the average average of all cell types

@mat=glob "/home/hyangl/TF_model/data/DNAse/*"; # avg
system "mkdir /home/hyangl/TF_model/data/DNAse_diff";

$count=0;
@ref=();
foreach $file (@mat){ # collecting values from all cells
	print "$file\n";
        $i=0;
        open OLD, "$file" or die;
        while ($line=<OLD>){
                chomp $line;
                $ref[$i]+=$line;
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
        open NEW, ">/home/hyangl/TF_model/data/DNAse_diff/$name" or die;
        while ($line=<OLD>){
                chomp $line;
                $avg=$ref[$i]/$count; # subtract the average value
                $val=$line-$avg;
                print NEW "$val\n";
                $i++;
        }
        close OLD;
        close NEW;
}

