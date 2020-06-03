library(lintr)
summary_panel <- mainPanel(
  h1(strong("Summary")),
  h3("How does", strong("employment to population ratio"), "vary by income
     brackets in each region?"),
  br(),
  imageOutput("chart1"),
  br(), br(),
  p("A noticeable trend we saw was that across all genders and years, the top
    10% income bracket are always only occupied by the regions Europe, North &
    Central America, and Oceania. The other regions, Africa, Asia,
    South America, and The Caribbean, are always in either the lowest 10% or
    10%-50% income brackets. This is shown by the majority of said regions
    residing under the 50% income brackets in the graph. Another interesting
    trend is that in general lower income brackets have higher employment to
    population ratios, indicating that more people are employed, but individuals
    make less income than those in the individuals in higher income bracket
    countries. This may be because many people in poorer areas have to take
    on multiple low-income jobs in order to support their families."),
  br(),
  h3("Is there a correlation between a country's",
     strong("CO2 emissions"), "produced and income per capita?"),
  br(),
  imageOutput("chart2"),
  br(), br(),
  p("Generally, there seems to be a consistent trend that countries with higher
    incomes have higher CO2 emissions. However, there are exceptions to this.
    For example, Trinidad & Tobago has incredibly high CO2 emissions but has a
    relatively low income per capita. On the other hand, France has a very high
    income per capita but has maintained relatively low CO2 emissions. As seen
    from this data exploration, there appears to be a positive correlation
    between a country's CO2 emissions and their income per capita. As income
    per capita increases, so do CO2 emissions. Therefore, we can infer that
    the rise in CO2 emissions may be due to industrialization and the emergence
    of a new or improved economy that reels in greater income. For example, with
    a new manufacturing economy, the resulting construction of more factories
    would lead to greater amounts of pollution, and thus the increase in CO2
    emissions. We have hope through analyzing this data that it is possible
    for industrializing and developing countries to one day increase their
    income per capita without having such significant emissions of CO2,
    through the handful of countries who have already begun to achieve this."),
  br(), br(),
  h3("Is there a correlation between a country's
         percent", strong("population in education"), "and income
         per capita?"),
  br(),
  imageOutput("chart3"),
  br(), br(),
  p("In this chart, it is notable that there is no clear correlation between
    having a comparatively higher income per capita and having a larger
    percent population in schools. While some countries have tended to have a
    larger percent population in school as well as a higher income per capita
    like Canada or Australia, some countries have shown a lower percentage of
    the population in education, but still with a large income per capita.
    Interestingly, the three countries which display this phenomenon most
    obviously are Germany, United Kingdom, and France; all three are from
    Europe. For example, in the year 2001, Germany has the 3rd highest income
    per capita out of all 35 countries, but the second lowest percent population
    in school of all 35 countries at 3.9%. This perhaps brings an interesting
    point: though education may be correlated with data about workforce, there
    may be too many other factors entwined with education (such as societal
    and cultural expectations which may reveal preferred trades and/or careers)
    which blur our ability to pick out a clear correlation or hypothesis.")
)

summary <- tabPanel(
  "Summary",
  summary_panel
)
