## name: plot_fi.r
## date: 01/22/2018

library(ggplot2)
library(reshape2)
library(plyr)
library(scales)

load("../feature_importance/anchor_I_fi.RData")
source("my_palette.r")
source("multiplot.R")

base_size = 9

## p1 max
ind=grep("^max",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p1=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["red"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())

## p2 mean
ind=grep("^mean",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p2=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["cyan"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())

## p3 min
ind=grep("^min",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p3=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["blue"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())

## p4 delta_max
ind=grep("^delta_max",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p4=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["orange"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())

## p5 delta_mean
ind=grep("^delta_mean",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p5=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["teal"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())


## p6 delta_min
ind=grep("^delta_min",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p6=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["purple"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())



## hp1 max
ind=grep("^max",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp1=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["red"]) +
    scale_x_discrete() +
    labs(title="Max", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())

## hp2 mean
ind=grep("^mean",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp2=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["cyan"]) +
    scale_x_discrete() +
    labs(title="Mean", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())

## hp3 min
ind=grep("^min",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp3=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["blue"]) +
    scale_x_discrete() +
    labs(title="Min", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())


## hp4 delta_max
ind=grep("^delta_max",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp4=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["orange"]) +
    scale_x_discrete() +
    labs(title="Delta Max", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())

## hp5 delta_mean
ind=grep("^delta_mean",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp5=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["teal"]) +
    scale_x_discrete() +
    labs(title="Delta Mean", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())

## hp6 delta_min
ind=grep("^delta_min",rownames(mat_fi))[c(seq(14,2,-2), seq(1,15,2))]
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp6=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["purple"]) +
    scale_x_discrete() +
    labs(title="Delta Min", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())



m1=apply(mat_fi[grep("^max",rownames(mat_fi)),],2,sum)
m2=apply(mat_fi[grep("^mean",rownames(mat_fi)),],2,sum)
m3=apply(mat_fi[grep("^min",rownames(mat_fi)),],2,sum)
dm1=apply(mat_fi[grep("^delta_max",rownames(mat_fi)),],2,sum)
dm2=apply(mat_fi[grep("^delta_mean",rownames(mat_fi)),],2,sum)
dm3=apply(mat_fi[grep("^delta_min",rownames(mat_fi)),],2,sum)

t1=apply(mat_fi[grep("top1",rownames(mat_fi)),],2,sum)
t2=apply(mat_fi[grep("top2",rownames(mat_fi)),],2,sum)
t3=apply(mat_fi[grep("top3",rownames(mat_fi)),],2,sum)
t4=apply(mat_fi[grep("top4",rownames(mat_fi)),],2,sum)


## p7 tf largespace
ind=grep("top1",rownames(mat_fi))
tmp=data.frame(apply(array(data=t(mat_fi[ind,]),dim=c(13,8,13)),c(1:2),sum))
tmp[,1]=tmp[,1]*2; tmp=cbind(tmp[,8:2],tmp)
rownames(tmp)=colnames(mat_fi)
tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p7=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["brown"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "chromosome position (bp)", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())


## hp7 tf_largespace
ind=grep("top1",rownames(mat_fi))
tmp=data.frame(apply(array(data=t(mat_fi[ind,]),dim=c(13,8,13)),c(1:2),sum))
tmp[,1]=tmp[,1]*2; tmp=cbind(tmp[,8:2],tmp)
rownames(tmp)=colnames(mat_fi)
tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=c(seq(-650,0,100),0,seq(50,650,100))
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:15)
hp7=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["brown"]) +
    scale_x_discrete() +
    labs(title="TF motif", x = "chromosome position (bp)", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())



## p8 tf tf
ind=grep("top",rownames(mat_fi))
tmp=data.frame(apply(array(data=t(mat_fi[ind,]),dim=c(13,8*4,13)),c(1,3),sum))
colnames(tmp)=rownames(tmp)=colnames(mat_fi)
tmp=cbind(Name=rownames(tmp),tmp)
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p8=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["pink"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "TF", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank()) 


## hp8 tf tf
ind=grep("top",rownames(mat_fi))
tmp=data.frame(apply(array(data=t(mat_fi[ind,]),dim=c(13,8*4,13)),c(1,3),sum))
colnames(tmp)=rownames(tmp)=colnames(mat_fi)
tmp=cbind(Name=rownames(tmp),tmp)
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
#tmp.m[,"Name"]=rep(c(seq(-650,0,100),0,seq(50,650,100)),13)
tmp.m=ddply(tmp.m,.(variable),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, tf=colnames(mat_fi))
hp8=ggplot(tmp.m) +
    geom_bar(aes(x=tf,y=importance),stat="identity",fill=my_palette["pink"]) +
    scale_x_discrete() +
    labs(title="TF motif", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())




## p9 nearest genes
ind=grep("^rna",rownames(mat_fi))
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=1:20
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))

p9=ggplot(tmp.m, aes(variable, Name)) + 
    geom_tile(aes(fill = rescale), colour = "white") + # colour: color of the grid
    scale_fill_gradient(low = "white", high = my_palette["purple"],name = "importance") + # name: legend title
    theme_grey(base_size = base_size) +
    labs(x = "top 20 nearest genes", y = "TF") + 
    theme(legend.position="right", axis.ticks=element_blank())

## hp9 nearest genes
ind=grep("^rna",rownames(mat_fi))
tmp=data.frame(t(mat_fi[ind,]),check.names=F);tmp=cbind(Name=rownames(tmp),tmp)
colnames(tmp)[-1]=1:20
tmp.m=melt(tmp)
tmp.m <- ddply(tmp.m, .(Name), transform, rescale = rescale(value))
tmp.m[,"Name"]=rep(1:20,13)
tmp.m=ddply(tmp.m,.(Name),summarize,importance=sum(rescale))
tmp.m=cbind(tmp.m, chromosome_position=1:20)
hp9=ggplot(tmp.m) +
    geom_bar(aes(x=chromosome_position,y=importance),stat="identity",fill=my_palette["purple"]) +
    scale_x_discrete() +
    labs(title="Distance to genes", x = "top 20 nearest genes", y = "accumulated importance") +
    theme(plot.title = element_text(hjust = 0.5),axis.title.x=element_blank())




list_p=list()
list_p[[1]]=p1
list_p[[2]]=p2
list_p[[3]]=p3
list_p[[4]]=p7
list_p[[5]]=p8
list_p[[6]]=p9

mat_layout=matrix(1:6,nrow=2,byrow=T)
pdf(file="figure/fig5_heatmap.pdf",width=15,height=10)
multiplot(plotlist=list_p,layout = mat_layout)
dev.off()


list_p=list()
list_p[[1]]=hp1
list_p[[2]]=hp2
list_p[[3]]=hp3
list_p[[4]]=hp7
list_p[[5]]=hp8
list_p[[6]]=hp9

mat_layout=matrix(1:6,nrow=2,byrow=T)
pdf(file="figure/fig5_heatmap_hist.pdf",width=10,height=2)
multiplot(plotlist=list_p,layout = mat_layout)
dev.off()


