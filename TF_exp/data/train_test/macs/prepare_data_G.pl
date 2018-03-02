#!/usr/bin/perl

## prepare training & test data

$path1="/state3/hyangl/TF_model/data/train_test/macs/G/"; # PARAMETER: change the directory names F,G,H,I
$path2="/state3/hyangl/TF_model/data/sample/02/"; # PARAMETER: F-01,G-02,H-03,I-04

$tf_list="/state3/hyangl/TF_model/data/index/tf_list.txt"; # PARAMETER

@cell_feature=("/state3/hyangl/TF_model/data/feature/DNAse_largespace/", # PARAMETER
        "/state3/hyangl/TF_model/data/feature/DNAse_diff_largespace/",
        "/state3/hyangl/TF_model/data/feature/DNAse_max_min_largespace/",
        "/state3/hyangl/TF_model/data/feature/DNAse_max_min_diff_largespace/",
        "/state3/hyangl/TF_model/data/feature/orange_rank_largespace/",
        "/state3/hyangl/TF_model/data/feature/orange_rank_diff_largespace/");

@tf_feature=glob ("/state3/hyangl/TF_model/data/feature/tf_ru_max_top4_rank_largespace/"); # PARAMETER: FG "xxx/" HI "xxx/*"

$rna_feature='/state3/hyangl/TF_model/data/feature/top_20'; # 60519747 lines, including index

%chr_set1=(); # index for set1 and set2 chr
open INDEX_SET1, "/state3/hyangl/TF_model/data/index/ind_chr_set1.txt" or die;
while($line=<INDEX_SET1>){
    chomp $line;
    $chr_set1{$line}=0;
}
close INDEX_SET1;

open FILE, "$tf_list" or die;
while ($tf=<FILE>){
    chomp $tf;
    system "mkdir ${path1}";
    system "mkdir ${path1}${tf}";
    @tmp=glob "/home/gyuanfan/2017/TF/data/raw/ChIPseq/labels/${tf}*"; # collect names of all cell types for target tf
    open TMP, "$tmp[0]" or die;
    $line=<TMP>;
    chomp $line;
    @list= split "\t", $line;
    shift @list;
    shift @list;
    shift @list;
    close TMP;

    foreach $cell (@list){
        open SAMPLE, "${path2}${tf}/F.${tf}.${cell}.tab" or die; # a subset of all data; chr and start are the coordinates
        %target=(); # if exists/defined target{$chr}{$start}
        while($line=<SAMPLE>){
            chomp $line;
            @tmp=split "\t", $line;
            $chr=shift @tmp;
            $start=shift @tmp;
            shift @tmp;
            $y=shift @tmp;
            $target{$chr}{$start}=$y;
        }
        close SAMPLE;

        open INDEX, "$rna_feature" or die;
        $num=0; # index for all feature files
        foreach $file (@cell_feature){
            $name="INPUT".$num;
            open $name, "${file}${cell}" or die;
            $num++;
        }
        foreach $file (@tf_feature){
            $name="INPUT".$num;
            open $name, "${file}${tf}" or die; # PARAMETER: FG ${file}${tf} HI ${file}
            $num++;
        }

        open OUTPUT1, ">${path1}${tf}/${tf}.${cell}.set1" or die;
        open OUTPUT2, ">${path1}${tf}/${tf}.${cell}.set2" or die;
        while($line=<INDEX>){
            chomp $line;
            @rna=split "\t", $line;
            $chr=shift @rna;
            $start=shift @rna;
            shift @rna;
            if(defined $target{$chr}{$start}){ # if this line is target
                if(exists $chr_set1{$chr}){ # save data as set 1 or set 2
                    $file="OUTPUT1";
                }else{
                    $file="OUTPUT2"
                }
                print $file "$target{$chr}{$start}"; # print y in the 1st column
                $j=1;
                foreach $x (@rna){ # print rna feature
                    print $file " $j:$x";
                    $j++;
                }
                $i=0;
                while($i<$num){ # print all other features
                    $name="INPUT".$i;
                    $line=<$name>;
                    chomp $line;
                    @tmp=split "\t",$line;
                    foreach $x (@tmp){
                        print $file " $j:$x";
                        $j++;
                    }
                    $i++;
                }
                print $file "\n";
            }else{ # if this line is not target, skip it
                $i=0;
                while($i<$num){
                    $name="INPUT".$i;
                    <$name>;
                    $i++;
                }
            }
        }
        close OUTPUT1;
        close OUTPUT2;
        close INDEX;
        $i=0;
        while($i<$num){
            $name="INPUT".$i;
            close $name;
            $i++;
        }
    }
}


