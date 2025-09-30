# app.R
library(shiny)
library(bslib)

# 1) UI: define the interfaz
ui <- page_sidebar(
  title = "Hello World!",           
  sidebar = sidebar(
    sliderInput(
      inputId = "bins",
      label   = "Number of bins:",
      min     = 5,                  
      max     = 50,
      value   = 30
    )
  ),
  plotOutput(outputId = "distPlot")
)

# 2) SERVER: lógic app
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(
      x,
      breaks = bins,
      col    = "white",
      border = "orange",            
      xlab   = "Waiting time to next eruption (in mins)",
      main   = "Histogram of waiting times"
    )
  })
}

# 3) run
shinyApp(ui = ui, server = server)

