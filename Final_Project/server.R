library(shiny)
library(data.table)
library(NLP)
library(tm)

shinyServer(function(input, output) {    

    output$trans <- renderText({
        raw_input <- input$obs
        trans_input <- clean_text_in(raw_input)
        return(trans_input)
    })
    
    output$best_guess <- renderText({
        raw_input <- input$obs
        trans_input <- clean_text_in(raw_input)
        best_guess <- "First Guess Result"
        split_input <- split_words(raw_input)
        num_words <- length(split_input)
        
        if(num_words==1){
            best_guess <- one_word_predict(split_input)[1]
        }
        if(num_words==2){
            best_guess <- two_word_predict(split_input)[1]
        }
        if(num_words==3){
            best_guess <- three_word_predict(split_input)[1]
        }
        if(num_words > 3){
            Words_to_Search <- c(split_input[num_words - 2],
                                 split_input[num_words - 1],
                                 split_input[num_words])
            best_guess <- three_word_predict(Words_to_Search)[1]
        }
        return(best_guess)
    })
    
    output$next_guess <- renderText({
      raw_input <- input$obs
      trans_input <- clean_text_in(raw_input)
      next_guess <- "Second Guess Result."
      split_input <- split_words(raw_input)
      num_words <- length(split_input)
      
      if(num_words==1){
        next_guess <- one_word_predict(split_input)[2]
      }
      if(num_words==2){
        next_guess <- two_word_predict(split_input)[2]
      }
      if(num_words==3){
        next_guess <- three_word_predict(split_input)[2]
      }
      if(num_words > 3){
        Words_to_Search <- c(split_input[num_words - 2],
                             split_input[num_words - 1],
                             split_input[num_words])
        next_guess <- three_word_predict(Words_to_Search)[2]
      }
      return(next_guess)
    })

})
