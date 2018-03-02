## name: plot_fig4.r
## date: 01/22/2018

load("auc_auprc.RData")
source("my_palette.r")
source("multiplot.R")

# auc model - tf - scatter
auc=cbind(apply(array_auc_extra,2:3,mean),apply(array_auc_final,2:3,mean)[,c("m","a")])
colnames(auc)=c("TF","TFs","DNAse","DDNAse","DNAse_neighbors","MACS","ANCHOR")
rownames(auc)=sub("induced_pluripotent_stem_cell","iPSC",rownames(auc))
auc.m=melt(auc)
colnames(auc.m)=c("TF","model","AUC")
tmp_col=rev(my_palette[c("red","yellow","green","cyan","blue","bluegrey","brown")])
names(tmp_col)=colnames(auc)

p_auc_model = ggplot(auc.m, aes(model, AUC, fill=model)) + 
    geom_violin(colour="grey50",draw_quantiles = 0.5) +
    scale_fill_manual(values=tmp_col) +
    labs(title="Model Comparison") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0.65,1)

p_auc_tf = ggplot(auc.m, aes(TF, AUC, colour = model, group=model)) + 
    geom_point(size=3) +
    #geom_line() +
    scale_colour_manual(values=tmp_col) +
    labs(title="TF-Cell Comparison") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0.65,1)

p_auc_scatter = ggplot(data.frame(auc), aes(MACS, ANCHOR)) +
    geom_abline(intercept = 0, slope = 1, colour="grey50") +
    geom_point(colour = my_palette["blue"]) +
    xlim(0.95,1) +
    ylim(0.95,1) +
    labs(title="AUC", x = paste0("MACS (median: ",round(mean(auc[,"MACS"]),4),")"), 
        y =  paste0("ANCHOR (median: ", round(mean(auc[,"ANCHOR"]),4),")")) +
    theme(plot.title = element_text(hjust = 0.5))

# auprc model - tf - scatter
auprc=cbind(apply(array_auprc_extra,2:3,mean),apply(array_auprc_final,2:3,mean)[,c("m","a")])
colnames(auprc)=c("TF","TFs","DNAse","DDNAse","DNAse_neighbors","MACS","ANCHOR")
rownames(auprc)=sub("induced_pluripotent_stem_cell","iPSC",rownames(auprc))
auprc.m=melt(auprc)
colnames(auprc.m)=c("TF","model","AUPRC")
tmp_col=rev(my_palette[c("red","yellow","green","cyan","blue","bluegrey","brown")])
names(tmp_col)=colnames(auprc)

p_auprc_model = ggplot(auprc.m, aes(model, AUPRC, fill=model)) +
    geom_violin(colour="grey50",draw_quantiles = 0.5) +
    scale_fill_manual(values=tmp_col) +
    labs(title="Model Comparison") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0,0.8)

p_auprc_tf = ggplot(auprc.m, aes(TF, AUPRC, colour = model, group=model)) +
    geom_point(size=3) +
    #geom_line() +
    scale_colour_manual(values=tmp_col) +
    labs(title="TF-Cell Comparison") +
    theme(plot.title = element_text(hjust = 0.5)) +
    ylim(0,0.8)

p_auprc_scatter = ggplot(data.frame(auprc), aes(MACS, ANCHOR)) +
    geom_abline(intercept = 0, slope = 1, colour="grey50") +
    geom_point(colour = my_palette["blue"]) +
    xlim(0.25,0.75) +
    ylim(0.25,0.75) +
    labs(title="AUPRC", x = paste0("MACS (median: ",round(mean(auprc[,"MACS"]),4),")"), 
        y =  paste0("ANCHOR (median: ", round(mean(auprc[,"ANCHOR"]),4),")")) +
    theme(plot.title = element_text(hjust = 0.5))

list_p=list()
list_p[[1]]=p_auc_model
list_p[[2]]=p_auc_scatter
list_p[[3]]=p_auc_tf
list_p[[4]]=p_auprc_model
list_p[[5]]=p_auprc_scatter
list_p[[6]]=p_auprc_tf

pdf(file="figure/fig4_model_comparison.pdf",width=12,height=16)
mat_layout=matrix(c(rep(c(rep(1,7),rep(2,4),0),4),rep(3,12*4),rep(c(rep(4,7),rep(5,4),0),4),rep(6,12*4)),
    nrow=16,byrow=T)
multiplot(plotlist=list_p,layout = mat_layout)
dev.off()

