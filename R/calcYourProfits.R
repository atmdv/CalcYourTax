
calcyourprofits <- function(x){
  
  # Calculate profits by year
  nordnet <- x
  nordnet$Resultat <- sub(".", "", nordnet$Resultat, fixed = TRUE)
  nordnet$Resultat <- sub(",", ".", nordnet$Resultat, fixed = TRUE)
  nordnet$Resultat <- as.numeric(nordnet$Resultat)
  profits <- nordnet %>%
    group_by(year) %>% 
    filter(Transaktionstype=="SOLGT") %>% 
    summarise(profit=sum(Resultat))

  return(profits)
  
}