#' # Define process() function
#' 
#' @description The `process()` function filters the data and assigns colors/pch values based on
#' model_type.
#' 
#' @param input_file chr, directory to where input object (raw data) is saved
#' 
#' @param col_v vector, hex colors for the three types of model_types
#' 
#' @param pch_v vector, pch values for the three types of model_types
#' 
process <- function(input_file, col_model_type, pch_model_type){
  
  # Prepare the data for plotting
  readr::read_csv(input_file, col_types = 'iccd') %>%
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
  

}


