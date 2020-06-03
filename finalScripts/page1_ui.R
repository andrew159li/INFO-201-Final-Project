library(lintr)
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
  p("This graph allows us to distinguish any patterns between
    employment to population ratio and the income brackets
    of the 7 regions of the world. We will be able to visualize
    the differences between male and female employment to
    population ratios in specific regions, as well as where
    they stand in comparison to one another in terms of
    their respective income brackets."),
  h2(strong("Key Takeaways:")),
  p("- The lowest income bracket consists of countries from all
    7 regions of the world; this indicates that economic success
    is not a geographical determination",
  br(),
  "- Male employment to population ratio is consistently higher
  than female to employment to population ratio each year",
  br(),
  "- Lower-income brackets generally have higher employment to
  population ratios, meaning that more people are employed, but
  those individuals have lower incomes than individuals from
  higher-income bracket countries")
)

page1 <- tabPanel(
  "Income vs Employment to Population Ratio",
  sidebarLayout(
    side_panel,
    main_panel
  )
)
