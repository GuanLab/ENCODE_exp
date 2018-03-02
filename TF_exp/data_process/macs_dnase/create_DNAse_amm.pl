#!/usr/bin/perl

# create amm(avg,max,min) of 200bp interval from fold_coverage_big; no anchor
# non-parallel: perl create_DNAse_amm.pl
# run parallel: perl create_DNAse_amm.pl A549
# @cell_all=("A549","GM12878","H1-hESC","HCT116","HeLa-S3","HepG2","IMR90","induced_pluripotent_stem_cell","K562","liver","MCF-7","Panc1","PC-3");

$cell=$ARGV[0];
@mat=glob "/home/gyuanfan/2017/TF/data/raw/essential_training_data/DNASE/fold_coverage_big/*${cell}*";
system "mkdir /home/hyangl/TF_model/data/DNAse";
system "mkdir /home/hyangl/TF_model/data/DNAse_max_min";
#system "rm -rf /state3/hyangl/TF_model/data/DNAse";
#system "mkdir /state3/hyangl/TF_model/data/DNAse";
$ind="/home/gyuanfan/2017/TF/data/raw/annotations/test_regions.blacklistfiltered.bed";

foreach $file (@mat){
    @tmp=split '\.', $file;
    $cell=$tmp[1];
    open INDEX, "$ind" or die;
    open OUTPUT1, ">/home/hyangl/TF_model/data/DNAse/$cell" or die;
    open OUTPUT2, ">/home/hyangl/TF_model/data/DNAse_max_min/$cell" or die;
    while ($line=<INDEX>){
        chomp $line;
        @tmp=split "\t", $line;
        $chr=$tmp[0];
        $start=$tmp[1];
        $end=$tmp[2];
        if (($cell eq $cell_old) && ($chr eq $chr_old)){}else{
            @feature=(); # use array instead of hash to save memory! (since it is large and continuous)
            print "${cell}-${chr}\n";
            open INPUT, "$file" or die;
            while ($line=<INPUT>){
                chomp $line;
                @tmp=split "\t", $line;
                if ($tmp[0] eq $chr){
                    $i=$tmp[1];
                    while ($i<$tmp[2]){
                        $feature[$i]=$tmp[3];
                        $i++;
                    }
                }
            }
            close INPUT;
            $chr_old=$chr;
            $cell_old=$cell;
            
        }

        $sum=0;
        $max=-100;
        $min=999999999;
        $i=$start;
        while ($i<$end){
            $sum+=$feature[$i]; # avg
            if($feature[$i]>$max){ # max
                $max=$feature[$i];
            }
            if($feature[$i]<$min){ # min
                $min=$feature[$i];
            }
            $i++;
        }
        $avg=$sum/($end-$start);

        $avg=int($avg*10000)/10000;
        $max=int($max*10000)/10000;
        $min=int($min*10000)/10000;
        print OUTPUT1 "$avg\n";
        print OUTPUT2 "$max\t$min\n";

    }
    close INDEX;
    close OUTPUT1;
    close OUTPUT2;
}

    

