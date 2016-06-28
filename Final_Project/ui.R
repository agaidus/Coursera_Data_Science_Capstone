library(shiny)

shinyUI(fluidPage(
  
    titlePanel("Next Word Prediction"),
  
    sidebarLayout(
        sidebarPanel(
            textInput("obs", "Your Phrase:"),
            
            helpText("Enter your phrase here and the program will predict your the most likely next words"),
            
            submitButton("Predict!")
        ),
      
      mainPanel(

          h4("Cleaned Phrase:"),
          textOutput("trans"),
          br(),
          h4("First Guess:"),
          textOutput("best_guess"),
          br(),
          h4("Second Guess:"),
          textOutput("next_guess")
          
    )
  )
))
