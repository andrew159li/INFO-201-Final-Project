library("shiny")

#read in data

shinyUI(navbarPage(
  
  #Title
  "TITLE HERE",
  
  #Introduction Tab
  tabPanel("Introduction", mainPanel(uiOutput("introduction"))),
  
  ))