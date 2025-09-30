library(shiny)
library(bslib)

# Define UI ----
ui <- page_sidebar(
  title = "My first UI",  # App title at the top
  
  sidebar = sidebar("This is the sidebar"),  # Sidebar panel
  
  # Value box to highlight an important number
  value_box(
    title = "Active users",
    value = 128,
    showcase = bsicons::bs_icon("people"), # Add an icon
    theme = "teal"                         # Box color theme
  ),
  
  # First card with a header and body text
  card(
    card_header("General Summary"),
    "This card shows some general information."
  ),
  
  # Second card with another section of content
  card(
    card_header("Details"),
    "This card contains more detailed information."
  )
)

# Define server logic ----
server <- function(input, output) {
  # No server-side logic needed for this lesson
}

# Run the app ----
shinyApp(ui = ui, server = server)
