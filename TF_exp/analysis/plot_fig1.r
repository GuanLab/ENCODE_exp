## name: plot_flowchart.r
## date: 06/19/2017

# generating sample data for flowchart
#x=as.matrix(read.delim("/state3/hyangl/TF_model/analysis/flowchart/ATF3.HepG2.set2",sep=" ",header=F))
#mat_sample=x[,c(1,22,144)]
#mat_sample[,2]=gsub("21:","",mat_sample[,2])
#mat_sample[,3]=gsub("143:","",mat_sample[,3])
#mat_sample=matrix(as.numeric(mat_sample),ncol=3)
#save(mat_sample,file="flowchart/flowchart_sample.RData")

# plot flowchart
library(ggplot2)
library(grid)

source("/home/hyangl/function/multiplot.R")
load("/state3/hyangl/TF_model/analysis/flowchart/flowchart_sample.RData")

cols = c("1"="#01579B","2"="#FF3030","3"="#00C853","4"="#FFD600","5"="#AA00FF") # blue, red, green, yellow, purple

## 1. DNase-seq 
d1=data.frame(DNase_seq=rep(0,5000),y=mat_sample[1:5000,2],chromosome_position=rep(1:1000,5),type=rep(1:5,each=1000),
    name=rep(c("Cell1","Cell2","Cell3","Cell4","Cell5"),each=1000))
p1 = ggplot() +
    geom_segment(data=d1,aes(x=chromosome_position,xend=chromosome_position,y=DNase_seq,yend=y,colour=factor(type))) +
    facet_grid(name ~ ., switch="y") +
    scale_colour_manual(values=cols) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(strip.background=element_rect(fill="gray90")) +
    theme(legend.position="none")
p1 

## 2. DNA sequence
d2=data.frame(DNA_sequence=rep(0,5000),y=(mat_sample[3001:8000,3])^10,chromosome_position=rep(1:1000,5),type=rep(1:5,each=1000),
    name=rep(c("TF1","TF2","TF3","TF4","TF5"),each=1000))
p2 = ggplot() +
    geom_segment(data=d2,aes(x=chromosome_position,xend=chromosome_position,y=DNA_sequence,yend=y,colour=factor(type))) +
    facet_grid(name ~ ., switch="y") +
    scale_colour_manual(values=cols) +
    ylim(0,2) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(strip.background=element_rect(fill="gray90")) +
    theme(legend.position="none")
p2    

## 3. GENCODE
cols2 = c("1"="green","2"="red","3"="orange","4"="blue","5"="purple","6"="brown","7"="green4","8"="red")
set.seed(449)
dna_seq=sample(4,1000,replace=TRUE)
d3=data.frame(GENCODE=rep(0,1000),y=rep(1,1000),chromosome_position=rep(1:1000,1),type=rep(dna_seq,1),
    name=rep("GENCODE",each=1000))
d_gene=data.frame(x0=c(100,450,700,750),x1=c(400,650,750,900),y0=c(5,10,15,5),y1=c(10,15,20,10),
    type=c(5,6,7,8))
p3 = ggplot() +
    geom_segment(data=d3,aes(x=chromosome_position,xend=chromosome_position,y=GENCODE,yend=y,colour=factor(type))) +
    geom_rect(data=d_gene,aes(xmin=x0,xmax=x1,ymin=y0,ymax=y1,fill=factor(type))) +    
    facet_grid(name ~ ., switch="y") +
    scale_colour_manual(values=cols2) +
    scale_fill_manual(values=cols2) +
    ylim(0,30) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(strip.background=element_rect(fill="gray90")) +
    theme(legend.position="none")
p3

## 4. ChIP-seq
d4=data.frame(ChIP_seq=rep(0,5000),y=mat_sample[1:5000,1],chromosome_position=rep(1:1000,5),type=rep(1:5,each=1000),
    name=rep(c("TF1-CellX","TF2-CellX","TF3-CellY","TF4-CellY","TF5-CellZ"),each=1000))
p4 = ggplot() +
    geom_segment(data=d4,aes(x=chromosome_position,xend=chromosome_position,y=ChIP_seq,yend=y,colour=factor(type))) +
    facet_grid(name ~ ., switch="y") +
    scale_colour_manual(values=cols) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(legend.position="none")
p4    

## 5. prediction
pred = scan("/state3/hyangl/TF_model/analysis/flowchart/output.dat",nlines=5000)
pred = pred-min(pred)
d5=data.frame(ChIP_seq=rep(0,5000),y=pred,chromosome_position=rep(1:1000,5),type=rep(1:5,each=1000),
    name=rep(c("TF1-CellX","TF2-CellX","TF3-CellY","TF4-CellY","TF5-CellZ"),each=1000))
p5 = ggplot() +
    geom_segment(data=d5,aes(x=chromosome_position,xend=chromosome_position,y=ChIP_seq,yend=y,colour=factor(type))) +
    facet_grid(name ~ ., switch="y") +
    scale_colour_manual(values=cols) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(legend.position="none")
p5   

## 6. xgboost (clockwise panties)
d6 = data.frame(count=rep(1,5), ymin=seq(0,0.9,0.2), ymax=seq(0.07,1,0.2))
x1=rep(seq(12.5,18.5,2),10) # line
x2=rep(seq(13.5,19.5,2),10)
xend1=rep(12.5,40)
xend2=rep(19.5,40)
y=c(rep(1,4),rep(sort(c(seq(0.2,0.9,0.2),seq(0.07,1,0.2))),each=4))
yend=rep(c(0.97,0.1,0.17,0.3,0.37,0.5,0.57,0.7,0.77,0.9),each=4)
x_arrow=c(rep(12.5,5),rep(19.5,5)) # arrow
xend_arrow=c(rep(19.5,5),rep(12.5,5))
y_arrow=c(seq(0.115,0.915,0.2),seq(0.11,0.91,0.2))
yend_arrow=c(seq(0.16,0.96,0.2),seq(0.155,0.955,0.2))
xset=rep(c(12,20),10) # chromosome set
yset=c(rep(seq(0.105,0.905,0.2),each=2),rep(seq(0.165,0.965,0.2),each=2))
p6 = ggplot() +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=20, xmin=19),fill=cols[1]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=19, xmin=18),fill=cols[2]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=18, xmin=17),fill=cols[1]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=17, xmin=16),fill=cols[2]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=16, xmin=15),fill=cols[1]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=15, xmin=14),fill=cols[2]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=14, xmin=13),fill=cols[1]) +
    geom_rect(data=d6,aes(ymax=ymax, ymin=ymin, xmax=13, xmin=12),fill=cols[2]) +
    geom_segment(aes(x=x1,y=y,xend=xend1,yend=yend),color=rep(cols[2],40),size=0.3) +
    geom_segment(aes(x=x2,y=y,xend=xend2,yend=yend),color=rep(cols[1],40),size=0.3) +
    scale_shape_identity() +
    geom_point(aes(x=xset,y=yset,shape=c(rep(15,10),rep(16,10))),color=rep(cols[c(2,1)],10),size=rep(4,20)) +
    geom_segment(aes(x=x_arrow,y=y_arrow,xend=xend_arrow,yend=yend_arrow),color=rep(cols[3],10),
        arrow=arrow(length=unit(0.2,"cm"),type="closed",angle=20)) +
    geom_segment(aes(x=5,y=0,xend=5,yend=0.95),arrow=arrow(length=unit(0.5,"cm"),type="closed",angle=20),color=cols[3]) +
    coord_polar(theta="y") +
    xlim(c(0, 20)) +
    ylim(c(0, 1)) +
    annotate("text", x = rep(10,5), y = seq(0.04,0.84,0.2), label = paste0("Cell ",1:5)) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(legend.position="none")
p6

## multiplot
list_p=list()
list_p[[1]]=p1
list_p[[2]]=p2
list_p[[3]]=p3
list_p[[4]]=p4
list_p[[5]]=p5
list_p[[6]]=p6
mat_layout=matrix(c(rep(c(1,1,1,2,2,2,3),3),rep(c(6,6,6,6,0,0,0),4),rep(c(0,4,4,4,5,5,5),3),rep(rep(0,7),3)), nrow=7)
pdf(file="figure/flowchart/flowchart.pdf",width=13,height=7)
multiplot(plotlist=list_p,layout = mat_layout)
dev.off()

save(mat_sample,p1,p2,p3,p4,p5,p6,
    file="plot_flowchart.RData")


## plot example tf logo
library(seqLogo)
proportion <- function(x){
   rs <- sum(x);
   return(x / rs);
}

pdf(file="figure/tf_logo1.pdf",width=9,height=3)
tf=read.delim("/state3/hyangl/TF_model/analysis/flowchart/ru_pcm/ATF2",header=F)
pwm <- makePWM(apply(tf, 1, proportion))
seqLogo(pwm)
dev.off()

pdf(file="figure/tf_logo2.pdf",width=20,height=3)
tf=read.delim("/state3/hyangl/TF_model/analysis/flowchart/ru_pcm/CTCF",header=F)
pwm <- makePWM(apply(tf, 1, proportion))
seqLogo(pwm)
dev.off()

pdf(file="figure/tf_logo3.pdf",width=18,height=3)
tf=read.delim("/state3/hyangl/TF_model/analysis/flowchart/ru_pcm/EGR1",header=F)
pwm <- makePWM(apply(tf, 1, proportion))
seqLogo(pwm)
dev.off()

pdf(file="figure/tf_logo4.pdf",width=11,height=3)
tf=read.delim("/state3/hyangl/TF_model/analysis/flowchart/ru_pcm/JUND",header=F)
pwm <- makePWM(apply(tf, 1, proportion))
seqLogo(pwm)
dev.off()

pdf(file="figure/tf_logo5.pdf",width=11,height=3)
tf=read.delim("/state3/hyangl/TF_model/analysis/flowchart/ru_pcm/MAX",header=F)
pwm <- makePWM(apply(tf, 1, proportion))
seqLogo(pwm)
dev.off()
