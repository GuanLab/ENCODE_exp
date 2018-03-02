## name: generate_SI_tables.r
## date: 02/22/2018

## across and within cell types from challenge results

source("my_palette.r")
source("multiplot.R")

x=read.csv("challenge_results.csv",check.names=F,stringsAsFactors=F)

team=c("yuanfang.guan","J-Team","dxquang","autosome.ru")
tf_cell=c("CTCT_PC-3","CTCT_iPSC","E2F1_K562",
    paste0(c("EGR1","FOXA1","FOXA2","GABPA","HNF4A","JUND","MAX","NANOG","REST","TAF1"),"_liver"))

ind=c(1:13, 1:13+14, 1:13+28, 1:13+42)
tbl=matrix(NA,nrow=56,ncol=12)
for(i in 1:length(team)){
    tbl[ind,(i-1)*3+1]=round(unlist(x[x[,2]==team[i],3:6]),4)
    tbl[ind,(i-1)*3+2]=round(unlist(x[x[,2]==team[i],9:12]),4)
    tbl[ind,(i-1)*3+3]=tbl[ind,(i-1)*3+1]-tbl[ind,(i-1)*3+2]
}
for(i in 1:4){
    tbl[i*14,]=apply(tbl[((i-1)*14+1):(i*14-1),],2,median)
}

rownames(tbl)=rep(c(tf_cell,"median"),4)
colnames(tbl)=rep(c("across","within","difference"),4)
write.csv(tbl,file="table/SI_challenge_results.csv")


col_tmp=paste0(my_palette[c("red","yellow","teal","blue")])
plot(0,col="white",xlim=c(0.9,1),ylim=c(0.9,1),pch=1,cex=0.7,
    main=paste0("AUPRC"),xlab="across cell type",ylab="within cell type")
for(i in 1:length(team)){
    x1=tbl[1:13,(i-1)*3+1]
    y1=tbl[1:13,(i-1)*3+2]
    plot(x=x1,y=y1,col=col_tmp[i],xlim=c(0.9,1),ylim=c(0.9,1),pch=16,cex=0.7,
        main=paste0("AUROC(",team[i],")"),xlab="across cell type",ylab="within cell type")
    tmp=lm(y1 ~ x1)
    abline(tmp,lty=2,col=col_tmp[i])
    segments(x0=0.9,x1=1,y0=0.9,y1=1,lty=2)
    text(x=0.92,y=0.98,labels=paste0("slope: ",round(tmp$coefficients[2],2)))
}

plot(0,col="white",xlim=c(0.19,0.91),ylim=c(0.19,0.91),pch=1,cex=0.7,
    main=paste0("AUPRC"),xlab="across cell type",ylab="within cell type")
for(i in 1:length(team)){
    x1=tbl[15:27,(i-1)*3+1]
    y1=tbl[15:27,(i-1)*3+2]
    points(x=x1,y=y1,col=col_tmp[i],xlim=c(0.19,0.91),ylim=c(0.19,0.91),pch=1,cex=0.7)
    tmp=lm(y1 ~ x1)
    #abline(tmp,lty=2,col=col_tmp[i])
    segments(x0=0.19,x1=0.91,y0=0.19,y1=0.91,lty=2)
    #text(x=0.3,y=0.7,labels=paste0("slope: ",round(tmp$coefficients[2],2)))
}
legend("bottomright",legend=team,col=col_tmp,pch=1,cex=0.7)


## ENCODE SI Table ###

load("auc_auprc.RData")

tbl1=cbind(apply(array_auc_cv,2:3,mean),apply(array_auprc_cv,2:3,mean))[,c(1,6)]
tbl1=rbind(tbl1,median=apply(tbl1,2,median))
colnames(tbl1)=c("AUROC","AUPRC")

tbl2=cbind(apply(array_auc_final,2:3,mean),apply(array_auprc_final,2:3,mean))[,c(1,6)]
tbl2=rbind(tbl2,median=apply(tbl2,2,median))
colnames(tbl2)=c("AUROC","AUPRC")

tbl=rbind(tbl1,tbl2)
rownames(tbl)=sub("induced_pluripotent_stem_cell","iPSC",rownames(tbl))

write.csv(tbl,file="table/SI_across_within.csv")


tbl1=cbind(apply(array_auc_extra,2:3,mean),apply(array_auc_final[,,c("m","a")],2:3,mean))
tbl1=rbind(tbl1,median=apply(tbl1,2,median))
colnames(tbl1)=c("TF","TFs","3M-DNase","D3M-DNase","D3M-DNase-neighbors","No-Anchor","Anchor")
tbl1=round(tbl1,4)

tbl2=cbind(apply(array_auprc_extra,2:3,mean),apply(array_auprc_final[,,c("m","a")],2:3,mean))
tbl2=rbind(tbl2,median=apply(tbl2,2,median))
colnames(tbl2)=c("TF","TFs","3M-DNase","D3M-DNase","D3M-DNase-neighbors","No-Anchor","Anchor")
tbl2=round(tbl2,4)

tbl=rbind(tbl1,tbl2)
rownames(tbl)=sub("induced_pluripotent_stem_cell","iPSC",rownames(tbl))

write.csv(tbl,file="table/SI_feature_comparison.csv")

load("../feature_importance/anchor_I_fi.RData")
write.csv(mat_fi,file="table/SI_feature_importance.csv")

