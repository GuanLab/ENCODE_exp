#!/bin/bash

# convert bam to txt file
perl transform_bam_to_track.pl

# sum raw reads from all tech/bio replicates and separate them into 23 chromsomes
perl create_DNAse_avg_track_by_chr.pl

## 1. Anchor process ###########
# subsample 1/1000 and rank reads of all chrs for the multi-cell mapping/anchoring
perl approximate_max_min_median.pl

# map signals to the reference cell line (liver by default)
perl normalize_by_anchor.pl
################################

## 2. Feature extraction #######
# 3M - mean; max&min
perl create_DNAse.pl
perl create_DNAse_max_min.pl

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





