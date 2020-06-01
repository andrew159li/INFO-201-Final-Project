library(shiny)
library(ggplot2)
library(dplyr)

data <- read.csv("data/data.csv",
                 stringsAsFactors = FALSE,
                 fileEncoding = "UTF-8-BOM")
data[, 5:11] <- sapply(data[, 5:11], as.numeric)

server <- function(input, output) {
  output$plot2 <- renderPlotly({
    country_vector <- c(input$region1, input$region2, input$region3, 
                        input$region4, input$region5, input$region6, input$region7)
    page2_data <- data %>%
      filter(year == input$years &
               country %in% country_vector)
    
    scatterplot <- ggplot(page2_data) +
      geom_point(mapping = aes_string(x = "income_pc",
                                      y = "co2_emissions",
                                      color = "country",
                                      size = "income_pc",
                                      alpha = 0.5)) +
      labs(title = "CO2 Emissions vs. Income (1994 - 2014)",
           x = "Income (per capita)",
           y = "CO2 Emissions (metric tons per capita)") +
      guides(size = FALSE, alpha = FALSE) +
      theme(plot.title = element_text(hjust = 0.5))
    
    interactive <- ggplotly(scatterplot,
                            tooltip = c("country", "x", "y"))
    return(interactive)
  })
}
