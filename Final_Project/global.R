library(shiny)
library(data.table)
library(NLP)
library(tm)

data<- fread("ngrams.txt")
setkeyv(data, c('word0', 'word1', 'word2', 'word3', 'freq'))


clean_text_in <- function(input_text){
    cleaned <- tolower(input_text)
    cleaned <- stripWhitespace(cleaned)
    cleaned <- gsub("[^\\p{L}\\s]+", "", cleaned, perl=T)
    return(cleaned)
}

split_words <- function(input_text){
    cleaned <- clean_text_in(input_text)
    splitted <- unlist(strsplit(cleaned, " "))
    return(splitted)
}

one_word_predict <- function(cleaned_text_list){
    ngramstable <<- data[list("-", cleaned_text_list[1])]
    ngramstable <<- ngramstable[ngramstable$word2!="-", ]
    ngramstable <<- ngramstable[order(ngramstable$freq, decreasing=TRUE), ]
    
    dups=duplicated(subset(ngramstable, select=c('word1','word2')),)
    ngramstable=ngramstable[!dups, ]
    
    next_guess=''
    if (length(ngramstable)>1){next_guess<-ngramstable$word2[2]}
    

    out_guess <- ngramstable$word2[1]
    if(is.na(out_guess)|is.null(out_guess)){
        out_guess <- "Ahh! I have no answer for you!"
    }
    
    return (c(out_guess,next_guess))
}

two_word_predict <- function(cleaned_text_list){
    ngramstable <<- data[list("-", cleaned_text_list[1], cleaned_text_list[2])]
    ngramstable <<- ngramstable[ngramstable$word3!="-", ]
    ngramstable <<- ngramstable[order(ngramstable$freq, decreasing=TRUE), ]
    
    
    dups=duplicated(subset(ngramstable, select=c('word1','word2','word3')),)
    ngramstable=ngramstable[!dups, ]
    
    next_guess=''
    if (length(ngramstable)>1){next_guess<-ngramstable$word3[2]}

    out_guess <- ngramstable$word3[1]
    if(is.na(out_guess)|is.null(out_guess)){       
        out_guess <- one_word_predict(cleaned_text_list[2])
    }
    
    return (c(out_guess,next_guess))
    
}

three_word_predict <- function(cleaned_text_list){
    ngramstable <<- data[list("-", cleaned_text_list[1], cleaned_text_list[2], cleaned_text_list[3])]
    ngramstable <<- ngramstable[ngramstable$word4!="-", ]
    ngramstable <<- ngramstable[order(ngramstable$freq, decreasing=TRUE), ]
    
    dups=duplicated(subset(ngramstable, select=c('word1','word2','word3','word4')),)
    ngramstable=ngramstable[!dups, ]
    
    next_guess=''
    if (length(ngramstable)>1){next_guess<-ngramstable$word4[2]}

    out_guess <- ngramstable$word4[1]
    if(is.na(out_guess)|is.null(out_guess)){
        short_in <- c(cleaned_text_list[2], cleaned_text_list[3])
        out_guess <- two_word_predict(short_in)
        if(is.na(out_guess)|is.null(out_guess)){
            out_guess <- one_word_predict(cleaned_text_list[3])
        }
    }
    
    return (c(out_guess,next_guess))
    
}
