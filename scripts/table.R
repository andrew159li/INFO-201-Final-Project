library("dplyr")

make_table <- function(data) {
  data[, 5:11] <- suppressWarnings(sapply(data[, 5:11], as.numeric))
  # Aggregate table data
  table_1991_2019 <- data %>%
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
  # Make a row(single-row dataframe containing units of each columns)
  units <- data.frame(
    country = "Full country name",
    Average_Income = "Current USD",
    Average_Population = "Number of people",
    Average_Primary_Students =
      "Number of students in primary education",
    Average_Secondary_Students =
      "Number of students in secondary education",
    Average_Female_Employment =
      "Employment to population ratio, female of age 15+",
    Average_Male_Employment =
      "Employment to population ratio, male of age 15+",
    Average_CO2_Emissions = "Metric tons per capita"
  )
  # Converting the table dataframe into characters
  # in order to concatenate it with the units dataframe.
  table_1991_2019[] <- lapply(table_1991_2019, as.character)
  table_data <- bind_rows(units, table_1991_2019)
  return(table_data)
}