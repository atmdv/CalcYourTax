pacman::p_load(dplyr, tidyr, purrr, readr, stringr, lubridate, ggplot2, quantmod, Quandl)

setwd("C:/Users/atm/Google Drive/Aktier")

# Indlæs transaktionsdata
data <- read.table("transaktionsfil.csv", sep=";", dec=",", header=T, stringsAsFactors = F)
data$år <- format(parse_date_time(data$Valørdag, orders="Ymd", tz="UTC"), "%Y")

# Yahoo finance API
portefoeljeliste <- paste(data$Værdipapirer, collapse=";")

kurser <- getQuote(portefoeljeliste, src="yahoo")

