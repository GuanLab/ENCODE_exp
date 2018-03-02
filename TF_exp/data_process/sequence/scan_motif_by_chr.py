import numpy as np
import sys
import re

the_chr=sys.argv[1]

tf_matrix_ATF2=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/ATF2",delimiter='\t',dtype='float32')
tf_length_ATF2=tf_matrix_ATF2.shape[0]

tf_matrix_CTCF=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/CTCF",delimiter='\t',dtype='float32')
tf_length_CTCF=tf_matrix_CTCF.shape[0]

tf_matrix_E2F1=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/E2F1",delimiter='\t',dtype='float32')
tf_length_E2F1=tf_matrix_E2F1.shape[0]

tf_matrix_EGR1=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/EGR1",delimiter='\t',dtype='float32')
tf_length_EGR1=tf_matrix_EGR1.shape[0]

tf_matrix_FOXA1=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/FOXA1",delimiter='\t',dtype='float32')
tf_length_FOXA1=tf_matrix_FOXA1.shape[0]

tf_matrix_FOXA2=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/FOXA2",delimiter='\t',dtype='float32')
tf_length_FOXA2=tf_matrix_FOXA2.shape[0]

tf_matrix_GABPA=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/GABPA",delimiter='\t',dtype='float32')
tf_length_GABPA=tf_matrix_GABPA.shape[0]

tf_matrix_HNF4A=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/HNF4A",delimiter='\t',dtype='float32')
tf_length_HNF4A=tf_matrix_HNF4A.shape[0]

tf_matrix_JUND=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/JUND",delimiter='\t',dtype='float32')
tf_length_JUND=tf_matrix_JUND.shape[0]

tf_matrix_MAX=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/MAX",delimiter='\t',dtype='float32')
tf_length_MAX=tf_matrix_MAX.shape[0]

tf_matrix_NANOG=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/NANOG",delimiter='\t',dtype='float32')
tf_length_NANOG=tf_matrix_NANOG.shape[0]

tf_matrix_REST=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/REST",delimiter='\t',dtype='float32')
tf_length_REST=tf_matrix_REST.shape[0]

tf_matrix_TAF1=np.loadtxt("/home/gyuanfan/2016/TF/data/baseline/ru_model/TAF1",delimiter='\t',dtype='float32')
tf_length_TAF1=tf_matrix_TAF1.shape[0]

## read in one chromosome and scan;
FILE_name='/home/gyuanfan/2016/TF/data/raw/ChIPseq/hg_genome/'+the_chr
FILE=open(FILE_name,'r');
line = FILE.readline()
line=line.rstrip()
line=line.replace("a","A")
line=line.replace("c","C")
line=line.replace("g","G")
line=line.replace("t","T")
line=line.replace("N","A")
line=line.replace("n","A")
#print(line)

aline=line
aline=aline.replace("A", "1")
aline=aline.replace("C", "0")
aline=aline.replace("G", "0")
aline=aline.replace("T", "0")
aline=np.asarray(list(aline),dtype='float32')


cline=line
cline=cline.replace("A", "0")
cline=cline.replace("C", "1")
cline=cline.replace("G", "0")
cline=cline.replace("T", "0")
cline=np.asarray(list(cline),dtype='float32')

gline=line
gline=gline.replace("A", "0")
gline=gline.replace("C", "0")
gline=gline.replace("G", "1")
gline=gline.replace("T", "0")
gline=np.asarray(list(gline),dtype='float32')

tline=line
tline=tline.replace("A", "0")
tline=tline.replace("C", "0")
tline=tline.replace("G", "0")
tline=tline.replace("T", "1")
tline=np.asarray(list(tline),dtype='float32')

chrom_matrix=np.vstack((aline, cline, gline, tline))
print(chrom_matrix.shape)

length=chrom_matrix.shape[1]
i=0;
max_length=length-20


#ATF2  CTCF  E2F1  EGR1  FOXA1  FOXA2  GABPA  HNF4A  JUND  MAX  NANOG  REST  TAF1
ATF2_file='ru_by_chrom/AFT2_'+the_chr
ATF2=open(ATF2_file,'w');
CTCF_file='ru_by_chrom/CTCF_'+the_chr
CTCF=open(CTCF_file,'w');
E2F1_file='ru_by_chrom/E2F1_'+the_chr
E2F1=open(E2F1_file,'w');
EGR1_file='ru_by_chrom/EGR1_'+the_chr
EGR1=open(EGR1_file,'w');
FOXA1_file='ru_by_chrom/FOXA1_'+the_chr
FOXA1=open(FOXA1_file,'w');

FOXA2_file='ru_by_chrom/FOXA2_'+the_chr
FOXA2=open(FOXA2_file,'w');

GABPA_file='ru_by_chrom/GABPA_'+the_chr
GABPA=open(GABPA_file,'w');


HNF4A_file='ru_by_chrom/HNF4A_'+the_chr
HNF4A=open(HNF4A_file,'w');

JUND_file='ru_by_chrom/JUND_'+the_chr
JUND=open(JUND_file,'w'); 

MAX_file='ru_by_chrom/MAX_'+the_chr
MAX=open(MAX_file,'w'); 

NANOG_file='ru_by_chrom/NANOG_'+the_chr
NANOG=open(NANOG_file,'w'); 

REST_file='ru_by_chrom/REST_'+the_chr
REST=open(REST_file,'w'); 

TAF1_file='ru_by_chrom/TAF1_'+the_chr
TAF1=open(TAF1_file,'w'); 

while (i<max_length):
	sub=chrom_matrix[:,i:(i+tf_length_ATF2)]
	val=np.trace(np.dot(tf_matrix_ATF2,sub))
	ATF2.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_CTCF)]
	val=np.trace(np.dot(tf_matrix_CTCF,sub))
	CTCF.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_E2F1)]
	val=np.trace(np.dot(tf_matrix_E2F1,sub))
	E2F1.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_EGR1)]
	val=np.trace(np.dot(tf_matrix_EGR1,sub))
	EGR1.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_FOXA1)]
	val=np.trace(np.dot(tf_matrix_FOXA1,sub))
	FOXA1.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_FOXA2)]
	val=np.trace(np.dot(tf_matrix_FOXA2,sub))
	FOXA2.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_GABPA)]
	val=np.trace(np.dot(tf_matrix_GABPA,sub))
	GABPA.write('%.5f\n' % val)
	###HNF4A  JUND  MAX  NANOG  REST  TAF1

	sub=chrom_matrix[:,i:(i+tf_length_HNF4A)]
	val=np.trace(np.dot(tf_matrix_HNF4A,sub))
	HNF4A.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_JUND)]
	val=np.trace(np.dot(tf_matrix_JUND,sub))
	JUND.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_MAX)]
	val=np.trace(np.dot(tf_matrix_MAX,sub))
	MAX.write('%.5f\n' % val)


	sub=chrom_matrix[:,i:(i+tf_length_NANOG)]
	val=np.trace(np.dot(tf_matrix_NANOG,sub))
	NANOG.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_REST)]
	val=np.trace(np.dot(tf_matrix_REST,sub))
	REST.write('%.5f\n' % val)

	sub=chrom_matrix[:,i:(i+tf_length_TAF1)]
	val=np.trace(np.dot(tf_matrix_TAF1,sub))
	TAF1.write('%.5f\n' % val)

	i=i+1

#ATF2  CTCF  E2F1  EGR1  FOXA1  FOXA2  GABPA  HNF4A  JUND  MAX  NANOG  REST  TAF1
ATF2.close()
CTCF.close()
EGR1.close()
FOXA1.close()
FOXA2.close()
GABPA.close()
HNF4A.close()
JUND.close()
MAX.close()
NANOG.close()
REST.close()
TAF1.close()
	


