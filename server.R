#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tibble)
library(ggplot2)
library(dplyr)
library(shinydashboard)
library(plotly)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  df <- reactive({
    starwars %>% head(input$slider)
  })

  output$valueBox1 <- renderValueBox({
    valueBox("Box fixe", 42, icon = icon("bars"), color = "aqua")
  })
  
  output$valueBox2 <- renderValueBox({
    nb_individus = nrow(df())
    valueBox("Individus", nb_individus, icon = icon("list"), color="red")
  })
  
  output$valueBox3 <- renderValueBox({
    nb_dimensions <- ncol(df())
    valueBox("Dimensions", nb_dimensions, icon = icon("th-large"), color="yellow")
  })
  
  output$infoBox1 <- renderInfoBox({
    average_height <- mean(df()$height, na.rm = TRUE)
    infoBox("Average height", average_height, icon = icon("arrow-up"), color="purple")
  })
  
  output$infoBox2 <- renderInfoBox({
    average_mass <- mean(df()$mass, na.rm = TRUE)
    infoBox("Median mass (kg)", average_mass, icon = icon("weight-hanging"), color="black")
  })
  
  output$graphique1 <- renderPlotly({
    df_clean <- df() %>%
      filter(!is.na(mass), !is.na(height))
    p <- ggplot(df_clean, aes(x = mass, y = height, color = species)) + geom_point() + labs(title="Height & Mass correlation")
    ggplotly(p)
  })
  
  output$graphique2 <- renderPlotly({
    
    df_clean <- df() %>%
      filter(!is.na(.data[[input$select]]))
    
    p <- ggplot(df_clean, aes(x = .data[[input$select]])) +
      geom_bar() +
      labs(title = "Distribution")
    
    ggplotly(p)
  })

}
