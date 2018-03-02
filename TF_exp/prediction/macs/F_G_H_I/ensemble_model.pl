#!/usr/bin/perl

# ensemble/average F, G, H and I models

$path="/state3/hyangl/TF_model/prediction/anchor/F_G_H_I/ensemble/";
system "mkdir $path";

@list=("/state3/hyangl/TF_model/prediction/anchor/F/combined/",
    "/state3/hyangl/TF_model/prediction/anchor/G/combined/",
    "/state3/hyangl/TF_model/prediction/anchor/H/combined/",
    "/state3/hyangl/TF_model/prediction/anchor/I/combined/");

$first=shift @list;

@mat=glob "$first/*";

foreach $file (@mat){
    @t=split '/', $file;
    $name=pop @t;

    open OLD, "$file" or die;
    $i=0;
    foreach $dir (@list){
        $handle='handle'.$i;
        open $handle, "$dir/$name" ;
        $i++;
    }

    $imax=$i;
    open NEW, ">${path}${name}" or die;
    while ($old=<OLD>){
        chomp $old;
        $i=0;
        while ($i<$imax){
            $handle='handle'.$i;
            $line=<$handle>;
            chomp $line;
            $old=$line+$old;
            $i++;
        }
        $val=$old/($imax+1);
        print NEW "$val\n";
    }
    close NEW;
    close FILE1;
    close FILE2;
}

#[guanlab11]/state4/hongyang/TF/code_combine_final/F_G_H_I/
