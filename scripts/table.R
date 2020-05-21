library("dplyr")

data <- read.csv("../data/data.csv",
                 fileEncoding = "UTF-8-BOM",
                 stringsAsFactors = FALSE)
data[, 5:9] <- suppressWarnings(sapply(data[, 5:9], as.numeric))

# Aggregate table data
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

# Make a row(single-row dataframe containing units of each columns)
units <- data.frame(country = "Full country name",
                    Average_Income = "Current USD",
                    Averag_Education_Expenditure = 
                      "% of total expenditure in public institutions",
                    Average_Female_Employment = 
                      "Employment to population ratio, female of age 15+",
                    Average_Male_Employment = 
                      "Employment to population ratio, male of age 15+",
                    Average_CO2_Emissions = "Metric tons per capita")

# Converting the table dataframe into characters 
# in order to concatenate it with the units dataframe.
table_1991_2019[] <- lapply(table_1991_2019, as.character)

table_data <- bind_rows(units, table_1991_2019)  