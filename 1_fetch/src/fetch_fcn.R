#' # Define fetch() function
#' 
#' @description The `fetch()` function downloads the raw data from ScienceBase based on defined
#' ScienceBase ID (argument `sb_id`) and saves it as a .csv in the appropriate out/ directory
#' (argument `out_file`)
#' 
#' @param sb_id chr, ScienceBase ID
#' 
#' @param out_file chr, file path of the subfolder where raw data will be saved 
#' 
fetch <- function(sb_id, out_file){
  # Get the data from ScienceBase
  rawdata_file <- file.path(out_file)
  sbtools::item_file_download(sb_id, names = 'me_RMSE.csv', 
                              destinations = rawdata_file, overwrite_file = TRUE)
}




