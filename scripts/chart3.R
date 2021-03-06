library(dplyr)
library(ggplot2)
library(plotly)
library(lintr)

chart3 <- function(df) {
  # Setting Up Data
  df[, 5:11] <- suppressWarnings(sapply(df[, 5:11], as.numeric))

  # Chart Data
  plot_df <- df %>%
    filter(year == "1992" | year == "2014") %>%
    select(year, country, co2_emissions) %>%
    group_by(country) %>%
    mutate(co2_growth_rate =
             (co2_emissions[year == "2014"] - co2_emissions[year == "1992"]) /
             co2_emissions[year == "1992"] * 100) %>%
    mutate(co2_growth_rate = round(co2_growth_rate, 2)) %>%
    arrange(-co2_growth_rate)

  df2 <- plot_df
  df2$country <- factor(df2$country,
                      levels = unique(df2$country[order(df2$co2_growth_rate)]))

  # Chart
  chart <- ggplot(df2, aes(x = country,
                                y = co2_growth_rate,
                                fill = country)) +
    geom_bar(stat = "identity") +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(title = "CO2 Emission Growth Rates by Country from 1992 - 2014",
         x = "Country",
         y = "CO2 Emission Growth Rate (%)",
         fill = "Countries") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          axis.text.y = element_text(hjust = 1))

  interactive_chart <- ggplotly(chart = ggplot2::last_plot(),
                                tooltip = "co2_growth_rate")
  return(interactive_chart)
}
