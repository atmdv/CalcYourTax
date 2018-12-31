pacman::p_load(dplyr, tidyr, purrr, readr, stringr, lubridate, ggplot2)

# Import transaction data
data <- read.table("transaktionsfil.csv", sep=";", dec=",", header=T, stringsAsFactors = F)
data$year <- format(parse_date_time(data$Valørdag, orders="Ymd", tz="UTC"), "%Y")
data$country <- ifelse(data$Vekslingskurs==1, "Denmark", "Abroad")

# Calculate profits by year
data$Resultat <- sub(".", "", data$Resultat, fixed = TRUE)
data$Resultat <- sub(",", ".", data$Resultat, fixed = TRUE)
data$Resultat <- as.numeric(data$Resultat)
profits <- data %>%
  group_by(year) %>% 
  filter(Transaktionstype=="SOLGT") %>% 
  summarise(profit=sum(Resultat))

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
data$Beløb <- sub(".", "", data$Beløb, fixed = TRUE)
data$Beløb <- sub(",", ".", data$Beløb, fixed = TRUE)
data$Beløb <- as.numeric(data$Beløb)
dividends <- data %>%
  filter(Transaktionstype=="UDB.") %>% 
  left_join(withheld, by=c("year", "country")) %>% 
  mutate(tax_income=Beløb/(1-rate)) %>% 
  group_by(year) %>% 
  summarise(dividend=sum(tax_income))

# Tax brackets
brackets <- data.frame(matrix(ncol=2, nrow=0))
colnames(brackets) <- c("year", "bracket")
brackets[1, ] <- c("2016", 50600)
brackets[2, ] <- c("2017", 51700)
brackets[3, ] <- c("2018", 52900)
brackets[4, ] <- c("2019", 54000)
brackets$bracket <- as.numeric(brackets$bracket)

# Calculate taxable income by year
tax_income <- profits %>% 
  left_join(dividends, by="year") %>%
  mutate(tax_income=profit+dividend) %>% 
  left_join(brackets, by="year") %>% 
  mutate(optimize=ifelse(tax_income>bracket, "Harvest Losses", "Realize Gains"),
         amount=abs(tax_income-bracket))

print(tax_income)  









