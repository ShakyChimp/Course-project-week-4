
library(shiny)


shinyUI(fluidPage(
  titlePanel("Will you survive the trip with the Titanic?"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("name", "What is your name?", value = ""),
       selectInput("klasse", "With which class do you want to travel?", c("1ste" = 1, "2de" = 2, "3de" = 3)),
       sliderInput("Age", "What is your age?", min = 0, max = 100, value = 25),
       selectInput("Sex", "What is your sex?", c("Male" = "male", "Female" = "female")),
       selectInput("Embarked", "Where would you like to embarke?", c("Cherbourg" = "C", "Queenstown" = "Q", "Southampton" = "S")),
       submitButton("Submit")
    ),
    
    mainPanel(
       textOutput("selected"),
       h2("Would you survive the trip with the Titanic?"),
       h1(textOutput("predict")),
       h3("Your change on survival is:"),
       textOutput("predict2"),
       h3("Your change of not making it to the USA is:"),
       textOutput("predict3")
    )
  )
))
