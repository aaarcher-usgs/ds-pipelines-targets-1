fetch <- function(sb_id){
  # Define where the output will go
  project_output_dir <- '1_fetch/out'
  
  # Get the data from ScienceBase
  mendota_file <- file.path(project_output_dir, 'model_RMSEs.csv')
  sbtools::item_file_download(sb_id, names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
  
  # Return mendota_file
  #assign(x = "mendota_file", value = mendota_file, envir = .GlobalEnv)
}




