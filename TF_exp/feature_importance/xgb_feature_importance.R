## name: xgb_feature_importance.R
## date: 01/16/2018

## Here I parse the dumped xgb tree and extract feature importance
## The solution is simply counting the number of feature used in all trees, the same as the python version
## https://github.com/dmlc/xgboost/blob/master/python-package/xgboost/core.py - get_score("weight")

args <- commandArgs(trailingOnly = TRUE)
if(length(args)!=2){print("Wrong arguments!\nRscript xgb_feature_importance.R dump_xgbtree.txt output_filename\n")}

tree=readLines(args[1])
tree=gsub("\t","",tree)
# exclude boost & leaf lines
feature=tree[-c(grep("boost",tree),grep("leaf",tree))]
num=as.numeric(sub("<.*","",sub(".*f","",feature)))

output=cbind(as.numeric(names(table(num))),table(num)/length(num))
write.table(output, file=args[2], col.names=F, row.names=F, sep="\t", quote=F)


