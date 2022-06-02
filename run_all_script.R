#' # Test RMSE versus Training Temperature Profiles
#' 
#' This script fetches, processes, and plots data to compare Test RMSE versus Training 
#' temperature profiles. 
#' 
#' 
#' ## Header
#' 
#' Load libraries
library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

#' Clear environment (optional)
#' 
rm(list = ls())


#' ## Load source functions 
#' 
#' Functions to fetch the raw data from Scibase (`fetch()`), process (and save) it for plotting (`process()`), 
#' and finally create a diagnostic log (`diagnostic_log()`) and associated figure (`line_range_plot()`).
source(file = '1_fetch/src/fetch_fcn.R')
source(file = '2_process/src/process_fcn.R')
source(file = '3_visualize/src/line_range_plot_fcn.R')
source(file = '3_visualize/src/diagnostic_log_fcn.R')


#' ## Set global definitions
#' 
#' Define ScienceBase ID
sb_id = '5d925066e4b0c4f70d0d0599'

#' Define input and output directories
#' 

# Raw data from fetch()
rawdata_out_dir <- '1_fetch/out'
rawdata_out_file <- '1_fetch/out/model_RMSEs.csv'

#' ## Step 1: Fetch the data
#' 
#' Uses ScienceBase ID (`sb_id`) to locate and download raw data
#' 
fetch(sb_id = sb_id, out_dir = rawdata_out_dir)



# 2 Process data for plotting and save as .csv
process(input = rawdata_dir)

processed_data_dir <- '2_process/out/model_summary_results.csv'

# 3 Visualize the results and write the diagnostic log 
line_range_plot(input_dir = processed_data_dir)

diagnostic_log(input_dir = processed_data_dir)
