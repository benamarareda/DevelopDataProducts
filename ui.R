library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    titlePanel("Developing Data Products : Course Project"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("Lambda",
                        "Lambda for Exponential Distribution",
                        min = 0.1,
                        max = 1,
                        value = 0.2),
            numericInput("n",
                        "Sample Size",
                        min = 0,
                        max = 1000,
                        value = 40),
            sliderInput("Simulations",
                       "Number of Simulations",
                       min = 1,
                       max = 5000,
                       value = 1000),
            numericInput("Seed",
                         "Set the Seed",
                         min = 1,
                         max = 9999,
                         value = 3450),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4("This App investigate the exponential distribution using the Central Limit Theorem."), 
            h4("Set the Lambda parameter for the Exponential distribution, then choose the sample size (n)."),
            h4("The app generate a vector of size = number of simulations, of the average of rexp(n,lambda)."),
            h4("The seed parameter is for results reproducibility."),
            h4("The table compares the Mean/Variance of the sample vs theoritical Mean/Variance respectively 1/Lambda and 1/Lambda/Sqrt(n)."),
            tableOutput ("MeanComp"),
            h4("As the number of simulation increases, the sample distribution get very close to the theoretical distribution."),
            plotOutput("distPlot"),
            h4("As stated by Central Limit Theorem, distribution of averages of iid variables becomes standard normal as the sample size increases.")
        
        )
    )
))
