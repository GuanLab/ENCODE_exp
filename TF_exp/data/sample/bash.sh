#!/bin/bash

for i in {1..4}
do
    cd 0${i}
    perl run_create_sample.pl
    cd ..
done
