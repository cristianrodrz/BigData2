library(shiny)

# Define UI ----
ui <- page_fluid(
  titlePanel("Widgets Demo"),  # App title
  
  # Select box
  selectInput(
    inputId = "select",
    label = "Choose an option:",
    choices = c("Choice 1", "Choice 2", "Choice 3"),
    selected = "Choice 1"
  ),
  
  # Numeric input
  numericInput(
    inputId = "num",
    label = "Enter a number:",
    value = 10
  ),
  
  # Slider input
  sliderInput(
    inputId = "slider",
    label = "Select a value:",
    min = 0,
    max = 100,
    value = 50
  )
)

# Define server logic ----
server <- function(input, output) {
  # No server-side logic for this lesson
}

# Run the app ----
shinyApp(ui = ui, server = server)
