
calcyourdividends <- function(x){
  
  # Withheld dividend tax
  withheld <- data.frame(matrix(ncol=3, nrow=0))
  colnames(withheld) <- c("country", "year", "rate")
  withheld[1, ] <- c("DK", "2016", 0.27)
  withheld[2, ] <- c("DK", "2017", 0.27)
  withheld[3, ] <- c("DK", "2018", 0.27)
  withheld[4, ] <- c("DK", "2019", 0.27)
  withheld[5, ] <- c("NO", "2016", 0.15)
  withheld[6, ] <- c("NO", "2017", 0.15)
  withheld[7, ] <- c("NO", "2018", 0.15)
  withheld[8, ] <- c("NO", "2019", 0.25)
  withheld[9, ] <- c("DE", "2016", 0.26375)
  withheld[10, ] <- c("DE", "2017", 0.26375)
  withheld[11, ] <- c("DE", "2018", 0.26375)
  withheld[12, ] <- c("DE", "2019", 0.26375)
  withheld[13, ] <- c("Other", "2016", 0.15)
  withheld[14, ] <- c("Other", "2017", 0.15)
  withheld[15, ] <- c("Other", "2018", 0.15)
  withheld[16, ] <- c("Other", "2019", 0.15)
  withheld$rate <- as.numeric(withheld$rate)
  
  # Calculate dividends by year
  consolidated_portfolio <- x
  consolidated_portfolio$amount <- sub(".", "", consolidated_portfolio$amount, fixed = TRUE)
  consolidated_portfolio$amount <- sub(",", ".", consolidated_portfolio$amount, fixed = TRUE)
  consolidated_portfolio$amount <- as.numeric(consolidated_portfolio$amount)
  dividends <- consolidated_portfolio %>%
    filter(transaction_type=="UDB.") %>% 
    left_join(withheld, by=c("year", "country")) %>% 
    mutate(tax_income=amount/(1-rate)) %>% 
    group_by(year) %>% 
    summarise(dividend=sum(tax_income))
  
  return(dividends)
  
}
