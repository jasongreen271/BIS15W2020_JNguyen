if (!require("tidyverse")) install.packages('tidyverse')
library("tidyverse")
if (!require("shiny")) install.packages('shiny')
library("shiny")
if (!require("shinydashboard")) install.packages('shinydashboard')
library("shinydashboard")

UC_admit <- readr::read_csv("data/UC_admit.csv")

UC_admit$Academic_Yr <- as.factor(UC_admit$Academic_Yr)

ui <- dashboardPage(
  dashboardHeader(title = "UC Admissions by Academic Year"),
  dashboardSidebar(),
  dashboardBody(
    selectInput("fill", "Select variable", choices = c("Campus", "Category", "Ethnicity"), 
                selected = "Campus"),
    plotOutput("plot", width = "900px", height = "600px"))
)

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    ggplot(UC_admit, aes_string(x = "Academic_Yr", y="FilteredCountFR", fill=input$fill)) + 
      geom_col(position = "dodge") + theme_light(base_size = 18) +
      coord_flip() +
      labs(y="Count")
  })
  
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)