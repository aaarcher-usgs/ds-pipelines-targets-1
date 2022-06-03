library(targets)

# Functions to fetch the raw data from Scibase (`fetch()`), process (and save) it for plotting (`process()`), 
# and finally create a diagnostic log (`diagnostic_log()`) and associated figure (`line_range_plot()`).
source(file = '1_fetch/src/fetch_fcn.R')
source(file = '2_process/src/process_fcn.R')
source(file = '2_process/src/write_csv_fcn.R')
source(file = '3_visualize/src/line_range_plot_fcn.R')
source(file = '3_visualize/src/diagnostic_log_fcn.R')

tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    fetch(sb_id = '5d925066e4b0c4f70d0d0599',
          out_file = "1_fetch/out/model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    process(input_data = model_RMSEs_csv,
            col_model_type = c('#1b9e77', '#d95f02', '#7570b3'), #pb, dl, pgdl, respectively,
            pch_model_type = c(21, 22, 23)) #pb, dl, pgdl, respectively),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    line_range_plot(input_data = eval_data,
                    output_file = "3_visualize/out/figure_1.png", 
                    col_v = c('#1b9e77', '#d95f02', '#7570b3'), #pb, dl, pgdl, respectively,
                    pch_v = c(21, 22, 23)) #pb, dl, pgdl, respectively
  ),
  # Save the processed data 
  tar_target(
     model_summary_results_csv,
     write_csv_fcn(input_data = eval_data, 
                   output_file = "2_process/out/model_summary_results.csv")
   ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    diagnostic_log(output_file = "3_visualize/out/model_diagnostic_text.txt", 
                   input_data = eval_data,
                   model_type = c("pb", "dl", "pgdl"),
                   exper_num = c(980, 500, 100, 2))
  )
)
