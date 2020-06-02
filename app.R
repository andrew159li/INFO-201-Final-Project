library(shiny)
library(knitr)
library(ggplot2)
library(plotly)
library(tidyr)
library(htmltools)

#PUT COMMENTS ON EVERYTHING BC ITS ON THE RUBRIC

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)