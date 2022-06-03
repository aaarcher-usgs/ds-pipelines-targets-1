#' # Define write_csv_fcn() function
#' 
#' @description The `write_csv_fcn()` saves a copy of the processed data in csv format.
#' 
#' @param input_data data.frame, input object (processed data)
#' 
#' @param output_file chr, file path of the subfolder where processed data will be saved 
#' 
write_csv_fcn <- function(input_data, output_file){
  
  # Save the processed data as .csv
  write.csv(input_data, file = file.path(output_file))
  
  return(output_file)
}


