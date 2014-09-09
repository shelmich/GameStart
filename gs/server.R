library(shiny)
source("helpers.R")

shinyServer(function(input, output){
  
  output$collection <- renderTable({
    input$userchange
    out <- NULL
    isolate({
      out <- get.userinfo(input$username)
    })
    
    out
    
  })
})