# using data stored in google drive
# for now this only work locally
# this program dowload and read .xslx file from googledrive


library(shiny)
library(googledrive)
library(readxl)
library(googleAuthR)

# force drive to use your email and use a saved token
#drive_auth(email = "youremail@gmail.com",path = "cliente2.json",token = "shiny_app_token.rds" )



## ui.R
ui <- fluidPage(title = "google Drive Shiny Demo",
                tableOutput("tabla")
)


#gargle_oauth_sitrep() # use this to see which tokens do you have and where are stored
#shiny_token = gargle2.0_token(email="jsvelezm@gmail.com",scope ="https://www.googleapis.com/auth/drive")
#saveRDS(shiny_token, "shiny_app_token.rds")


## server.R
server <- function(input, output, session){
  
  # download the file in to the working directory
  drive_download( "your full link",overwrite = TRUE)
  
  # read and render the head of a .xlsx file
  output$tabla <-  renderTable({
    base = read_excel("DownloadFile.xlsx")
    head(base)
  })
}

shinyApp(ui, server)
