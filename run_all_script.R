
library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

rm(list = ls())

# Source functions
source(file = '1_fetch/src/functions.R')
source(file = '2_process/src/functions.R')
source(file = '3_visualize/src/functions.R')

# 1 Fetch the data by defining sb_id
sb_id = '5d925066e4b0c4f70d0d0599'
fetch(sb_id = sb_id)

rawdata_dir <- '1_fetch/out/model_RMSEs.csv'

# 2 Process data for plotting and save as .csv
process(input = rawdata_dir)

processed_data_dir <- '2_process/out/model_summary_results.csv'

# 3 Visualize the results and write the diagnostic log 
viz(input_dir = processed_data_dir)

whisker(input_dir = processed_data_dir)
