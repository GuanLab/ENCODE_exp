## name: auc_auprc.r
## date: 12/03/2017

## Here I calculate auc & auprc for different models
## The plot points are subsampled and saved in list list_plot

library(PRROC)
set.seed(3.14)

path0="/state3/hyangl/TF_model/evaluation/target/final/"
path1="/state3/hyangl/TF_model/evaluation/tf/" 
path2="/state3/hyangl/TF_model/evaluation/tf_all/" 
path3="/state3/hyangl/TF_model/evaluation/mmm/" 
path4="/state3/hyangl/TF_model/evaluation/mmm_diff/" 
path5="/state3/hyangl/TF_model/evaluation/mmm_diff_largespace/"

tf_cell = list.files(path=path0,pattern="*set1.txt")
tf_cell = sub("_set1.txt","",tf_cell)

array_auc=array(NA,dim=c(2,length(tf_cell),5))
dimnames(array_auc)[1]=list(c("12","21"))
dimnames(array_auc)[2]=list(tf_cell)
dimnames(array_auc)[3]=list(c("tf","tfs","mmm","md","mdl"))
array_auprc=array_auc

l=1000

list_plot=list()
for(i in tf_cell){
    print(i)
    target1=scan(paste0(path0, i, "_set1.txt"))
    target2=scan(paste0(path0, i, "_set2.txt"))
    # tf 
    tfpred12=scan(paste0(path1, i, "_set1_model_set2_test.txt"))
    tfpred21=scan(paste0(path1, i, "_set2_model_set1_test.txt"))
    tfpr12=pr.curve(scores.class0=tfpred12, weights.class0=target2, curve=T)
    tfpr21=pr.curve(scores.class0=tfpred21, weights.class0=target1, curve=T)
    tfroc12=roc.curve(scores.class0=tfpred12, weights.class0=target2, curve=T)
    tfroc21=roc.curve(scores.class0=tfpred21, weights.class0=target1, curve=T)
    # tfs - tf_all
    tfspred12=scan(paste0(path2, i, "_set1_model_set2_test.txt"))
    tfspred21=scan(paste0(path2, i, "_set2_model_set1_test.txt"))
    tfspr12=pr.curve(scores.class0=tfspred12, weights.class0=target2, curve=T)
    tfspr21=pr.curve(scores.class0=tfspred21, weights.class0=target1, curve=T)
    tfsroc12=roc.curve(scores.class0=tfspred12, weights.class0=target2, curve=T)
    tfsroc21=roc.curve(scores.class0=tfspred21, weights.class0=target1, curve=T)
    # mmm -
    mmmpred12=scan(paste0(path3, i, "_set1_model_set2_test.txt"))
    mmmpred21=scan(paste0(path3, i, "_set2_model_set1_test.txt"))
    mmmpr12=pr.curve(scores.class0=mmmpred12, weights.class0=target2, curve=T)
    mmmpr21=pr.curve(scores.class0=mmmpred21, weights.class0=target1, curve=T)
    mmmroc12=roc.curve(scores.class0=mmmpred12, weights.class0=target2, curve=T)
    mmmroc21=roc.curve(scores.class0=mmmpred21, weights.class0=target1, curve=T)
    # md - mmm_diff
    mdpred12=scan(paste0(path4, i, "_set1_model_set2_test.txt"))
    mdpred21=scan(paste0(path4, i, "_set2_model_set1_test.txt"))
    mdpr12=pr.curve(scores.class0=mdpred12, weights.class0=target2, curve=T)
    mdpr21=pr.curve(scores.class0=mdpred21, weights.class0=target1, curve=T)
    mdroc12=roc.curve(scores.class0=mdpred12, weights.class0=target2, curve=T)
    mdroc21=roc.curve(scores.class0=mdpred21, weights.class0=target1, curve=T)
    # mdl - mmm_diff_largespace
    mdlpred12=scan(paste0(path5, i, "_set1_model_set2_test.txt"))
    mdlpred21=scan(paste0(path5, i, "_set2_model_set1_test.txt"))
    mdlpr12=pr.curve(scores.class0=mdlpred12, weights.class0=target2, curve=T)
    mdlpr21=pr.curve(scores.class0=mdlpred21, weights.class0=target1, curve=T)
    mdlroc12=roc.curve(scores.class0=mdlpred12, weights.class0=target2, curve=T)
    mdlroc21=roc.curve(scores.class0=mdlpred21, weights.class0=target1, curve=T)
    # save
    array_auprc[,i,"tf"]=c(tfpr12$auc.integral,tfpr21$auc.integral); array_auc[,i,"tf"]=c(tfroc12$auc,tfroc21$auc)
    array_auprc[,i,"tfs"]=c(tfspr12$auc.integral,tfspr21$auc.integral); array_auc[,i,"tfs"]=c(tfsroc12$auc,tfsroc21$auc)
    array_auprc[,i,"mmm"]=c(mmmpr12$auc.integral,mmmpr21$auc.integral); array_auc[,i,"mmm"]=c(mmmroc12$auc,mmmroc21$auc)
    array_auprc[,i,"md"]=c(mdpr12$auc.integral,mdpr21$auc.integral); array_auc[,i,"md"]=c(mdroc12$auc,mdroc21$auc)
    array_auprc[,i,"mdl"]=c(mdlpr12$auc.integral,mdlpr21$auc.integral); array_auc[,i,"mdl"]=c(mdlroc12$auc,mdlroc21$auc)
    # subsampling for plot
    tfroc12$curve=tfroc12$curve[c(seq(dim(tfroc12$curve)[1],1,-l),1),]
    tfroc21$curve=tfroc21$curve[c(seq(dim(tfroc21$curve)[1],1,-l),1),]
    tfpr12$curve=tfpr12$curve[c(seq(dim(tfpr12$curve)[1]-l/10,1,-l),1),] # only skip the first 100
    tfpr21$curve=tfpr21$curve[c(seq(dim(tfpr21$curve)[1]-l/10,1,-l),1),]

    tfsroc12$curve=tfsroc12$curve[c(seq(dim(tfsroc12$curve)[1],1,-l),1),]
    tfsroc21$curve=tfsroc21$curve[c(seq(dim(tfsroc21$curve)[1],1,-l),1),]
    tfspr12$curve=tfspr12$curve[c(seq(dim(tfspr12$curve)[1]-l,1,-l),1),] # skip the first 1000 otherwise the first hundrads of calls have low precision
    tfspr21$curve=tfspr21$curve[c(seq(dim(tfspr21$curve)[1]-l,1,-l),1),] # sample every 1000 points otherwise too many points!

    mmmroc12$curve=mmmroc12$curve[c(seq(dim(mmmroc12$curve)[1],1,-l),1),]
    mmmroc21$curve=mmmroc21$curve[c(seq(dim(mmmroc21$curve)[1],1,-l),1),]
    mmmpr12$curve=mmmpr12$curve[c(seq(dim(mmmpr12$curve)[1]-l/10,1,-l),1),] # skip the first 100
    mmmpr21$curve=mmmpr21$curve[c(seq(dim(mmmpr21$curve)[1]-l/10,1,-l),1),] # sample every 1000 points otherwise too many points!

    mdroc12$curve=mdroc12$curve[c(seq(dim(mdroc12$curve)[1],1,-l),1),]
    mdroc21$curve=mdroc21$curve[c(seq(dim(mdroc21$curve)[1],1,-l),1),]
    mdpr12$curve=mdpr12$curve[c(seq(dim(mdpr12$curve)[1]-l/10,1,-l),1),] 
    mdpr21$curve=mdpr21$curve[c(seq(dim(mdpr21$curve)[1]-l/10,1,-l),1),]

    mdlroc12$curve=mdlroc12$curve[c(seq(dim(mdlroc12$curve)[1],1,-l),1),]
    mdlroc21$curve=mdlroc21$curve[c(seq(dim(mdlroc21$curve)[1],1,-l),1),]
    mdlpr12$curve=mdlpr12$curve[c(seq(dim(mdlpr12$curve)[1]-l/10,1,-l),1),] # skip the first 100
    mdlpr21$curve=mdlpr21$curve[c(seq(dim(mdlpr21$curve)[1]-l/10,1,-l),1),] # sample every 1000 points otherwise too many points!

    tmp=list(tfroc12=tfroc12,tfpr12=tfpr12,tfroc21=tfroc21,tfpr21=tfpr21,
	tfsroc12=tfsroc12,tfspr12=tfspr12,tfsroc21=tfsroc21,tfspr21=tfspr21,
    	mmmroc12=mmmroc12,mmmpr12=mmmpr12,mmmroc21=mmmroc21,mmmpr21=mmmpr21,
	mdroc12=mdroc12,mdpr12=mdpr12,mdroc21=mdroc21,mdpr21=mdpr21,
    	mdlroc12=mdlroc12,mdlpr12=mdlpr12,mdlroc21=mdlroc21,mdlpr21=mdlpr21)
    list_plot=c(list_plot,list(tmp))
    gc() # release memory
}
names(list_plot)=tf_cell

save(tf_cell,array_auc,array_auprc,list_plot,
	file="auc_auprc_extra.RData")


