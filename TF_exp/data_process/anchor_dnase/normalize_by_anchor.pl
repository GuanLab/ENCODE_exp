#!/usr/bin/perl
#
@mat=glob "/state1/gyuanfan/DNAse_track_avg/*";


system "rm -rf /state1/gyuanfan/DNAse_track_avg_anchor";
system "mkdir /state1/gyuanfan/DNAse_track_avg_anchor";
foreach $file (@mat){
	@t=split '/', $file;
	$name=pop @t;
	@t=split '_chr', $name;
	$cell=shift @t;

	open REF, "${cell}.txt" or die;
	open LIVER, "liver.txt" or die;
	%map=();
	%count=();
	@liver_all=();
	while ($ref=<REF>){
		chomp $ref;
		$liver=<LIVER>;
		chomp $liver;
		$map{$ref}+=$liver;
		$count{$ref}++;
		push @liver_all, $liver;
	}
	
	@all=keys %map;
	foreach $aaa (@all){
		$map{$aaa}=$map{$aaa}/$count{$aaa};
	}
	@all=sort{$b<=>$a}@all;

	@liver_all=sort{$a<=>$b}@liver_all;
	$norm=$liver_all[int(scalar(@liver_all)*0.9)];
		
	open OLD, "$file" or die;
	open NEW, ">/state1/gyuanfan/DNAse_track_avg_anchor/$name" or die;
	while ($line=<OLD>){
		chomp $line;
		@table=split "\t", $line;
		if (exists $map{$table[1]}){
			$new_table=$map{$table[1]};
		}else{
			$last=$all[0];
			$first=$all[1];
			if ($table[1]>$last){

				$u=($table[1]-$last)*($map{$last}-$map{$first});
                                $d=($last-$first);
                                $new_table=$map{$last}+$u/$d;	
			}else{
				foreach $aaa (@all){
					if ($table[1]>$aaa){
						$first=$aaa;
						goto AAA;
					}else{
						$last=$aaa;
					}
				}
				AAA:$u=($table[1]-$first)*($map{$last}-$map{$first});
				$d=($last-$first);
				$new_table=$map{$first}+$u/$d;
				
				
			}
		}
						
				
		$val=log(1+$new_table/$norm);
		$val= sprintf "%.4f", $val;
		print NEW "$table[0]\t$val\n";				
	}
	close OLD;
	close REF;
	close NEW;
}

		
	

	
	
