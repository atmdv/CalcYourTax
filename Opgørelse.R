pacman::p_load(dplyr, tidyr, purrr, readr, stringr, lubridate, ggplot2)

setwd("C:/Users/atm/Google Drive/Aktier")

# Indlæs beløbsgrænser
beløbsgrænse <- as.data.frame(
                              matrix(c(2016, 50600, 
                              2017, 51700), ncol=2, byrow=TRUE)
                              )
colnames(beløbsgrænse) <- c("år", "grænse")                   
beløbsgrænse$år <- as.character(beløbsgrænse$år)

# Indlæs transaktionsdata
data <- read.table("transaktionsfil.csv", sep=";", dec=",", header=T, stringsAsFactors = F)

data$år <- format(parse_date_time(data$Valørdag, orders="Ymd", tz="UTC"), "%Y")

# Opgørelse af udbytter
udbytteData <- data[which(data$Transaktionstype=="UDB."), ]

udbytteData$Beløb <- gsub(udbytteData$Beløb, pattern='[.]', replacement='')
udbytteData$Beløb <- gsub(udbytteData$Beløb, pattern='[,]', replacement='.')
udbytteData$Beløb <- as.numeric(udbytteData$Beløb)

udbytter <- aggregate(udbytteData$Beløb, by=list(Category=udbytteData$år), FUN=sum)
colnames(udbytter) <- c("år", "udbytter")                   

# Opgørelse af avancer
avanceData <- data[which(data$Transaktionstype %in% c("INDLØSNING OVERF. VP", "SOLGT")), ]

avanceData$Resultat <- gsub(avanceData$Resultat, pattern='[.]', replacement='')
avanceData$Resultat <- gsub(avanceData$Resultat, pattern='[,]', replacement='.')
avanceData$Resultat <- as.numeric(avanceData$Resultat)

avancer <- aggregate(avanceData$Resultat, by=list(Category=avanceData$år), FUN=sum)
colnames(avancer) <- c("år", "avancer")

# Opgørelse af handelsomkostninger
data$Afgifter <- gsub(data$Afgifter, pattern='[.]', replacement='')
data$Afgifter <- gsub(data$Afgifter, pattern='[,]', replacement='.')
data$Afgifter <- as.numeric(data$Afgifter)

afgifter <- aggregate(data$Afgifter, by=list(Category=data$år), FUN=sum)
colnames(afgifter) <- c("år", "afgifter")

# Sammenstilling af årsresultat
årsopgørelse <- list(avancer, udbytter, afgifter, beløbsgrænse) %>%  Reduce(function(dtf1,dtf2) left_join(dtf1, dtf2, by="år"), .)
årsopgørelse$aktieindkomst <- rowSums(årsopgørelse[, c(2:3)])
årsopgørelse$omkostningsprocent <- årsopgørelse$afgifter/årsopgørelse$aktieindkomst*100





