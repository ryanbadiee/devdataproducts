#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #Define min and max urban pop to be selected
    urbanmin <- reactive({as.numeric(input$slidermin[1])})
    urbanmax <- reactive({as.numeric(input$slidermax[1])})
    
    #Subset data table by urban parameters
    library(dplyr)
    states <- reactive({
        subset(USArrests, UrbanPop %in% (urbanmin():urbanmax()))
    })
    
    #Generate models based on this selection
    mmodel <- reactive({lm(Murder~UrbanPop, data=states())})
    amodel <- reactive({lm(Assault~UrbanPop, data=states())})
    rmodel <- reactive({lm(Rape~UrbanPop, data=states())})
    
    
    #Generate plots
    output$mplot <- renderPlot({
        plot(states()$UrbanPop, states()$Murder,
             xlab="% Urban Population within State",
             ylab="Murders per 100,000 Residents",
             xlim=c(0,100), pch=16)
        text(Murder~UrbanPop, labels=rownames(states()),data=states(), pos=1, cex=0.9)
        abline(mmodel(), col="blue", lwd = 2)
    })
    output$aplot <- renderPlot({
        plot(states()$UrbanPop, states()$Assault,
             xlab="% Urban Population within State",
             ylab="Assaults per 100,000 Residents",
             xlim=c(0,100), pch=16)
        text(Assault~UrbanPop, labels=rownames(states()),data=states(), pos=1, cex=0.9)
        abline(amodel(), col="blue", lwd = 2)
    })
    output$rplot <- renderPlot({
        plot(states()$UrbanPop, states()$Rape,
             xlab="% Urban Population within State",
             ylab="Rapes per 100,000 Residents",
             xlim=c(0,100), pch=16)
        text(Rape~UrbanPop, labels=rownames(states()),data=states(), pos=1, cex=0.9)
        abline(rmodel(), col="blue", lwd = 2)
    })

})
