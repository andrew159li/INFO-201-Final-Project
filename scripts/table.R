library("dplyr")
library("lintr")

make_table <- function(data) {
  data[, 5:11] <- suppressWarnings(sapply(data[, 5:11], as.numeric))
  data[is.na(data)] <- 0
  # Aggregate table data
  table_data <- data %>%
    select(
      year, country, income_pc, population, pupils_pri_educ,
      pupils_sec_educ, epr_female, epr_male, co2_emissions
    ) %>%
    group_by(country) %>%
    summarise(
      Average_Income = round(mean(income_pc, na.rm = T), 1),
      Average_Population = round(mean(population, na.rm = T), 1),
      Average_Primary_Students = round(mean(pupils_pri_educ, na.rm = T), 1),
      Average_Secondary_Students = round(mean(pupils_sec_educ, na.rm = T), 1),
      Average_Female_Employment = round(mean(epr_female, na.rm = T), 2),
      Average_Male_Employment = round(mean(epr_male, na.rm = T), 2),
      Average_CO2_Emissions = round(mean(co2_emissions, na.rm = T), 2)
    ) %>%
    arrange(-Average_Income)
  # Rename columns
  names(table_data) <- c(
    "Country", "Avg. Income (current USD)",
    "Avg. Population", "Avg. Primary Students",
    "Avg. Secondary Students",
    "Avg. Female Employment to Population Ratio (age 15+)",
    "Avg. Male Employment to Population Ratio (age 15+)",
    "Avg. CO2 Emissions (metric tons per capita)"
  )
  # Converting the table dataframe into characters
  # in order to concatenate it with the units dataframe.
  return(table_data)
}
