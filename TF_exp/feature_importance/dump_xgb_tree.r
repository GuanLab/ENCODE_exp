## name: dump_xgb_tree.r
## date: 01/16/2018

## Here I extract feature importance from the command line version xgboost
## This version doesn't calculate feature importance, but the python/R version does.
## However, if you check what they do in their python code, they simply count the number of times a feature is used
## https://github.com/dmlc/xgboost/blob/master/python-package/xgboost/core.py
## As Yuanfang said, they are too lazy so they simply count.. 
## So here I simply dump the model to .txt file first then count the number. period.

## I use anchor_I, which is the most complete one.
path1="/home/gyuanfan/2017/TF/code_new12/diff_orange_anchor_bam_DNAse_and_diff_mm_largespace_ruTF_top4_rank_largespace_top20_allfact_with_ATF3/ATF2/"

folder_name=list.files(path=path1,pattern="*set[1-2]_eva")

for(i in 1:length(folder_name)){
    tmp=unlist(strsplit(folder_name[i],split="\\."))
    name=paste0(tmp[2],"_",tmp[3],"_",tmp[6],"_",sub("tab_","",tmp[7]))
    # find best model based on auprc
    auprc_file=list.files(paste0(path1,folder_name[i]),pattern="*auprc.txt")
    auprc=0
    id=NULL
    for(j in 1:length(auprc_file)){
        tmp=scan(paste0(path1,folder_name[i],"/",auprc_file[j]),quiet=TRUE)
        if(tmp>auprc){
            id=auprc_file[j]
            auprc=tmp
        }
    }
    # copy model
    model=sub(".auprc.txt","",id)
    system(paste0("mkdir -p model/",name))
    system(paste0("cp ", paste0(path1,folder_name[i],"/",id), " model/", name))
    system(paste0("cp ", paste0(path1,folder_name[i],"/",model), " model/", name))
    # dump model
    system(paste0("cp xgtree.conf model/",name))
    system(paste0("xgboost xgtree.conf task=dump model_in=model/", name, "/", model, " name_dump=model/", name, "/xgbtree.txt"))
}

system("mv model anchor_I")

