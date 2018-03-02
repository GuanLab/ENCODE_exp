#!/bin/bash

# anchor, macs
Rscript auc_auprc_cv.r
Rscript auc_auprc_final.r
# tf, tfs, 3M, delta-3M, delta-3M-neighbor
Rscript auc_auprc_extra.r

# combine them
Rscript auc_auprc.r


