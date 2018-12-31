pacman::p_load(dplyr, tidyr, purrr, readr, stringr, lubridate, ggplot2)

# Indlæs beløbsgrænser
beloebsgraense <- as.data.frame(
                              matrix(c(2016, 50600, 
                              2017, 51700), ncol=2, byrow=TRUE)
                              )
colnames(beloebsgraense) <- c("aar", "graense")                   
beloebsgraense <- as.character(beloebsgraense)

# Indl?s transaktionsdata
data <- read.table("transaktionsfil.csv", sep=";", dec=",", header=T, stringsAsFactors = F)

data$?r <- format(parse_date_time(data$Val?rdag, orders="Ymd", tz="UTC"), "%Y")

# Opg?relse af udbytter
udbytteData <- data[which(data$Transaktionstype=="UDB."), ]

udbytteData$Bel?b <- gsub(udbytteData$Bel?b, pattern='[.]', replacement='')
udbytteData$Bel?b <- gsub(udbytteData$Bel?b, pattern='[,]', replacement='.')
udbytteData$Bel?b <- as.numeric(udbytteData$Bel?b)

udbytter <- aggregate(udbytteData$Bel?b, by=list(Category=udbytteData$?r), FUN=sum)
colnames(udbytter) <- c("?r", "udbytter")                   

# Opg?relse af avancer
avanceData <- data[which(data$Transaktionstype %in% c("INDL?SNING OVERF. VP", "SOLGT")), ]

avanceData$Resultat <- gsub(avanceData$Resultat, pattern='[.]', replacement='')
avanceData$Resultat <- gsub(avanceData$Resultat, pattern='[,]', replacement='.')
avanceData$Resultat <- as.numeric(avanceData$Resultat)

avancer <- aggregate(avanceData$Resultat, by=list(Category=avanceData$?r), FUN=sum)
colnames(avancer) <- c("?r", "avancer")

# Opg?relse af handelsomkostninger
data$Afgifter <- gsub(data$Afgifter, pattern='[.]', replacement='')
data$Afgifter <- gsub(data$Afgifter, pattern='[,]', replacement='.')
data$Afgifter <- as.numeric(data$Afgifter)

afgifter <- aggregate(data$Afgifter, by=list(Category=data$?r), FUN=sum)
colnames(afgifter) <- c("?r", "afgifter")

# Sammenstilling af ?rsresultat
?rsopg?relse <- list(avancer, udbytter, afgifter, bel?bsgr?nse) %>%  Reduce(function(dtf1,dtf2) left_join(dtf1, dtf2, by="?r"), .)
?rsopg?relse$aktieindkomst <- rowSums(?rsopg?relse[, c(2:3)])
?rsopg?relse$omkostningsprocent <- ?rsopg?relse$afgifter/?rsopg?relse$aktieindkomst*100





