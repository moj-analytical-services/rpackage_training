# This function produces a plot of the number of crimes per year
plot_crimes <- function(data_set, x, y, ...) {
  
  # Produce the plot
  plot <- data_set %>%
    ggplot2::ggplot(ggplot2::aes_string(x, y)) + 
    ggplot2::geom_bar(stat='identity')
  
  return(plot)
  
}