# helpers.R
library(quantmod)

adjust <- function(prices) {
  # Download CPI data from Federal Reserve
  cpi <- getSymbols("CPIAUCSL", src = "FRED", auto.assign = FALSE)
  
  # Scale CPI to last value
  ratio <- cpi / as.numeric(last(cpi))
  
  # Apply adjustment to prices
  prices * ratio
}
