library(dplyr)
library(plotly)
library(tidyr)
library(lintr)
library(styler)

df <- read.csv("../data/data.csv",
                 fileEncoding = "UTF-8-BOM",
                 stringsAsFactors = FALSE)

chart2 <- function(df) {
  epr_co2_df <- df %>%
    mutate(avg_epr = rowMeans(select(df, epr_female, epr_male),
                              na.rm = TRUE)) %>%
    filter(co2_emissions != "..") %>%
    mutate(co2_emissions_num = as.numeric(co2_emissions)) %>%
    select(country, co2_emissions_num, avg_epr) %>%
    drop_na()
  epr_co2 <- ggplot(data = epr_co2_df, aes(label = country)) +
    geom_point(mapping = aes(x = avg_epr, y = co2_emissions_num), alpha = 0.3) +
    labs(
      title = "Employment to Population Ratio vs CO2 Emissions per Capita",
      x = "Employment to Population Ratio (avg of male and female)",
      y = "CO2 Emissions per Capita (metric tons)"
    )
  epr_co2_interactive <- ggplotly(epr_co2)
  return(epr_co2_interactive)
}
