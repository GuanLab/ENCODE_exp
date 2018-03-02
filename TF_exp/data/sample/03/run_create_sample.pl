@tf_all=("ATF3","CTCF","E2F1","EGR1","FOXA1","FOXA2","GABPA","HNF4A","JUND","MAX","NANOG","REST","TAF1");
foreach $tf (@tf_all){
	print "$tf\n";
	system "perl create_sample.pl $tf";
}

