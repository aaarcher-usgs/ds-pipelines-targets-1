#' # Define process() function
#' 
#' The `process()` function filters the data and assigns colors/pch values based on
#' model_type.
#' 
#' @param input_data chr, file path where the raw data is saved
#' 
#' @param output_file chr, file path of the subfolder where processed data will be saved 
#' 
#' @param col_v vec, hex colors for the three types of model_types
#' 
#' @param pch_v
process <- function(input_data, output_file, col_model_type, pch_model_type){
  
  # Prepare the data for plotting
  eval_data <- readr::read_csv(input_data, col_types = 'iccd') %>%
    filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ col_model_type[1],
      model_type == 'dl' ~ col_model_type[2],
      model_type == 'pgdl' ~ col_model_type[3]
    ), pch = case_when(
      model_type == 'pb' ~ pch_model_type[1],
      model_type == 'dl' ~ pch_model_type[2],
      model_type == 'pgdl' ~ pch_model_type[3]
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
  
  # Save the processed data
  readr::write_csv(eval_data, file = file.path(output_file))
  
}


