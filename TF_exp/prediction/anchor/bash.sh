#!/bin/bash

model=('F' 'G' 'H' 'I')

for i in "${model[@]}"
do
    cd ${i}
    perl prediction_${i}.pl
    perl concatenate_prediction.pl
    cd ..
done


cd ensemble
perl ensemble_model.pl

