process <- function(input){
  
  # Set output directory
  project_output_dir <- "2_process/out"
  
  # Prepare the data for plotting
  eval_data <- readr::read_csv(input, col_types = 'iccd') %>%
    filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ '#1b9e77',
      model_type == 'dl' ~'#d95f02',
      model_type == 'pgdl' ~ '#7570b3'
    ), pch = case_when(
      model_type == 'pb' ~ 21,
      model_type == 'dl' ~ 22,
      model_type == 'pgdl' ~ 23
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
  
  # Save the processed data
  readr::write_csv(eval_data, file = file.path(project_output_dir, 'model_summary_results.csv'))
  
  #assign("eval_data", eval_data, envir = .GlobalEnv)
}


