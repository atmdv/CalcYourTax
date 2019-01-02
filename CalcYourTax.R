
calcyourtax <- function(x){

  # Import transaction data
  nordnet <- read.table(nordnet, sep=";", dec=",",
                        header=T, stringsAsFactors = F)
  nordnet$year <- format(parse_date_time(nordnet$Valørdag,
                                         orders="Ymd", tz="UTC"), "%Y")
  nordnet$country <- ifelse(nordnet$Vekslingskurs==1, "Denmark", "Abroad")
  
  # Calculate profits
  source("calcYourProfits.R", encoding="utf-8")
  profits <- calcyourprofits(nordnet)
  
  # Calculate dividends
  source("calcYourDividends.R", encoding="utf-8")
  dividends <- calcyourdividends(nordnet)
  
  # Tax brackets
  bracket_limits <- data.frame(matrix(ncol=2, nrow=0))
  colnames(bracket_limits) <- c("year", "bracket_limit")
  bracket_limits[1, ] <- c("2016", 50600)
  bracket_limits[2, ] <- c("2017", 51700)
  bracket_limits[3, ] <- c("2018", 52900)
  bracket_limits[4, ] <- c("2019", 54000)
  bracket_limits$bracket_limit <- as.numeric(bracket_limits$bracket_limit)
  
  # Calculate taxable income by year
  tax_income <- profits %>% 
    left_join(dividends, by="year") %>%
    mutate(tax_income=profit+dividend) %>% 
    left_join(bracket_limits, by="year") %>% 
    mutate(how_to_optimize=ifelse(tax_income>bracket_limit,
                                  "Harvest Losses", "Realize Gains"),
           amount=abs(tax_income-bracket_limit))
  
    return(tax_income)
  
}










