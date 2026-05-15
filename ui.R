library(shinydashboard)
library(shiny)

ui <- dashboardPage(
  skin="green",
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Stats", tabName = "stats", icon = icon("dashboard")),
      menuItem("Graphiques", tabName = "graphiques", icon = icon("th"))
    ),
    sliderInput("slider", "Nb individus", 1, 87, 87),
    selectInput(
      "select",
      "Color for distribution:",
      choices = list("hair_color" = "hair_color", "eye_color" = "eye_color", "skin_color" = "skin_color"),
      selected = 1
    )
  ),
  
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "stats",
              fluidRow(
                valueBoxOutput("valueBox1"),
                valueBoxOutput("valueBox2"),
                valueBoxOutput("valueBox3"),
                infoBoxOutput("infoBox1"),
                infoBoxOutput("infoBox2")
              )
      ),
      
      # Second tab content
      tabItem(tabName = "graphiques",
              fluidRow(
                plotlyOutput("graphique1"),
                plotlyOutput("graphique2")
              )
      )
    )
  )
)