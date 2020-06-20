
library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    avg_means <- reactive({
        set.seed(input$Seed) 
        avg_means <- NULL
        for (i in 1:input$Simulations) 
            {
            avg_means <- c(avg_means, mean(rexp(input$n,input$Lambda)))
            }
        avg_means
        })
    
    inf_stat <- reactive({
    
            sample_mean <- mean(avg_means())
            sample_std  <- sd(avg_means())
            sample_var  <- sample_std^2
            
            theo_mean   <- 1/(input$Lambda)
            theo_std    <- (1/input$Lambda)/(sqrt(input$n))
            theo_var    <- theo_std^2
            
            summary <- rbind(c("Sample",round(sample_mean,2),round(sample_var,2)),c("Theoretical",round(theo_mean,2),round(theo_var,2)))
            colnames(summary) <- c("Distribution","Mean","Variance")
            #rownames(summary) <- c("Simulation","Theoretical")
            summary
        
    })
    
    
    output$distPlot <- renderPlot({

        sample_mean <- mean(avg_means())
        sample_std  <- sd(avg_means())
        sample_var  <- sample_std^2
        theo_mean   <- 1/input$Lambda
        theo_std    <- 1/input$Lambda/sqrt(input$n)
        theo_var    <- theo_std^2
        
        sample_plot <- ggplot(data.frame(avg_means()),aes(x=avg_means())) +  geom_histogram(binwidth = 0.1,colour="black",fill="salmon",aes(y = ..density..))
        sample_plot <- sample_plot + geom_density(aes(colour="blue"),size=1)+labs(x="Average Means Values",y="Density")
        sample_plot <- sample_plot + geom_vline(xintercept = sample_mean, size=1, colour="blue")
        theo_plot <- sample_plot + stat_function(fun = dnorm, args = list(mean = 1/input$Lambda, sd=1/input$Lambda/sqrt(input$n)), aes(colour="red"),size=1,linetype=1)
        theo_plot <- theo_plot  + geom_vline(xintercept = theo_mean, size=1, colour="red") +  scale_color_identity(name = "Distributions",
                                                                                                                   breaks = c("blue", "red"),
                                                                                                                   labels = c("Sample", "Theoretical"),
                                                                                                                   guide = "legend")
        
        theo_plot

    })
    output$MeanComp <- renderTable({inf_stat()})

    

})

