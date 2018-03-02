## name: auc_auprc.r
## date: 12/03/2017

## Here I calculate auc & auprc for different models
## The plot points are subsampled and saved in list list_plot

library(PRROC)
set.seed(3.14)

path0="/state3/hyangl/TF_model/evaluation/target/"
path1="/state3/hyangl/TF_model/evaluation/anchor/F_G_H_I/" 
path2="/state3/hyangl/TF_model/evaluation/macs/F_G_H_I/" 
path3="/state3/hyangl/TF_model/evaluation/anchor/F_G/" 
path4="/state3/hyangl/TF_model/evaluation/anchor/H_I/" 
path5="/state3/hyangl/TF_model/evaluation/anchor_no_diff/F_H/"

tf_cell = list.files(path=path0,pattern="*set1.txt")
tf_cell = sub("_set1.txt","",tf_cell)

array_auc=array(NA,dim=c(2,length(tf_cell),5))
dimnames(array_auc)[1]=list(c("12","21"))
dimnames(array_auc)[2]=list(tf_cell)
dimnames(array_auc)[3]=list(c("a","m","FG","HI","an"))
array_auprc=array_auc

l=1000

list_plot=list()
for(i in tf_cell){
    print(i)
    target1=scan(paste0(path0, i, "_set1.txt"))
    target2=scan(paste0(path0, i, "_set2.txt"))
    # a - anchor_FGHI
    apred12=scan(paste0(path1, i, "_set1_model_set2_test.txt"))
    apred21=scan(paste0(path1, i, "_set2_model_set1_test.txt"))
    apr12=pr.curve(scores.class0=apred12, weights.class0=target2, curve=T)
    apr21=pr.curve(scores.class0=apred21, weights.class0=target1, curve=T)
    aroc12=roc.curve(scores.class0=apred12, weights.class0=target2, curve=T)
    aroc21=roc.curve(scores.class0=apred21, weights.class0=target1, curve=T)
    # m - macs_FGHI
    mpred12=scan(paste0(path2, i, "_set1_model_set2_test.txt"))
    mpred21=scan(paste0(path2, i, "_set2_model_set1_test.txt"))
    mpr12=pr.curve(scores.class0=mpred12, weights.class0=target2, curve=T)
    mpr21=pr.curve(scores.class0=mpred21, weights.class0=target1, curve=T)
    mroc12=roc.curve(scores.class0=mpred12, weights.class0=target2, curve=T)
    mroc21=roc.curve(scores.class0=mpred21, weights.class0=target1, curve=T)
    # FG - anchor_FG
    FGpred12=scan(paste0(path3, i, "_set1_model_set2_test.txt"))
    FGpred21=scan(paste0(path3, i, "_set2_model_set1_test.txt"))
    FGpr12=pr.curve(scores.class0=FGpred12, weights.class0=target2, curve=T)
    FGpr21=pr.curve(scores.class0=FGpred21, weights.class0=target1, curve=T)
    FGroc12=roc.curve(scores.class0=FGpred12, weights.class0=target2, curve=T)
    FGroc21=roc.curve(scores.class0=FGpred21, weights.class0=target1, curve=T)
    # HI - anchor_HI
    HIpred12=scan(paste0(path4, i, "_set1_model_set2_test.txt"))
    HIpred21=scan(paste0(path4, i, "_set2_model_set1_test.txt"))
    HIpr12=pr.curve(scores.class0=HIpred12, weights.class0=target2, curve=T)
    HIpr21=pr.curve(scores.class0=HIpred21, weights.class0=target1, curve=T)
    HIroc12=roc.curve(scores.class0=HIpred12, weights.class0=target2, curve=T)
    HIroc21=roc.curve(scores.class0=HIpred21, weights.class0=target1, curve=T)
    # an - anchor_no_diff
    anpred12=scan(paste0(path5, i, "_set1_model_set2_test.txt"))
    anpred21=scan(paste0(path5, i, "_set2_model_set1_test.txt"))
    anpr12=pr.curve(scores.class0=anpred12, weights.class0=target2, curve=T)
    anpr21=pr.curve(scores.class0=anpred21, weights.class0=target1, curve=T)
    anroc12=roc.curve(scores.class0=anpred12, weights.class0=target2, curve=T)
    anroc21=roc.curve(scores.class0=anpred21, weights.class0=target1, curve=T)
    # save
    array_auprc[,i,"a"]=c(apr12$auc.integral,apr21$auc.integral); array_auc[,i,"a"]=c(aroc12$auc,aroc21$auc)
    array_auprc[,i,"m"]=c(mpr12$auc.integral,mpr21$auc.integral); array_auc[,i,"m"]=c(mroc12$auc,mroc21$auc)
    array_auprc[,i,"FG"]=c(FGpr12$auc.integral,FGpr21$auc.integral); array_auc[,i,"FG"]=c(FGroc12$auc,FGroc21$auc)
    array_auprc[,i,"HI"]=c(HIpr12$auc.integral,HIpr21$auc.integral); array_auc[,i,"HI"]=c(HIroc12$auc,HIroc21$auc)
    array_auprc[,i,"an"]=c(anpr12$auc.integral,anpr21$auc.integral); array_auc[,i,"an"]=c(anroc12$auc,anroc21$auc)
    # subsampling for plot
    aroc12$curve=aroc12$curve[c(seq(dim(aroc12$curve)[1],1,-l),1),]
    aroc21$curve=aroc21$curve[c(seq(dim(aroc21$curve)[1],1,-l),1),]
    apr12$curve=apr12$curve[c(seq(dim(apr12$curve)[1]-l/10,1,-l),1),] # only skip the first 100
    apr21$curve=apr21$curve[c(seq(dim(apr21$curve)[1]-l/10,1,-l),1),]

    mroc12$curve=mroc12$curve[c(seq(dim(mroc12$curve)[1],1,-l),1),]
    mroc21$curve=mroc21$curve[c(seq(dim(mroc21$curve)[1],1,-l),1),]
    mpr12$curve=mpr12$curve[c(seq(dim(mpr12$curve)[1]-l,1,-l),1),] # skip the first 1000 otherwise the first hundrads of calls have low precision
    mpr21$curve=mpr21$curve[c(seq(dim(mpr21$curve)[1]-l,1,-l),1),] # sample every 1000 points otherwise too many points!

    FGroc12$curve=FGroc12$curve[c(seq(dim(FGroc12$curve)[1],1,-l),1),]
    FGroc21$curve=FGroc21$curve[c(seq(dim(FGroc21$curve)[1],1,-l),1),]
    FGpr12$curve=FGpr12$curve[c(seq(dim(FGpr12$curve)[1]-l/10,1,-l),1),] # skip the first 100
    FGpr21$curve=FGpr21$curve[c(seq(dim(FGpr21$curve)[1]-l/10,1,-l),1),] # sample every 1000 points otherwise too many points!

    HIroc12$curve=HIroc12$curve[c(seq(dim(HIroc12$curve)[1],1,-l),1),]
    HIroc21$curve=HIroc21$curve[c(seq(dim(HIroc21$curve)[1],1,-l),1),]
    HIpr12$curve=HIpr12$curve[c(seq(dim(HIpr12$curve)[1]-l/10,1,-l),1),] 
    HIpr21$curve=HIpr21$curve[c(seq(dim(HIpr21$curve)[1]-l/10,1,-l),1),]

    anroc12$curve=anroc12$curve[c(seq(dim(anroc12$curve)[1],1,-l),1),]
    anroc21$curve=anroc21$curve[c(seq(dim(anroc21$curve)[1],1,-l),1),]
    anpr12$curve=anpr12$curve[c(seq(dim(anpr12$curve)[1]-l/10,1,-l),1),] # skip the first 100
    anpr21$curve=anpr21$curve[c(seq(dim(anpr21$curve)[1]-l/10,1,-l),1),] # sample every 1000 points otherwise too many points!

    # list_for_plot
#    tmp=list(aroc12,apr12,aroc21,apr21,mroc12,mpr12,mroc21,mpr21,
#        FGroc12,FGpr12,FGroc21,FGpr21,HIroc12,HIpr12,HIroc21,HIpr21,
#        anroc12,anpr12,anroc21,anpr21)
#    names(tmp)=c("aroc12","apr12","aroc21","apr21","mroc12","mpr12","mroc21","mpr21",
#        "FGroc12","FGpr12","FGroc21","FGpr21","HIroc12","HIpr12","HIroc21","HIpr21",
#        "anroc12","anpr12","anroc21","anpr21")
    tmp=list(aroc12=aroc12,apr12=apr12,aroc21=aroc21,apr21=apr21,
	mroc12=mroc12,mpr12=mpr12,mroc21=mroc21,mpr21=mpr21,
    	FGroc12=FGroc12,FGpr12=FGpr12,FGroc21=FGroc21,FGpr21=FGpr21,
	HIroc12=HIroc12,HIpr12=HIpr12,HIroc21=HIroc21,HIpr21=HIpr21,
    	anroc12=anroc12,anpr12=anpr12,anroc21=anroc21,anpr21=anpr21)
    list_plot=c(list_plot,list(tmp))
    gc() # release memory
}
names(list_plot)=tf_cell

save(tf_cell,array_auc,array_auprc,list_plot,
	file="auc_auprc_cv.RData")


