# percent_map function to draw choropleth maps of US counties
percent_map <- function(var, color, legend.title, max = 100, min = 0) {
  # Check that var is numeric
  if(!is.numeric(var)) {
    stop("percent_map: var must be numeric")
  }
  
  # Replace missing values with NA
  var[is.na(var)] <- 0
  
  # Constrain var values to be within min and max
  var[var < min] <- min
  var[var > max] <- max
  
  # Create a color palette
  shades <- colorRampPalette(c("white", color))(100)
  
  # Map var values to palette
  percents <- as.integer(cut(var, 100, include.lowest = TRUE))
  fills <- shades[percents]
  
  # Draw map
  map("county", fill = TRUE, col = fills, resolution = 0, lty = 0)
  map("state", add = TRUE, lty = 1, lwd = 0.5)
  
  # Add legend
  legend("bottomleft",
         legend = c(paste(min, "%"), paste(max, "%")),
         fill = c("white", color),
         title = legend.title,
         cex = 0.8)
}
