
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

        tags$head(
                tags$style(type='text/css', ".container-fluid { max-width: 1000px; }")
        ),
        # Application title
        h1("Historical Stock Prices"),

        # Sidebar with selection of stocks
        sidebarLayout(
                sidebarPanel(
                        p("Select a stock below to view historical pricing and volume."),
                        selectInput("Stock", "Select Stock:", 
                                list(
                                        'Apple Inc.'='AAPL',
                                        'IBM'='IBM',
                                        'BlackBerry Limited' = 'BBRY',
                                        'Google Inc.' = 'GOOG',
                                        'Facebook, Inc.' = 'FB'
                                ), 
                                multiple = FALSE),
                        p("Data is obtained from ", a("Yahoo! Finance", href="http://finance.yahoo.com/"))
                ),

                
                # Show a plot of the generated distribution
                mainPanel(
                        tags$head(
                                tags$style(type='text/css', ".col-sm-8 { max-width: 610px; }")
                        ),
                        p("Use zoom range selection area (the area at the bottom of the chart) to select a range of dates to view"),
                        h3(textOutput("Stock")),
                        htmlOutput("gvis")
                )
        )
))
