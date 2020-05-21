# load necessary libraries
library("dplyr")
library("ggplot2")

# load in data
df <- read.csv("../data/data.csv",
  stringsAsFactors = FALSE,
  fileEncoding = "UTF-8-BOM"
)

# clean up data
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

# melt dataframe
df_melt <- gather(df_clean,
  key = "school_type",
  value = "population_perc", -country
)

# bar chart
population_school_country <- ggplot(data = df_melt) +
  geom_col(
    mapping = aes(x = country, y = population_perc, fill = school_type),
    position = "stack"
  ) +
  coord_flip() +
  ggtitle("Population in School per Country, Average 1991-2019") +
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