#' # Define diagnostic_log() function
#' 
#' @description The `diagnostic_log()` function creates a text file of model diagnostic results.
#' 
#' @param input_data data.frame, input object (processed data)
#' 
#' @param output_file chr, file path where the final diagnostic log will be saved
#' 
#' @param model_type chr vector, list of model types by IDs 
#' 
#' @param exper_num numerical vector, list of experimental temperatures (numerical)
#'
diagnostic_log <- function(input_data, output_file, model_type, exper_num){
  
  # Save the model diagnostics
  render_data <- NULL
  
  for(mm in 1:length(model_type)){ #for each model type
    for(ee in 1:length(exper_num)){ # and each exper id 
      
      # filter data based on model type and exper id
      filterdata <- input_data[input_data$model_type == model_type[mm] & 
                                 input_data$n_prof == exper_num[ee],]
      
      # calculate mean RMSE and store in list
      templist <- list(filterdata %>% pull(rmse) %>% mean %>% round(2))
      names(templist) <- paste0(model_type[mm], "_", exper_num[ee], "mean")
      render_data <- append(x = render_data, values = templist)
      }
  }
  
  template_1 <- 'Modeling resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
  The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
  ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
  The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '
  
  whisker.render(template_1 %>% 
                   str_remove_all('\n') %>% 
                   str_replace_all('  ', ' '), render_data ) %>% 
    cat(file = file.path(output_file))
  
  return(output_file)
}

