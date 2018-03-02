# ENCODE TF binding site prediction

The codes for 1.process data 2.train&predict 3.analyze results 4.feature importance 5.plot

background: [ENCODE-DREAM](https://www.synapse.org/#!Synapse:syn6131484)

see also: [Yuanfang Guan's 1st Place Solution](https://www.synapse.org/#!Synapse:syn7104742/wiki/407367) [Code](https://www.synapse.org/#!Synapse:syn7104742/files/)

Warning! You need to change the **PATH** to the data on your own disk before running any of the following codes! (Upgrade: modify the path)

Usage Example (Anchor model):

## 1. process data

cd TF_exp/data_process/anchor_dnase

./bash.sh

cd ../sequence

./bash.sh

cd ../gencode

./bash.sh

## 2. train and predict

### (1) subsample negative cases

cd TF_exp/data/sample

./bash.sh 

### (2) prepare training & validation data

cd ../train_test/anchor

./bash.sh

### (3) train models

cd ../../../model/anchor

./bash.sh

### (4) predict

cd ../../prediction/anchor/

./bash.sh

## 3. analyze

### (1) prepare data for evaluation

cd TF_exp/evaluation/target # gold standard

bash bash.sh

cd ../anchor/ # prediction

./bash.sh

### (2) calcualte AUROCs and AUPRCs

cd ../../analysis/

./bash.sh

## 4. feature importance

cd TF_exp/feature_importance

./bash.sh

## 5. plot

cd TF_exp/analysis/

Rscript plot_fig1.r




