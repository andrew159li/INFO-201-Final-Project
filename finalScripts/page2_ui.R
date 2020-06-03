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
  selected = c(caribbean[, ])
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
                        h2(strong("What does this question
                                  help us understand?")),
                        p("This chart shows the relationship between
                          a country's income generation and their CO2
                          emissions. In general, as income increases,
                          CO2 emissions increase as well."),
                        h2(strong("Key Takeaways:")),
                        p("- CO2 emissions generally rise with each year",
                          br(),
                          "- Trinidad & Tobago has high low income but
                          high CO2 emissions, contrary to trend line",
                          br(),
                          "- France has relatively high income but low
                          CO2 emissions contrary to trend line",
                          br(),
                          "- It is possible for countries to increase
                          their income per capita without leaving a large
                          carbon footprint of CO2 emissions"))
# Page 2 UI Variable
page2 <- tabPanel(
  "Income vs CO2 Emissions",
  sidebarLayout(
    sidebar_panel,
    main_panel
  )
)
