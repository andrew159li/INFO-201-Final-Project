# load necessary libraries
library("dplyr")
library("ggplot2")
library("tidyr")
library("lintr")

# clean up data
chart1 <- function(df) {
  df[, 5:11] <- suppressWarnings(sapply(df[, 5:11], as.numeric))
  df[is.na(df)] <- 0
  df_clean <- df %>%
    mutate(
      primary_perc = pupils_pri_educ / population,
      secondary_perc = pupils_sec_educ / population
    ) %>%
    select(country, primary_perc, secondary_perc) %>%
    group_by(country) %>%
    summarise(
      avg_primary = mean(primary_perc, na.rm = TRUE),
      avg_secondary = mean(secondary_perc, na.rm = TRUE)
    )
  # order bars
  df2 <- df_clean
  df2$country <- factor(df2$country,
      levels = unique(df2$country[order(df2$avg_secondary + df2$avg_primary)]))
  # melt dataframe
  df_melt <- gather(df2,
    key = "school_type",
    value = "population_perc", -country
  )

  # create bar chart
  pop_school_country_plot <- ggplot(data = df_melt) +
    geom_col(
      mapping = aes(x = country, y = population_perc, fill = school_type),
      position = "stack"
    ) +
    coord_flip() +
    ggtitle("Avg. Population in School per Country, 1991-2019") +
    theme(plot.title = element_text(hjust = 0.5)) +
    xlab("Country") +
    ylab("% Population in School") +
    scale_fill_discrete(
      name = "Type of School",
      labels = c("Primary School", "Secondary School")
    ) +
    scale_y_continuous(
      labels = scales::percent_format(accuracy = 1),
      limits = c(0, 0.3)
    )

  interactive_chart <- ggplotly(pop_school_country_plot = ggplot2::last_plot())
  return(interactive_chart)
}
