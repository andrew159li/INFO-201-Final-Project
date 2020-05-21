library("dplyr")

data <- read.csv("../data/data.csv",
                 fileEncoding = "UTF-8-BOM",
                 stringsAsFactors = FALSE)
data[, 5:9] <- suppressWarnings(sapply(data[, 5:9], as.numeric))

table_1991_2019 <- data %>%
  select(year, country, income_pc, edu_spending, 
         epr_female, epr_male, co2_emissions) %>%
  group_by(country) %>%
  summarise(Average_Income = mean(income_pc, na.rm = T),
            Average_Education_Expediture = mean(edu_spending, na.rm = T),
            Average_Female_Employment = mean(epr_female, na.rm = T),
            Average_Male_Employment = mean(epr_male, na.rm = T),
            Average_CO2_Emissions = mean(co2_emissions, na.rm = T)) %>%
  arrange(-Average_Income)
  


