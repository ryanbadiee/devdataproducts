#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Crimes by Urban Population"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h3("Choose which states to include based on their urban population."),
            sliderInput("slidermin",
                        "What is the minimum % Urban Population you would like to include?",
                        min = 32,
                        max = 91,
                        value = 32),
            sliderInput("slidermax",
                        "What is the maximum % Urban Population you would like to include?",
                        min = 32,
                        max = 91,
                        value = 91)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h2("App Purpose:"),
            h4("This app plots different crimes (murders, assault, and rape) 
               against the urban population of a given state. Using the sliders
               on the left, choose what % urban population you want to include.
               Then, you can see the plots and their regression lines change. 
               It's impressive how much the regression line can change based on
               our data selection!"),
            h3("Murder Arrests by State"),
            plotOutput("mplot"),
            
            h3("Assault Arrests by State"),
            plotOutput("aplot"),

            h3("Rape Arrests by State"),
            plotOutput("rplot")
        )
    )
))
