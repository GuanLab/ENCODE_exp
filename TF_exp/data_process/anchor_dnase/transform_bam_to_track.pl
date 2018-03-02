@mat=glob "/state1/gyuanfan/DNAse_bam/*"; # input: location of the bam file
system "mkdir /state1/gyuanfan/DNAse_track"; # output: location for the txt file

foreach $file (@mat){
	@t=split '/', $file;
	$name=pop @t;
	system "samtools depth $file > /state1/gyuanfan/DNAse_track/$name";
}

