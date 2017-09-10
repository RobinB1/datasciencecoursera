# ui.R
library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  titlePanel(title = "My Text Prediction Capstone Project"),
  shinythemes::themeSelector(),
  headerPanel(img(src = 'logos.png', align = "center")),
  br(),
  sidebarPanel(
    textInput("inputText", h5("Text input")),
    actionButton(inputId = "submitInfo", label = "Submit Text"),
    br()),
  mainPanel(
    tabsetPanel(type = "tabs",
                id = "tabs",
                tabPanel(title = "Overview",
                         h4("Introduction"),
                         p("This Text Prediction Application is the final project submission for the Coursera Data Science   Specialisation conducted by Johns Hopkins University."),
                         p("The basis of the application is to take the SwiftKey text files and create a predicting tool using an underlying agorthym that is capable of predicting the next word from a phrase that is entered by the User into the application's text input field."),
                         h4("Application Instruction"),
                         p("1. Type some text into the text box under the Text input heading"),
                         p("2. \"Text input\" values are restricted to only alphabetical words."),
                         h4("Input / Output"),
                         p("1. User may input any words, however it will be preprocessed before submitting"),
                         p("2. On Submitting, the Result tab will display."),
                         p("3. The text box \"The original submitted text:\" will display the text the user."),
                         p("4. The text box \"The submitted text has been reformatted to the following:,\""),
                         p("will show the text after preprocessed."),
                         p("5. The text box \"The most likely next word will be:,\" will show the predicted words."),
                         div(p("* As an added extra, the Themes widget is added, allowing the User to change colour schemes to suit their own preference (mine is Cyborg)."),style = "color:red")),
                tabPanel(title = "Result",
                         h4("The original submitted text:"),
                         textOutput("Original"),
                         br(),
                         h4("The submitted text has been reformated to the following:"),
                         textOutput("Translated"),
                         br(),
                         br(),
                         h4("The most likely next word will be:"),
                         div(textOutput("BestGuess")),
                         br(),
                         h4("The program guessed your word based on the following data:"),
                         tableOutput("view")))
    )
  )
)