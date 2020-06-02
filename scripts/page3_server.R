# load in packages
library(dplyr)
library(plotly)
library(shiny)
library(lintr)

# load in data
data <- read.csv("data/data.csv", stringsAsFactors = FALSE)
# define server
server <- function(input, output) {
  output$edu_plot <- renderPlotly({
    # additional filtering data to use in plot
    df_for_plot <- df_melt %>%
      filter(percentage != 0,
             income_pc != 0,
             year == input$year,
             edu_level == input$education)
    # build actual plot
    edu_plot <- plot_ly(
      data = df_for_plot,
      x = ~percentage,
      y = ~income_pc,
      type = "scatter",
      mode = "markers",
      hovertext = (df_for_plot$country),
      opacity = 0.5,
      color = ~region,
      size = 1
    ) %>%
      layout(
        title = paste("% Population in", names(school_type)
                      [school_type == input$education],
                      "School in", input$year),
        xaxis = list(title = "Percent population in school", range = c(0, 0.3)),
        yaxis = list(title = "Income per capita", range = c(0, 55000))
      )
  })
}