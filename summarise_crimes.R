##This function filters on multiple years and provides the mean crimes per year

library(dplyr)

summarise_crimes <- function(data_set, years) {
  
  filtered <- filter(data_set, year %in% years)
  summarise(filtered, crimes = mean(crimes))
  
}
