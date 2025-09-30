library(shiny)
library(quantmod)

# Load helper functions
source("helpers.R")  # contains adjust() function

# Define UI ----
ui <- page_sidebar(
  title = "stockVis",
  
  sidebar = sidebar(
    helpText("Select a stock to examine. Information will be collected from Yahoo finance."),
    
    textInput("symb", "Symbol", "SPY"),  # Stock ticker
    
    dateRangeInput("dates", 
                   "Date range",
                   start = "2013-01-01", 
                   end   = as.character(Sys.Date())),
    
    checkboxInput("log", "Plot y axis on the log scale", FALSE),
    checkboxInput("adjust", "Adjust prices for inflation", FALSE)
  ),
  
  card(plotOutput("plot"))
)

# Define server logic ----
server <- function(input, output) {
  
  # Reactive expression to fetch stock data (runs only when symbol or dates change)
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to   = input$dates[2],
               auto.assign = FALSE)
  })
  
  # Reactive expression to adjust or not adjust prices
  finalData <- reactive({
    if (input$adjust) {
      adjust(dataInput())
    } else {
      dataInput()
    }
  })
  
  # Render plot using finalData()
  output$plot <- renderPlot({
    chartSeries(finalData(),
                theme = chartTheme("white"),
                type = "line",
                log.scale = input$log,
                TA = NULL)
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
