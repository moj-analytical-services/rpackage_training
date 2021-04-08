#' @title The five most recent published registers.
#'
#' @description The \code{fivereg_recent} function expects the
#'  \code{year_phase_data} and outputs a character string.
#'
#'
#' @details The registers are sorted by publication date and name by
#'  alphabetical order. The top five registers are output as a character string
#'  including commas and an and, for inclusion in the report.
#'
#' @param x Input object of \code{year_phase_data} class.
#' @param n The \code{n} passed to \code{head}.
#'
#' @return Returns a character string of the five most recent registers.
#'
#' @examples
#'
#' library(regregrap)
#' report_data <- phase_date_data(regreg)
#' fivereg_recent(report_data)
#'
#' @importFrom dplyr %>%
#'
#' @export
#'

fivereg_recent <- function(x, n = 5) {
  # take the df slot and sort by published data
  # and then alphabetical order (they may tie on dates)
  out <- tryCatch(
    expr = {
      #####
      # make it easier to work with
      df <- x$df
      
      # we are suspicious, run checks
      stopifnot(is.data.frame(df))
      
      # correct variables?
      stopifnot(is.character(df$register))
      stopifnot(lubridate::is.POSIXct(df$date))
      
      # arrange from dplyr,
      # descending order for dates, ascending reg name
      # no longer need underscore with dplyr verbs used programmatically
      dplyr::arrange(df, desc(date), register) %>%
        dplyr::select(-phase) %>%
        tibble::as_tibble() -> sorted_list
      
      # take top n names
      df_n <- head(sorted_list$register, n)
      
      # make human readable list
      output <- paste(df_n, collapse = ", ")
      # make last comma "and"
      
      return(output)
      
      #####
    },
    warning = function() {
      
      w <- warnings()
      warning('Warning produced running fivereg_recent():', w)
      
    },
    error = function(e)  {
      
      stop('Error produced running fivereg_recent():', e)
      
    },
    finally = {}
  )
  
}