library("lintr")
intro_panel <- mainPanel(
  includeCSS("finalScripts/universal_style.css"),
  h1(strong("Study on World Income Per Capita")), br(),
  h3(strong("What is the study about?")),
  p("Are the richest countries the ones that produce the most CO2? Are they the
    most educated? Are they the ones with the least unemployment? With a set
    of data from WorldBank, we conducted a study on how a country's income
    per capita might relate to its ", em(strong("CO2 emissions per capita,")),
    em(strong("employment to population ratio,")), "and the ",
    em(strong("population in primary/secondary education systems."))
    ),
  br(),
  h3(strong("How did we conduct the study?")),
  p("We established three guiding questions (one for each topic) and answered
    the questions with different kinds of graphs.",
    br(), br(),
    strong("(1)"),
    "How does employment to population ratio vary by income brackets in each
    region?",
    br(),
    strong("(2)"),
    "Is there a correlation between a country's CO2 emissions produced and
    income per capita?",
    br(),
    strong("(3)"),
    "Is there a correlation between a country's current population in
    primary/secondary schools and income per capita?",
    br(), br(),
    "The interactive graphs and the insights can be found on the next
    few pages."),
  br(), br(),
  img(src = paste0("https://fintechnews.sg/wp-content/uploads/2018/12/",
  "Remittance-Statistics-Worldbank-1-1440x564_c.png"),
      width = "864px",
      height = "338px"),
  br(), br(),
  h2(strong("Sources")),
  p(a(href = paste0("https://fintechnews.sg/wp-content/uploads/2018/12/",
  "Remittance-Statistics-Worldbank-1-1440x564_c.png"), "WorldBank Image"),
    br(),
    a(href = "https://databank.worldbank.org/source/
      world-development-indicators/Type/TABLE/preview/on#",
      "World Income Indicator Dataset")
   )
)

overview <- tabPanel(
  "Overview",
  intro_panel
)
