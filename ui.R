
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Monthly Stock Prices"),

  # Sidebar with selection of stocks
  sidebarLayout(
    sidebarPanel(
            selectInput("Stock", "Select Stock:", 
                        list(
                                'Apple Inc.'='AAPL',
                                'IBM'='IBM',
                                'BlackBerry Limited' = 'BBRY',
                                'Google Inc.' = 'GOOG',
                                'Facebook, Inc.' = 'FB'
                        ), 
                        multiple = FALSE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
            h3(textOutput("Stock")),
            htmlOutput("gvis")
    )
  )
))
