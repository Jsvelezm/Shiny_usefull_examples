## app.R ##

###### Lectura de bases ######

##### librerias ####
library(shiny)
library(shinydashboard)

library(ggplot2)





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
Logged = FALSE;
my_username <-c( "Rector","jsvelez","")
my_password <-c( "Cmsb12345","GfgNFaYBB7","")

ui1 <- function(){
  tagList(
    div(id = "login",
        wellPanel(textInput("userName", "Username"),
                  passwordInput("passwd", "Password"),
                  br(),actionButton("Login", "Log in"))),
    tags$style(type="text/css", "#login {font-size:10px;   text-align: left;position:absolute;top: 40%;left: 50%;margin-top: -100px;margin-left: -150px;}")
  )}




ui = (htmlOutput("page") )


server = (function(input, output,session) {
  
  USER <- reactiveValues(Logged = Logged)
  
  observe({ 
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          hashPassword <- hashpw(Password)
          
          Id.username <- which(my_username == Username)
          Id.password <- which(my_password == Password)
          if (length(Id.username) > 0 & length(Id.password) > 0) {
            if (Id.username == Id.password){
              if(checkpw(my_password[Id.password],hashPassword)){
              USER$Logged <- TRUE
              }
            } 
          }
        } 
      }
    }    
  })
  observe({
    if (USER$Logged == FALSE) {
      
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui1())))
      })
    }
    if (USER$Logged == TRUE) 
    {
      output$page <-renderUI({ui2}) 
      
      
    }
  })
})



#deploy the app
shinyApp(ui, server)