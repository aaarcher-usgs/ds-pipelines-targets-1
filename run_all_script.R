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
library(devtools)


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
rawdata_out_dir <- '1_fetch/out/'
rawdata_out_file <- paste0(rawdata_out_dir, 'model_RMSEs.csv')

# Processed data from process()
process_out_dir <- '2_process/out/'
process_out_file <- paste0(process_out_dir, 'model_summary_results.csv')

# Color and pch values
col_model_type <- c('#1b9e77', '#d95f02', '#7570b3') #pb, dl, pgdl, respectively
pch_model_type <- c(21, 22, 23) #pb, dl, pgdl, respectively

# Model names and experimental temperatures for diagnostic log
model_IDs <- c("pb", "dl", "pgdl")
exper_temps <- c(980, 500, 100, 2)

# Line Range figure output 
plot_output_dir <- "3_visualize/out/"
plot_output_file <- paste0(plot_output_dir, "figure_1.png")

# Diagnostic log (text file)
log_output_dir <- "3_visualize/out/"
log_output_file <- paste0(log_output_dir, 'model_diagnostic_text.txt')


#' ## Step 1: Fetch the data
#' 
#' Use ScienceBase ID (`sb_id`) to locate and download raw data
#' 
fetch(sb_id = sb_id, out_file = rawdata_out_file)



#' ## Step 2: Process data for plotting and save as .csv
#' 
#' Process raw data into a form for plotting *and* save processed data as .csv
#'
process(input_data = rawdata_out_file, 
        output_file = process_out_file,
        col_model_type = col_model_type,
        pch_model_type = pch_model_type)


#' ## Step 3: Visualize the results and write the diagnostic log
#' 
#' Create a line-range figure that has Test RMSE on y-axis and Training temperature profiles on x-axis grouped by model type
#' 
line_range_plot(input_file = process_out_file, 
                output_file = plot_output_file,
                col_v = col_model_type,
                pch_v = pch_model_type)

#' Write the diagnostic log to a text file
#' 
diagnostic_log(input_file = process_out_file, 
               output_file = log_output_file,
               model_type = model_IDs,
               exper_num = exper_temps)

#' ## Footer
#'
devtools::session_info()
