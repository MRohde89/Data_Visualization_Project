
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


# What i will do: 
# Show modified (range) graphs for the fuel consumption
# Prediction of the transmission based on the input parameters


library(shiny)
data("mtcars")
library(e1071)


shinyUI(fluidPage(

  # Application title
  
  titlePanel("MTCARS FUEL CONSUMPTION AND TRANSMISSION PREDICTION"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("cyl",
                  "Cylinders",
                  min = 4,
                  max = 8,
                  value = c(4,8),
                  step = 2),
      sliderInput("wt",
                  "weight",
                  min = min(mtcars$wt),
                  max = max(mtcars$wt),
                  value = c(min(mtcars$wt), max(mtcars$wt))
      ),
      checkboxGroupInput("params",
                   "Prediction Parameters",
                   choices = c(names(mtcars[-9])),
                   selected = "qsec"
    )),
    mainPanel(
      ({"This Application takes the mtcars Dataset and does a graph based on your input.
             In Additions you can change the parameters for a prediction of of the Transmission. (Algorithm is rpart)
        It will produce an FanyRPlot and also a Confusion Matrix for your Input Parameters. 
        (unfortunatly Shiny isn't able to use Rattle so this was taken out in the uploaded code, it is still inside, but commented so you can use it on your PC)
        Nevertheless it will include the subsetting of the Cylinder nor the weight.
        This is just an example so there is no claims of accuracy for the model as well as for the used method"}),
      plotOutput("plotted"),
#       plotOutput("lm"),
      textOutput("matrix"),
      tableOutput("accuracy")

    )
  )
))
