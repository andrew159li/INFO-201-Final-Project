side_panel <- sidebarPanel(
  radioButtons(
    inputId = "gender",
    label = strong("Select gender:"),
    choices = list(
      "Female" = "epr_female", "Male" = "epr_male",
      "Average" = "epr_avg"
    )
  ),
  selectInput(
    inputId = "year",
    label = strong("Select year:"),
    choices = c(1991:2017)
  )
)

main_panel <- mainPanel(
  h2(strong("Question: "),
  "How does employment to population ratio vary by income ", 
  "brackets in each region?"),
  plotlyOutput(outputId = "plot1"),
  h2(strong("Analysis:")),
  p(paste0(
    "In this chart, a notable trend is that across all genders and years,",
    "the top 10% income bracket are always only occupied by the regions ",
    "Europe, North & Central America, and Oceania. The other regions, ",
    "Africa, Asia, South America, and The Caribean, are always in either ",
    "the lowest 10% or 10%-50% income brackets. ",
    "Another interesting trend is that in general lower income brackets ",
    "have higher employment to population ratios, indicating that ",
    "more people are employed, but individuals make less income than those ",
    "in the individuals in higher income bracket countries. ",
    "It is also worth pointing out that the number of countries in the ",
    "lowest 10% income bracket always has the most countries, compared to ",
    "the top 10% income bracket which consistently only has one or two ",
    "countries. ",
    "Lastly, the difference between male and female employment to population ",
    "ratios have largely stayed the same."
  ))
)

page1 <- tabPanel(
  "Income vs Employment to Population Ratio",
  sidebarLayout(
    side_panel,
    main_panel
  )
)
