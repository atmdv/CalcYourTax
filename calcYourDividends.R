
calcyourdividends <- function(x){
  
  # Withheld dividend tax
  withheld <- data.frame(matrix(ncol=3, nrow=0))
  colnames(withheld) <- c("country", "year", "rate")
  withheld[1, ] <- c("Denmark", "2016", 0.27)
  withheld[2, ] <- c("Denmark", "2017", 0.27)
  withheld[3, ] <- c("Denmark", "2018", 0.27)
  withheld[4, ] <- c("Abroad", "2016", 0.15)
  withheld[5, ] <- c("Abroad", "2017", 0.15)
  withheld[6, ] <- c("Abroad", "2018", 0.15)
  withheld$rate <- as.numeric(withheld$rate)
  
  # Calculate dividends by year
  nordnet <- x
  nordnet$Beløb <- sub(".", "", nordnet$Beløb, fixed = TRUE)
  nordnet$Beløb <- sub(",", ".", nordnet$Beløb, fixed = TRUE)
  nordnet$Beløb <- as.numeric(nordnet$Beløb)
  dividends <- nordnet %>%
    filter(Transaktionstype=="UDB.") %>% 
    left_join(withheld, by=c("year", "country")) %>% 
    mutate(tax_income=Beløb/(1-rate)) %>% 
    group_by(year) %>% 
    summarise(dividend=sum(tax_income))
  
  return(dividends)
  
}