#' # Define write_csv_fcn() function
#' 
#' The `write_csv_fcn()` saves a copy of the processed data in csv format.
#' 
#' @param input_data chr, input object (raw data)
#' 
#' @param output_file chr, file path of the subfolder where processed data will be saved 
#' 
write_csv_fcn <- function(input_data, output_file){
  
  # Save the processed data as .csv
  output_file_dir <- file.path(output_file)
  write.csv(input_data, file = output_file_dir)
  
}


