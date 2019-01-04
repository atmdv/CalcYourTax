
calcyourprofits <- function(x){
  
  # Calculate profits by year
  consolidated_portfolio <- x
  profits <- consolidated_portfolio %>%
    group_by(year) %>% 
    filter(transaction_type=="SOLGT") %>% 
    summarise(profit=sum(result))

  return(profits)
  
}
