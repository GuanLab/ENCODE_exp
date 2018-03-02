## name: auc_auprc.r
## date: 01/23/2018

## Here I combine the auc_auprc results from cv,final,extra

library(abind)

load("auc_auprc_cv.RData")
array_auc_cv=array_auc
array_auprc_cv=array_auprc
list_plot_cv=list_plot
tf_cell_cv=tf_cell

load("auc_auprc_final.RData")
array_auc_final=array_auc
array_auprc_final=array_auprc
list_plot_final=list_plot
tf_cell_final=tf_cell

load("auc_auprc_extra.RData")
array_auc_extra=array_auc
array_auprc_extra=array_auprc
list_plot_extra=list_plot


save(tf_cell_cv, tf_cell_final,
    array_auc_cv,array_auc_final,array_auc_extra,
    array_auprc_cv,array_auprc_final,array_auprc_extra,
#    list_plot_cv,list_plot_final,list_plot_extra,
    file="auc_auprc.RData")


