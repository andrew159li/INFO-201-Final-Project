library(lintr)

# Source Files
source("finalScripts/overview_ui.R")
source("finalScripts/page1_ui.R")
source("finalScripts/page2_ui.R")
source("finalScripts/page3_ui.R")
source("finalScripts/summary_ui.R")

ui <- navbarPage(
  # Title
  "Study on World Income Per Capita",

  # Introduction Tab
  overview,

  # Page 1
  page1,

  # Page 2
  page2,

  # Page 3
  page3,

  # Summary Tab
  summary
)
