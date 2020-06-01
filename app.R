library(shiny)
library(knitr)

#PUT COMMENTS ON EVERYTHING HERE BC ITS ON THE RUBRIC
# Creation of UI using navbarPage
# Comma after every end of line except the last statement
# Will split into seperate UI and server files once everything is finished, easier to debug this way
ui <- navbarPage(
  
  # App title
  "TITLE HERE",
  
  tabPanel("Introduction", mainPanel(uiOutput("introduction"))),
  
  tabPanel("Chart 1", sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")),
      
    )
  ), 
    
  tabPanel("Chart 2", mainPanel(uiOutput("klj")))
  #tabPanel("Chart 3", mainPanel(uiOutput("introduction"))),
  #tabPanel("Map", mainPanel(uiOutput("introduction"))),
  #tabPanel("Summary", mainPanel(uiOutput("summary")))
  )


server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  
  output$introduction <- renderUI({
    HTML(markdown::markdownToHTML(knit('introduction.Rmd', quiet = TRUE)))
  })
  
  output$chart1 <-renderUI({
    HTML(markdown::markdownToHTML(knit('introduction.Rmd', quiet = TRUE)))
  })
  
}


shinyApp(ui = ui, server = server)


