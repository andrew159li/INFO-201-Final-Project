# load in packages
library(dplyr)
library(plotly)
library(tidyr)
library(shiny)
library(lintr)

# load in data
df <- read.csv("data/data.csv", stringsAsFactors = FALSE)
df[is.na(df)] <- 0

# make changes to data
df <- df %>%
  filter(population != 0) %>%
  mutate(
    primary_perc = pupils_pri_educ / population,
    secondary_perc = pupils_sec_educ / population,
    both_perc = (pupils_pri_educ + pupils_sec_educ) / population,
    year = as.numeric(ï..year)
  ) %>%
  select(year, country, income_pc, primary_perc,
         secondary_perc, both_perc, region) %>%
  group_by(year, region)

df_melt <- df %>%
  gather(key = "edu_level",
         value = "percentage",
         -year, -country, -region, -income_pc)


# Widget to select year
year_input <- selectInput(
  "year",
  label = "Year to display",
  # 2018 because 2019 has no data for education
  choices = c(as.numeric(1991:2017)),
  selected = as.numeric(1991)
)

# Widget to select school
school_type <- c("Primary" = "primary_perc",
                 "Secondary" = "secondary_perc",
                 "Primary & Secondary" = "both_perc")

education_level_input <- radioButtons(
  "education",
  label = "Level of Education to display",
  choices = list(
    "Primary" = "primary_perc",
    "Secondary" = "secondary_perc",
    "Primary & Secondary" = "both_perc"
  )
)

# define ui
page3 <- tabPanel(
  "Income vs Percent Population in School",
    sidebarPanel(
      year_input,
      education_level_input
    ),
    mainPanel(
      h2(strong("Question: "),
         "Is there a correlation between a country's
         percent population in education and income
         per capita?"
         ),
      plotlyOutput(
        "edu_plot"
        ),
      h2(strong("Analysis:")),
      p("In this chart, it is notable that there is no
        clear correlation between having a comparatively
        higher income per capita and having a larger percent
        population in schools. While some countries have
        tended to have a larger percent population in
        school as well as a higher income per capita like
        Canada or Australia, some countries have shown
        a lower percentage of the population in education,
        but still with a large income per capita.
        Interestingly, the three countries which display
        this phenomenon most obviously are Germany,
        United Kingdom, and France; all three are from
        Europe. For example, in the year 2001, Germany has
        the 3rd highest income per capita out of all
        35 countries, but the second lowest percent
        population in school of all 35 countries at
        3.9%. This perhaps brings an interesting point:
        though education may be correlated with data about
        workforce, there may be too many other factors
        entwined with education (such as societal and
        cultural expectations which may reveal
        preferred trades and/or careers) which blur our
        ability to pick out a clear correlation or
        hypothesis.")
    )
  )
