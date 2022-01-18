#### Week 6: Make a shiny app. -- Daphne Weemering (3239480)

# Link: https://daphne-weemering.shinyapps.io/markup_language_and_reproducible_programming/?_ga=2.66046248.726005115.1642515579-590807768.1642515579

library(shiny)
library(rcompanion)

ui <- fluidPage(
  
  # Add a title 
  titlePanel("Effect of mean, standard deviation and sample size on normal distribution"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: slider for the sample size
      sliderInput(inputId = "n", label = "Choose a sample size", value = 50, min = 1, max = 500),
      
      # Input: slider for the mean 
      sliderInput(inputId = "mu", label = "Choose a value for the mean", value = 0, min = 0, max = 25),
      
      # Input: slider for the standard deviation
      sliderInput(inputId = "sd", label = "Choose a value for the standard deviation", value = 1, min = 1, max = 25)
      ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Density
      plotOutput(outputId = "dens")
    )
  )
)

server <- function(input, output){
  output$dens <- renderPlot({plotNormalHistogram(rnorm(n = input$n, mean = input$mu, sd = input$sd), 
                                                 prob = F, main = "Normal distribution", length = input$n, 
                                                 linecol = "red")})
}

shinyApp(ui = ui, server = server)









