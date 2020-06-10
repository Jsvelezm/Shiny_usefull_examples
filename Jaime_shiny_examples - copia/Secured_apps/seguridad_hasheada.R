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
Logged = FALSE;
#my_username <-c("", "Rector","jsvelez","")
#my_password <-c("", "Cmsb12345","GfgNFaYBB7","")
users_passwords <- read.csv2("uph.csv")

my_username = as.character(users_passwords[,1])
my_password = as.character(users_passwords[,2])

hashed_password <- my_password
#write.csv2(hashed_password,"hashed.csv")
ui1 <- function(){
  tagList(
    div(id = "login",
        wellPanel(textInput("userName", "Username"),
                  passwordInput("passwd", "Password"),
                  br(),actionButton("Login", "Log in"))),
    tags$style(type="text/css", "#login {font-size:10px;   text-align: left;position:absolute;top: 40%;left: 50%;margin-top: -100px;margin-left: -150px;}")
  )}




ui =  function(){
  htmlOutput("page") 
  }


server = (function(input, output,session) {
  
  
  USER <- reactiveValues(Logged = Logged)
  
  
  observe({ 
    if (USER$Logged == FALSE) {
      if (!is.null(input$Login)) {
        if (input$Login > 0) {
          Username <- isolate(input$userName)
          Password <- isolate(input$passwd)
          #USER = list()
          #Username <-"hh"
          #Password <-"ss"
          #my_hashed_password <- unlist(lapply(hashed_password,function(x){checkpw(Password,x)}))
          Id.username <- which(my_username == Username)
          #Id.password <- which(my_hashed_password)
          #Id.password <- which(my_username == Username)
          if (length(Id.username) > 0 ) {
                if(checkpw(Password,hashed_password[Id.username][[1]])){
                USER$Logged <- TRUE
              
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
      output$page <-renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui())))
      }) 
       
    }
  })
})

library(installR)
install.Rtools()

install.packages('devtools')
devtools::install_github('thomasp85/gganimate')

#deploy the app
shinyApp(ui, server)