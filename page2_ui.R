library(shiny)
library(ggplot2)
library(dplyr)
library(lintr)

# Setting Up Data
df <- read.csv("data/data.csv",
               stringsAsFactors = FALSE,
               fileEncoding = "UTF-8-BOM")
df[, 5:11] <- sapply(df[, 5:11], as.numeric)

# Filtering Data
data <- df %>%
  filter(year, year >= "1994" & year <= "2014") %>%
  select(year, country, income_pc, co2_emissions, region)

# Widget 1 - Drop Down for Years
year_inputs <- unique(data$year)

select_year <- selectInput(
  inputId = "years",
  label = "Select Year",
  choices = year_inputs,
  selected = year_inputs[1]
)

# Widget 2 - Check Boxes for Regions
w2_data <- data %>%
  select(country, region)

get_countries <- function(data, reg) {
  countries <- w2_data %>%
    filter(reg == region) %>%
    select(country) %>%
    unique()
  return(countries)
}

africa <- get_countries(w2_data, "Africa")
asia <- get_countries(w2_data, "Asia")
caribbean <- get_countries(w2_data, "The Caribbean")
northcentral <- get_countries(w2_data, "North & Central America")
southamerica <- get_countries(w2_data, "South America")
oceania <- get_countries(w2_data, "Oceania")
europe <- get_countries(w2_data, "Europe")

select_africa <- checkboxGroupInput(
  inputId = "region1",
  label = "Africa",
  choices = c(africa[, ]),
  selected = c(africa[, ])
)

select_asia <- checkboxGroupInput(
  inputId = "region2",
  label = "Asia",
  choices = c(asia[, ]),
)

select_caribbean <- checkboxGroupInput(
  inputId = "region3",
  label = "The Caribbean",
  choices = c(caribbean[, ]),
)

select_northcentral <- checkboxGroupInput(
  inputId = "region4",
  label = "North & Central America",
  choices = c(northcentral[, ]),
)

select_southamerica <- checkboxGroupInput(
  inputId = "region5",
  label = "South America",
  choices = c(southamerica[, ]),
)

select_oceania <- checkboxGroupInput(
  inputId = "region6",
  label = "Oceania",
  choices = c(oceania[, ]),
)

select_europe <- checkboxGroupInput(
  inputId = "region7",
  label = "Europe",
  choices = c(europe[, ]),
)

# Page 2 Content & Layout
sidebar_panel <- sidebarPanel(select_year,
                              select_africa,
                              select_asia,
                             select_caribbean,
                             select_northcentral,
                             select_southamerica,
                             select_oceania,
                             select_europe)

main_panel <- mainPanel(h2(strong("Question: "),
                           "Is there a correlation between ",
                           "a country's CO2 emissions produced ",
                           "and income per capita?"),
                        plotlyOutput("plot2"),
                        h2(strong("Analysis: ")),
                        p("Generally, there seems to be a consistent ",
                          "trend that countries with higher incomes ",
                          "have higher CO2 emissions. However, there are ",
                          "exceptions to this. For example, Trinidad & Tobago ",
                          "has incredibly high CO2 emissions but has a ",
                          "relatively low income per capita. On the other ",
                          "hand, France has a very high income per capita ",
                          "but has maintained relatively low CO2 emissions. ",
                          "As seen from this data exploration, there ",
                          "appears to be a positive correlation between ",
                          "a country's CO2 emissions and their income per ",
                          "capita. As income per capita increases, so do CO2 ",
                          "emissions. Therefore, we can infer that the rise ",
                          "in CO2 emissions may be due to industrialization ",
                          "and the emergence of a new or improved economy ",
                          "that reels in greater income. For example, with ",
                          "a new manufacturing economy, the resulting ",
                          "construction of more factories would lead to ",
                          "greater amounts of pollution, and thus the ",
                          "increase in CO2 emissions. We have hope through ",
                          "analyzing this data that it is possible for ",
                          "industrializing and developing countries to ",
                          "one day increase their income per capita without ",
                          "having such significant emissions of CO2, through ",
                          "the handful of countries who have already ",
                          "begun to achieve this."))

page2 <- tabPanel(
  "Income & CO2 Emissions",
  sidebarLayout(
    sidebar_panel,
    main_panel
  )
)
