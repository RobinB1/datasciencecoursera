# server.R

library(shiny)
library(shinythemes)
library(data.table)
library(NLP)
library(tm)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {
  # #On submit open the Results tab
  observeEvent(input$submitInfo, {
    updateTabsetPanel(session = session, inputId = "tabs", selected = "Result")
  })
  # Generate a summary of the dataset
  output$Original <- renderText({
    Original_Input <- input$inputText
    return(Original_Input)
  })

  # Generate a summary of the dataset
  output$Translated <- renderText({
    Original_Input <- input$inputText
    Translated_Input <- Translate_Input(Original_Input)
    return(Translated_Input)
  })

  # Generate a summary of the dataset
  output$BestGuess <- renderText({
    Original_Input <- input$inputText
    Translated_Input <- Translate_Input(Original_Input)
    BestGuess_Output <- "The predicted next word will appear here."
    Split_Trans_Input <- Split_Translate_Input(Original_Input)
    Word_Count <- length(Split_Trans_Input)

    if (Word_Count == 1) {
      BestGuess_Output <- Word_Count1(Split_Trans_Input)
    }
    if (Word_Count == 2) {
      BestGuess_Output <- Word_Count2(Split_Trans_Input)
    }
    if (Word_Count == 3) {
      BestGuess_Output <- Word_Count3(Split_Trans_Input)
    }
    if (Word_Count > 3) {
      Words_to_Search <- c(Split_Trans_Input[Word_Count - 2],
                           Split_Trans_Input[Word_Count - 1],
                           Split_Trans_Input[Word_Count])
      BestGuess_Output <- Word_Count3(Words_to_Search)
    }
    return(BestGuess_Output)
  })

  # Show the first "n" observations
  output$view <- renderTable({
    Original_Input <- input$inputText
    Split_Trans_Input <- Split_Translate_Input(Original_Input)
    Word_Count <- length(Split_Trans_Input)

    if (Word_Count == 1) {
      BestGuess_Output <- Word_Count1(Split_Trans_Input)
    }
    if (Word_Count == 2) {
      BestGuess_Output <- Word_Count2(Split_Trans_Input)
    }
    if (Word_Count == 3) {
      BestGuess_Output <- Word_Count3(Split_Trans_Input)
    }
    if (Word_Count > 3) {
      Words_to_Search <- c(Split_Trans_Input[Word_Count - 2],
                           Split_Trans_Input[Word_Count - 1],
                           Split_Trans_Input[Word_Count])
      BestGuess_Output <- Word_Count3(Words_to_Search)
    }

    if (exists("AlternativeGuess", where = -1)) {
      AlternativeGuess
    }else{
      XNgramsTable <- data.frame(Word = NA, Probability = NA)
    }

  })
})