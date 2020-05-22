library(dplyr)
library(lintr)

# Setting Up Data
data <- read.csv("../data/data.csv",
                 fileEncoding = "UTF-8-BOM",
                 stringsAsFactors = FALSE)
data[, 5:9] <- suppressWarnings(sapply(data[, 5:9], as.numeric))

# Extracting Data -- General & Top 3 WDI
general_info <- data %>%
  group_by(country) %>%
  summarize(num_years = n())

get_top_3 <- function(dataset, col) {
  col <- enquo(col)
  top_3_df <- dataset %>%
    group_by(country) %>%
    summarize(avg = mean(!!col, na.rm = TRUE)) %>%
    arrange(-avg) %>%
    top_n(3)
  return(top_3_df)
}

# Analysis Function
get_summary_info <- function(dataset) {
  info <- list()
  # total number of countries
  info$num_countries <- nrow(general_info)
  # span of years of the data
  info$num_years <- first(general_info$num_years)
  # highest avg co2 emissions (metric tons per capita) - country
  info$top_co2_country <- first(get_top_3(data, co2_emissions)$country)
  # highest avg female employment to population ratio - country
  info$top_epr_fem_country <- first(get_top_3(data, epr_female)$country)
  # highest avg male employment to population ratio - country
  info$top_epr_male_country <- first(get_top_3(data, epr_male)$country)
  # highest avg income per capita - country
  info$top_income_pc <- first(get_top_3(data, income_pc)$country)
  # highest avg primary education - country
  info$pri_edu <- first(get_top_3(data, pupils_pri_educ)$country)
  # highest avg secondary education - country
  info$sec_edu <- first(get_top_3(data, pupils_sec_educ)$country)
  return(info)
}
