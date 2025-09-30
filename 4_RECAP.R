library(shiny)

# Define UI ----
ui <- page_sidebar(
  title = "censusVis",  # App title
  
  # Sidebar with widgets
  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    # Select box widget
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
    # Slider widget
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0,
      max = 100,
      value = c(0, 100)
    )
  ),
  
  # Main panel with two reactive text outputs
  textOutput("selected_var"),   # First reactive line
  textOutput("selected_range")  # Second reactive line
)

# Define server logic ----
server <- function(input, output) {
  
  # First reactive text: shows which variable was selected
  output$selected_var <- renderText({
    paste("You have selected:", input$var)
  })
  
  # Second reactive text: shows the min and max values of the slider
  output$selected_range <- renderText({
    paste(
      "You have chosen a range that goes from",
      input$range[1], "to", input$range[2]
    )
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
