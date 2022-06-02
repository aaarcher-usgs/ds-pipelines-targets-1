#' # Define line_range_plot() function
#' 
#' The `line_range_plot()` function creates a figure of model diagnostic results.
#' 
#' @param input_file chr, file path of the subfolder where processed data is saved
#' 
#' @param output_file chr, file path where the final figure will be saved
#' 
#' @param col_v vector, hex colors for the three types of model_types
#' 
#' @param pch_v vector, pch values for the three types of model_types
#'
line_range_plot <- function(input_file, output_file, col_v, pch_v){
  
  input_data <- read.csv(input_file)
  
  # Create a plot
  png(file = file.path(output_file), width = 8, height = 10, res = 200, units = 'in')
  par(omi = c(0,0,0.05,0.05), mai = c(1,1,0,0), las = 1, mgp = c(2,.5,0), cex = 1.5)
  
  plot(NA, NA, xlim = c(2, 1000), ylim = c(4.7, 0.75),
       ylab = "Test RMSE (°C)", xlab = "Training temperature profiles (#)", log = 'x', axes = FALSE)
  
  n_profs <- c(2, 10, 50, 100, 500, 980)
  
  axis(1, at = c(-100, n_profs, 1e10), labels = c("", n_profs, ""), tck = -0.01)
  axis(2, at = seq(0,10), las = 1, tck = -0.01)
  
  # slight horizontal offsets so the markers don't overlap:
  offsets <- data.frame(pgdl = c(0.15, 0.5, 3, 7, 20, 30)) %>%
    mutate(dl = -pgdl, pb = 0, n_prof = n_profs)
  
  for (mod in c('pb','dl','pgdl')){
    mod_data <- filter(input_data, model_type == mod)
    mod_profiles <- unique(mod_data$n_prof)
    for (mod_profile in mod_profiles){
      d <- filter(mod_data, n_prof == mod_profile) %>% summarize(y0 = min(rmse), y1 = max(rmse), col = unique(col))
      x_pos <- offsets %>% filter(n_prof == mod_profile) %>% pull(!!mod) + mod_profile
      lines(c(x_pos, x_pos), c(d$y0, d$y1), col = d$col, lwd = 2.5)
    }
    d <- group_by(mod_data, n_prof) %>% summarize(y = mean(rmse), col = unique(col), pch = unique(pch)) %>%
      rename(x = n_prof) %>% arrange(x)
    
    lines(d$x + tail(offsets[[mod]], nrow(d)), d$y, col = d$col[1], lty = 'dashed')
    points(d$x + tail(offsets[[mod]], nrow(d)), d$y, pch = d$pch[1], col = d$col[1], bg = 'white', lwd = 2.5, cex = 1.5)
    
  }
  
  points(2.2, 0.79, col = col_v[3], pch = pch_v[3], bg = 'white', lwd = 2.5, cex = 1.5)
  text(2.3, 0.80, 'Process-Guided Deep Learning', pos = 4, cex = 1.1)
  
  points(2.2, 0.94, col = col_v[2], pch = pch_v[2], bg = 'white', lwd = 2.5, cex = 1.5)
  text(2.3, 0.95, 'Deep Learning', pos = 4, cex = 1.1)
  
  points(2.2, 1.09, col = col_v[1], pch = pch_v[1], bg = 'white', lwd = 2.5, cex = 1.5)
  text(2.3, 1.1, 'Process-Based', pos = 4, cex = 1.1)
  
  dev.off()
  
  
}