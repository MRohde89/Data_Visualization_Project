
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(dplyr)
library(caret)
library(e1071)
# library(rattle)
data("mtcars")

shinyServer(function(input, output) {

  output$plotted <- renderPlot( {
        qplot(data = subset(mtcars, cyl == input$cyl & 
                              wt >= input$wt[1] &
                              wt <= input$wt[2]), 
              x = mpg, 
              y = am,
              xlab = "Miles Per Gallon", 
              ylab = "Transmission 0 = automatic, 1 = manual")
  })
  
  data <- reactive({
    modified <- names(mtcars) %in% c(input$params,"am")
    #mtcars_pred <- 
    mtcars[,modified]
  })
  
#   output$lm <- renderPlot({
#     model <- train(am ~ ., data = data(), method = "rpart")
#     fancyRpartPlot(model$finalModel)
#   })
  
  output$accuracy <- renderTable({
    model <- train(am ~ ., data = data(), method = "rpart")
    predictions <- predict(model, mtcars[,-9])
    conf_matrix <- confusionMatrix(round(predictions), mtcars$am)
    conf_matrix$table
  })
  output$matrix <- renderText("Confusion Matrix")

})



