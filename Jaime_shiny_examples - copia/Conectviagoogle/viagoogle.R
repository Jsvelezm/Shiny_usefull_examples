# do not work
# i dont know why
library(shiny)
library(googleAuthR)
#options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/drive"))

options(googleAuthR.scopes.selected = c("https://www.googleapis.com/auth/drive"))
options(googleAuthR.client_id = "807629257711-q5d10ng1egi2qfru5drik4gj9ieknu2s.apps.googleusercontent.com",
        googleAuthR.client_secret = "OCb3yBlkDVRMtSG0tTOWmPcY")


## server.R
server <- function(input, output, session){

  ## Create access token and render login button
  access_token <- callModule(googleAuth, "loginButton")
  
}

## ui.R
ui <- fluidPage(
  googleAuthUI("loginButton")
)

shinyApp(ui = ui, server = server)