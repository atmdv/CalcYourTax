
calcyourtax <- function(nordnet=NULL, degiro=NULL){

  pacman::p_load(dplyr, tidyr, purrr, readr, stringr, lubridate, kableExtra)
  
  if(!is.null(nordnet)){
    # Import Nordnet transaction data
    nordnet <- read.table(nordnet, sep=";", dec=",",
                          header=T, stringsAsFactors = F)
    nordnet <- nordnet[, c("Valørdag", "Transaktionstype", "ISIN", "Resultat", "Vekslingskurs", "Beløb")]
    nordnet$Resultat <- sub(".", "", nordnet$Resultat, fixed = TRUE)
    nordnet$Resultat <- sub(",", ".", nordnet$Resultat, fixed = TRUE)
    nordnet$Resultat <- as.numeric(nordnet$Resultat)
    nordnet$year <- format(parse_date_time(nordnet$Valørdag,
                                           orders="Ymd", tz="UTC"), "%Y")
    nordnet$country <- ifelse(nordnet$Vekslingskurs==1, "DK", "Other")
    names(nordnet) <- c("value_date", "transaction_type", "ISIN", "result",
                        "exchange_rate", "amount", "year", "country")
  }
  
  if(!is.null(degiro)){
    # Import DeGiro transaction data
    degiro <- read.table(degiro, sep=",", dec=",", header=TRUE, encoding="UTF-8")
    degiro <- degiro[, c("Valør.dato", "Beskrivelse", "ISIN", "X", "FX")]
    degiro$amount <- 0
    degiro$year <- format(parse_date_time(degiro$Valør.dato,
                                          orders="dmY", tz="UTC"), "%Y")
    degiro$country <- ifelse(degiro$FX==1, "DK", "Other")
    names(degiro) <- c("value_date", "transaction_type", "ISIN", "result",
                       "exchange_rate", "amount", "year", "country")
  }

  consolidated_portfolio <- rbind(nordnet, degiro)
  consolidated_portfolio$country <- ifelse(consolidated_portfolio$country=="Other" &
                              substr(consolidated_portfolio$ISIN, start = 1, stop = 2)=="DE",
                            "DE", consolidated_portfolio$country)
  consolidated_portfolio$country <- ifelse(consolidated_portfolio$country=="Other" &
                              substr(consolidated_portfolio$ISIN, start = 1, stop = 2)=="NO",
                            "NO", consolidated_portfolio$country)
    
  # Calculate profits
  profits <- calcyourprofits(consolidated_portfolio)

  # Calculate dividends
  dividends <- calcyourdividends(consolidated_portfolio)

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







