library(shiny)
library(maps)      # For map shapes
library(mapproj)   # For map projections

# Load helper functions and data (runs once when app starts)
source("helpers.R")                      # Loads percent_map()
counties <- readRDS("data/counties.rds") # Load dataset

# Define UI ----
ui <- page_sidebar(
  title = "censusVis",
  
  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    
    # Select variable to display
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices = c(
        "Percent White",
        "Percent Black",
        "Percent Hispanic",
        "Percent Asian"
      ),
      selected = "Percent White"
    ),
    
    # Select range
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0,
      max = 100,
      value = c(0, 100)
    )
  ),
  
  # Main panel with map
  card(
    plotOutput("map")
  )
)

# Define server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    
    # Select the data column depending on input$var
    data <- switch(input$var,
                   "Percent White"    = counties$white,
                   "Percent Black"    = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian"    = counties$asian)
    
    # Pick a color for the map depending on variable
    color <- switch(input$var,
                    "Percent White"    = "darkgreen",
                    "Percent Black"    = "black",
                    "Percent Hispanic" = "darkorange",
                    "Percent Asian"    = "darkviolet")
    
    # Call helper function to draw the map
    percent_map(
      var = data,
      color = color,
      legend.title = input$var,
      max = input$range[2],
      min = input$range[1]
    )
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
