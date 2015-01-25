
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
suppressPackageStartupMessages(library(googleVis))
require(shiny)

# initialize global variables
d <- as.Date(Sys.Date())
dStart <- d - 730; # 2 year interval slider for time range

# create function for getting stock data from Yahoo! Finance
stockData <- function(sym) {
        
        ## Get data from Yahoo! Finance
        fn <- sprintf('http://ichart.finance.yahoo.com/table.csv?s=%s&a=08&b=0&c=1984&d=12&e=31&f=%s&g=w&ignore=.csv',
                      sym, format(d, "%Y"))
        yd <- read.csv(fn, colClasses=c("Date", rep("numeric",6)))
        
        # format data for Google Charts
        xx <-reshape(yd[,c("Date", "Close", "Volume")], idvar="Date", 
                times=c("Close", "Volume"), 
                timevar="Type",
                varying=list(c("Close", "Volume")),
                v.names="Value",
                direction="long")
        return(xx)

}

shinyServer(function(input, output, session) {
         
        stockSymbol <- reactive({ input$Stock })
        
        output$Stock <- renderText({ paste("***", stockSymbol(), "***", sep=" ") })
        stocks <-reactive({ stockData(stockSymbol()) })

        output$gvis <- renderGvis({
               
                # disply message while data is loading 
                withProgress(message='Loading data', detail='...', value = 0, {    
                        stockData = stocks();
                })                
                gvisAnnotatedTimeLine(
                        stockData, datevar="Date",
                        numvar="Value", idvar="Type",
                        options=list(
                                colors="['blue', 'lightblue']",
                                zoomStartTime=dStart,
                                zoomEndTime=d,
                                legendPosition='newRow',
                                width=600, height=400, scaleColumns='[0,1]',
                                scaleType='allmaximized',
                                displayZoomButtons="FALSE")
                )
        })


})
