#!/bin/bash

# dump the best models to tree.txt
Rscript dump_xgb_tree.r

# feature importance - note that if a feature is not used at all, it's not reported (importance=0)
bash extract_fi.sh

# collect a summary fi table of 556 features * 13 tfs
Rscript create_fi_table.r


