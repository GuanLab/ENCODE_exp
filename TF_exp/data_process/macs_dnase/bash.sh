#!/bin/bash

## 1. Anchor process ###########

################################

## 2. Feature extraction #######
# 3M - mean; max&min
perl create_DNAse_amm.pl

# delta-3M - mean; max&min
perl create_DNAse_diff.pl
perl create_DNAse_max_min_diff.pl

# 3M-neighbors - mean; max&min
perl create_DNAse_largespace.pl
perl create_DNAse_max_min_largespace.pl

# delta-3M-neighbor - mean; max&min
perl create_DNAse_diff_largespace.pl
perl create_DNAse_max_min_diff_largespace.pl
################################

## 3. Frequency feature ########
# count the number of signal occurance; ignore values
perl produce_orange.pl
perl produce_orange_rank.pl

# neighbors
perl create_orange_largespace.pl

# delta-neighbors
perl create_orange_diff.pl
perl create_orange_rank_largespace.pl
###############################





