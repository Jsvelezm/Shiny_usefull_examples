## app.R ##

###### Lectura de bases ######

##### librerias ####
library(shiny)
library(shinydashboard)

library(ggplot2)

library(bcrypt)




Header <- dashboardHeader()
Sidebar <- dashboardSidebar()
Body <- dashboardBody()
# create autentication

# create the ui

ui2 <-  dashboardPage(
  Header
  ,Sidebar
  ,Body
)


library(shiny)
Logged = FALSE

#write.csv2(hashed_password,"hashed.csv")
ui1 <- function(){
   
        wellPanel(textInput("userName", "Username"),
                  passwordInput("passwd", "Password"),
                  br(),actionButton("send", "Log in"))
}




ui =  function(){
  
      wellPanel(textInput("adsf", "dsafe"),
                  passwordInput("passwd", "Password"),
                  br(),actionButton("back", "Log in"))
    
  }



server = (function(input, output,session) {
  
  
  USER <- reactiveValues(Logged = Logged)
  
  observeEvent(input$send, USER$Logged <- TRUE )
  
  observeEvent(input$back, USER$Logged <- FALSE )
  
  observe({
    if (USER$Logged == TRUE) {
      
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui1())))
      })
    }
    if (USER$Logged == TRUE) 
    {
      output$page <-renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui())))
      }) 
      
      
    }
  })
})



#deploy the app
shinyApp(ui, server)