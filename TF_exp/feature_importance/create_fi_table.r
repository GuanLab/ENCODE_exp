## name: create_fi_table.r
## date: 01/18/2018

## Here I create feature importance table
## For multiple models of the same tf, I simply calculate the average
## mat_fi = 556 features * 13 tfs

path1="./anchor_I/"

tf_all=c("ATF3","CTCF","E2F1","EGR1","FOXA1","FOXA2","GABPA","HNF4A","JUND","MAX","NANOG","REST","TAF1")

# complete name & id of in total 556 features
id=21:576
name_feature=c(paste0("rna",seq(1,20,1)),
    unlist(lapply(as.list(tf_all),function(x){
        c(paste0(x,"_top1_+-",c(0,seq(1,13,2))),
        paste0(x,"_top2_+-",c(0,seq(1,13,2))),
        paste0(x,"_top3_+-",c(0,seq(1,13,2))),
        paste0(x,"_top4_+-",c(0,seq(1,13,2))))
    })),
    "mean_0", paste0("mean_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "delta_mean_0",paste0("delta_mean_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "max_0", paste0("max_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "min_0", paste0("min_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "delta_max_0",paste0("delta_max_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "delta_min_0",paste0("delta_min_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "orange_0", paste0("orange_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)),
    "delta_orange_0",paste0("delta_orange_",rep(c("-","+"),7),rep(seq(1,13,2),each=2)))

mat_fi=matrix(0,nrow=length(id),ncol=length(tf_all))
colnames(mat_fi)=tf_all
rownames(mat_fi)=id

folder_name=list.files(path=path1,pattern="*set[1-2]_eva")

for (i in 1:length(tf_all)){
    tf=tf_all[i]
    ind=grep(tf,folder_name)
    for(j in 1:length(ind)){
        tbl=read.delim(paste0(path1,folder_name[ind[j]],"/fi.txt"),header=F)
        rownames(tbl)=tbl[,1]
        mat_fi[rownames(tbl),tf]=mat_fi[rownames(tbl),tf]+tbl[,2]
    }
    mat_fi[,tf]=mat_fi[,tf]/length(ind)
}

rownames(mat_fi)=name_feature

tmp=cbind(feature=rownames(mat_fi),mat_fi)
write.table(tmp,file="anchor_I_fi.txt",col.names=T, row.names=F, sep="\t", quote=F)

save(mat_fi,file="anchor_I_fi.RData")



