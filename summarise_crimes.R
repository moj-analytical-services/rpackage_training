##This function filters on multiple years and summarises the crime data 

library(dplyr)

filter_crimes <- function(data_set, years) {
  
  data_set %>%
    filter(year %in% years) %>%
    summarise(crimes = sum(crimes))
  
}