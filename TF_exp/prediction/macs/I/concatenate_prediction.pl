#!/usr/bin/perl

## combine 61 separated model into one

$path1="/state2/hyangl/TF_model/prediction/macs/I/separated/"; # PARAMETER
$path2="/state2/hyangl/TF_model/prediction/macs/I/combined/"; # PARAMETER

@mat=glob "${path1}61_*";

foreach $file (@mat){
        @t=split '/', $file;
        $name=pop @t;
        @t=split '61_', $name;
        $new_file=$t[1];

        open NEW, ">${path2}${new_file}" or die;
        $i=1;
        while ($i<62){
                $fff=$file;
                $fff=~s/61/$i/g;
                system "cat $fff >> ${path2}${new_file}";
                $i++;
        }
        close NEW;
}

