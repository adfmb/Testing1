library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Importance Sampling"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("m",
                  "Lambda de funcion original:",
                  min = 0,
                  max = 5,
                  value=.5
      ),
      
      sliderInput("nsim",
                  "Numero de simulaciones:",
                  min = 1,
                  max = 10000,
                  value = 1000
      ),
      sliderInput("lambda_g",
                  "Lambda de funcion g:",
                  min = 0,
                  max = 5,
                  value = 1
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tableOutput(("values")
                  #,
      #tabsetPanel(type = "tabs", 
       #           tabPanel("Integral 1")
    #)
  )
))
))