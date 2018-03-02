#!/bin/bash

cd anchor_I

for FILE in ./*eva
do
    cd $FILE
    echo $FILE
    Rscript xgb_feature_importance.R xgbtree.txt fi.txt
    cd ..
done

cd ..
