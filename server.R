
library(shiny)
library(titanic)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  titanictrain <- titanic_train
  titanictrain$Survived <- as.factor(titanictrain$Survived)
  titanictrain$Sex <- as.factor(titanictrain$Sex)
  titanictrain$Embarked <- as.factor(titanictrain$Embarked)
  titanictrain$Pclass <- as.factor(titanictrain$Pclass)
  modellm <- glm(Survived ~ Sex + Embarked + Pclass + Age, data = titanictrain, family = "binomial")
  
  modellmpredict <- reactive({
    klasseimput <- input$klasse
    ageimput <- input$Age
    seximput <- input$Sex
    embarkedimput <- input$Embarked
    
  predict(modellm, newdata = data.frame(Sex = seximput, Embarked = embarkedimput, Pclass = klasseimput, Age = ageimput), type = "response")
    
  })
  
  output$selected <- renderText({
    paste("Welcome", ifelse(input$Sex == "male", "Mr/Mrs", "Ms/Miss"), input$name,
          
          "on board of the Titanic! You're travelling from",
          if(input$Embarked == "C") { print("Cherbourg.")}, if(input$Embarked == "S") { print("Southampton.")},
          if(input$Embarked == "Q") { print("Queenstown.")}," You have bought a",if(input$klasse == 1) { print("1st Class")},
          if(input$klasse == 2) { print("2nd Class")}, if(input$klasse == 3) { print("3th Class")}, "ticket to the USA.",  " The most important question
          on this trip is if you will survive the journey across the Atlantic. You can see the results here below. Enjoy your (maybe not so pleasant) 
          stay on board of the Titanic!"
          
          )
  })
   
  output$predict <- renderText({
    ifelse(modellmpredict()<0.5, "No :(", "Yes!")
  })
  
  output$predict2 <- renderText({
    paste(round(modellmpredict()*100, 1), "%")
  })
  output$predict3 <- renderText({
    paste(round(100-modellmpredict()*100, 1), "%")
  })
})
