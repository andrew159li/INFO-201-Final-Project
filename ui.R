library("shiny")

# Source Files
source("page2_ui.R")

ui <- navbarPage(
  # Title
  "TITLE HERE",
  
  # Introduction Tab
  tabPanel("Introduction", mainPanel(uiOutput("introduction"))),
  
  # Page 2
  page2
)
  
  