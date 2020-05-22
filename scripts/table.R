library("dplyr")

make_table <- function(data) {
  data[, 5:11] <- suppressWarnings(sapply(data[, 5:11], as.numeric))
  # Aggregate table data
  table_data <- data %>%
    select(
      year, country, income_pc, population, pupils_pri_educ,
      pupils_sec_educ, epr_female, epr_male, co2_emissions
    ) %>%
    group_by(country) %>%
    summarise(
      Average_Income = mean(income_pc, na.rm = T),
      Average_Population = mean(population, na.rm = T),
      Average_Primary_Students = mean(pupils_pri_educ, na.rm = T),
      Average_Secondary_Students = mean(pupils_sec_educ, na.rm = T),
      Average_Female_Employment = mean(epr_female, na.rm = T),
      Average_Male_Employment = mean(epr_male, na.rm = T),
      Average_CO2_Emissions = mean(co2_emissions, na.rm = T)
    ) %>%
    arrange(-Average_Income)
  # Rename columns
  names(table_data) <- c(
    "Country", "Average Income (Current USD)",
    "Average Population", "Average Primary Students",
    "Average Secondary Students",
    "Average Female Employment (Employment:Population (female age 15+))",
    "Average Male Employment (Employment:Population (male age 15+))",
    "Average CO2 Emissions (Metric tons per capita)"
  )
  # Converting the table dataframe into characters
  # in order to concatenate it with the units dataframe.
  return(table_data)
}
