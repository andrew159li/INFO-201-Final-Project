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
    inputId = "year1",
    label = strong("Select year:"),
    choices = c(1991:2017)
  )
)

main_panel <- mainPanel(
  h2(strong("Question: "),
  "How does employment to population ratio vary by income ", 
  "brackets in each region?"),
  plotlyOutput(outputId = "plot1"),
  h2(strong("What does this question help us understand?")),
  p(paste0(
    "This graph will allow us to see any patterns of how employment to
    population ratio varies by income brackets in each region.
    We want to see if there are any differences between male and
    female employment to population ratio in specific regions,
    and where they stand in comparison to each other in terms of
    their income brackets."
  ))
)

page1 <- tabPanel(
  "Income vs Employment to Population Ratio",
  sidebarLayout(
    side_panel,
    main_panel
  )
)
