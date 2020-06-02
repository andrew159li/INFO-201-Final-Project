library("shiny")

# Source Files
source("page1_ui.R")
source("page2_ui.R")
source("page3_ui.R")

ui <- navbarPage(
  # Title
  "TITLE HERE",

  # Introduction Tab
  tabPanel("Introduction", mainPanel(uiOutput("introduction"))),

  # Page 1
  page1,

  # Page 2
  page2
)
