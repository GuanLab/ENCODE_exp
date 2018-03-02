## name: plot_fig2.r
## date: 02/07/2018

library(PRROC)

source("my_palette.r")
source("multiplot.R")
load("auc_auprc.RData")

# auc train - test
train_auc=round(apply(array_auc_cv,2:3,mean),4)
train_auprc=round(apply(array_auprc_cv,2:3,mean),4)
test_auc=round(apply(array_auc_final,2:3,mean),4)
test_auprc=round(apply(array_auprc_final,2:3,mean),4)

tf_all=c("ATF3",unique(sub("_.*","",tf_cell_final)))
tmp_tf_cell=tf_cell_cv
x1=rep(NA,length(tmp_tf_cell))
for (i in 1:length(tf_all)){
    x1[grep(tf_all[i],tmp_tf_cell)]=i
}
x2=rep(NA,length(tf_cell_final))
for (i in 1:length(tf_all)){
    x2[grep(tf_all[i],tf_cell_final)]=i
}

pdf("figure/fig2_train_test.pdf",width=12,height=6.2)
layout(matrix(c(rep(rep(1:4,each=3),3),rep(rep(5:6,each=6),3)),nrow=6,byrow=T))
# train auc
plot(list_plot_cv[[tf_cell_cv[1]]]$aroc12, color=my_palette["blue"], lwd=0.3, lty=1, auc.main=F,
         main=paste0("Cross-chromosome ROC curves \n(median AUC: ",round(median(train_auc[,"a"]),4),")"), 
         xlab="False positive rate", ylab="True positive rate")
plot(list_plot_cv[[tf_cell_cv[1]]]$aroc21, color=my_palette["blue"], lwd=0.3, lty=1, add=T)
for(i in tf_cell_cv[-1]){
    tmp=list_plot_cv[[i]]
    plot(tmp$aroc12, color=my_palette["blue"], lwd=0.3, lty=1, add=T)
    plot(tmp$aroc21, color=my_palette["blue"], lwd=0.3, lty=1, add=T)
}
segments(x0=0,y0=0,x1=1,y1=1,lty=2)

# test auc
plot(list_plot_final[[tf_cell_final[1]]]$aroc12, color=my_palette["red"], lwd=0.3, lty=1, auc.main=F,
         main=paste0("Cross-cell ROC curves \n(median AUC: ",round(median(test_auc[,"a"]),4),")"), 
         xlab="False positive rate", ylab="True positive rate")
plot(list_plot_final[[tf_cell_final[1]]]$aroc21, color=my_palette["red"], lwd=0.3, lty=1, add=T)
for(i in tf_cell_final[-1]){
    tmp=list_plot_final[[i]]
    plot(tmp$aroc12, color=my_palette["red"], lwd=0.3, lty=1, add=T)
    plot(tmp$aroc21, color=my_palette["red"], lwd=0.3, lty=1, add=T)
}
segments(x0=0,y0=0,x1=1,y1=1,lty=2)

# train auprc
plot(list_plot_cv[[tf_cell_cv[1]]]$apr12, color=my_palette["blue"], lwd=0.3, lty=1, auc.main=F,
        main=paste0("PR curves (median AUPRC: ",round(median(train_auprc[,"a"]),4),")"))
plot(list_plot_cv[[tf_cell_cv[1]]]$apr21, color=my_palette["blue"], lwd=0.3, lty=1, add=T)
for(i in tf_cell_cv[-1]){
    tmp=list_plot_cv[[i]]
    plot(tmp$apr12, color=my_palette["blue"], lwd=0.3, lty=1, add=T)
    plot(tmp$apr21, color=my_palette["blue"], lwd=0.3, lty=1, add=T)
}
avg=0.0029
segments(x0=0,y0=avg,x1=1,y1=avg,lty=2)
points(x=0,y=avg,pch=1,cex=2)
arrows(x0=0,y0=avg,x1=0.05,y1=0.1,lty=1,length=0.1,angle=20)
text(x=0.05,y=0.1,pos=4,offset=0,labels=paste0("baseline: ",sprintf("%.4f",avg)))

# test auprc
plot(list_plot_final[[tf_cell_final[1]]]$apr12, color=my_palette["red"], lwd=0.3, lty=1, auc.main=F,
        main=paste0("PR curves (median AUPRC: ",round(median(test_auprc[,"a"]),4),")"))
plot(list_plot_final[[tf_cell_final[1]]]$apr21, color=my_palette["red"], lwd=0.3, lty=1, add=T)
for(i in tf_cell_final[-1]){
    tmp=list_plot_final[[i]]
    plot(tmp$apr12, color=my_palette["red"], lwd=0.3, lty=1, add=T)
    plot(tmp$apr21, color=my_palette["red"], lwd=0.3, lty=1, add=T)
}
avg=0.0040
segments(x0=0,y0=avg,x1=1,y1=avg,lty=2)
points(x=0,y=avg,pch=1,cex=2)
arrows(x0=0,y0=avg,x1=0.05,y1=0.1,lty=1,length=0.1,angle=20)
text(x=0.05,y=0.1,pos=4,offset=0,labels=paste0("baseline: ",sprintf("%.4f",avg)))

# train tf-cell
plot(x1-0.1,y=train_auc[,"a"],col=my_palette["blue"],pch=1,xlim=c(0,length(tf_all)+1),ylim=c(0.89,1),
    main="AUC comparision",xlab="TF",ylab="AUC",xaxt='n',yaxt='n',cex=1.5)
rect(xleft=seq(1,length(tf_all),2)-0.5,ybottom=-0.1,xright=seq(1,length(tf_all),2)+0.5,ytop=1.1,
    col=paste0(my_palette["yellow"],60),border=NA)
points(x2+0.1,y=test_auc[,"a"],col=my_palette["red"],pch=15,cex=1.5)
axis(side=1,at=1:length(tf_all),labels=tf_all,cex.axis=0.8)
axis(side=2,at=seq(0.9,1,0.05),labels=seq(0.9,1,0.05),cex.axis=1,las=2)
legend("topright",legend=c("Cross-\nchromosome","Cross-\ncell"),col=my_palette[c("blue","red")],
    pch=c(1,15),cex=0.7,pt.cex=0.9)

# test tf-cell
plot(x1-0.1,y=train_auprc[,"a"],col=my_palette["blue"],pch=1,xlim=c(0,length(tf_all)+1),ylim=c(0,1),
    main="AUPRC comparision",xlab="TF",ylab="AUPRC",xaxt='n',yaxt='n',cex=1.5)
rect(xleft=seq(1,length(tf_all),2)-0.5,ybottom=-0.1,xright=seq(1,length(tf_all),2)+0.5,ytop=1.1,
    col=paste0(my_palette["yellow"],60),border=NA)
points(x2+0.1,y=test_auprc[,"a"],col=my_palette["red"],pch=15,cex=1.5)
axis(side=1,at=1:length(tf_all),labels=tf_all,cex.axis=0.8)
axis(side=2,at=seq(0,1,0.1),labels=seq(0,1,0.1),cex.axis=1,las=2)
legend("topright",legend=c("Cross-\nchromosome","Cross-\ncell"),col=my_palette[c("blue","red")],
    pch=c(1,15),cex=0.7,pt.cex=0.9)
dev.off()

