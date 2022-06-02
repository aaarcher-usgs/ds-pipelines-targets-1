#' # Define fetch() function
#' 
#' The `fetch()` function downloads the raw data from ScienceBase based on defined
#' ScienceBase ID (argument `sb_id`) and saves it as a .csv in the appropriate out/ directory
#' (argument `out_dir`)
#' 
#' @param sb_id chr, ScienceBase ID
#' 
#' @param out_dir chr, file path of the subfolder where raw data will be saved 
#' 
fetch <- function(sb_id, out_dir){
  # Get the data from ScienceBase
  mendota_file <- file.path(out_dir, 'model_RMSEs.csv')
  sbtools::item_file_download(sb_id, names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
}




