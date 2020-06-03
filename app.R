library(shiny)
library(knitr)
library(ggplot2)
library(plotly)
library(tidyr)
library(htmltools)
library(png)
library(lintr)

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
