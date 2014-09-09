library(shiny)

shinyUI(
  fluidPage(
    titlePanel("GameStart"),
    column(width = 3,
           wellPanel(
             fluidRow(
               textInput("username", "Username:", value = "Mmmmtoasty"),
               actionButton("userchange", "Change User")
             )
           )
    ),
    column(width = 9,
           tabsetPanel(
             tabPanel("User Collection",
                      tableOutput("collection")
                      ),
             tabPanel("Game Recommendations")
             )
           )
  )
)
