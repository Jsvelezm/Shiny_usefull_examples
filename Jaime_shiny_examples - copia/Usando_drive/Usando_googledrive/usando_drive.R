# using data stored in google drive



library(shiny)
#library(googleAuthR)
#gar_set_client(scopes = "https://www.googleapis.com/auth/drive")
library(googledrive)
library(readxl)

#drive_auth()

#drive_auth(email = "jsvelezm@gmail.com",path = "cliente2.json",token = "shiny_app_token.rds",use_oob = FALSE )




gargle::gargle_oauth_sitrep()

#saveRDS(shiny_token, "shiny_app_token.rds")
#shiny_token = gar_auth(email="jsvelezm@gmail.com")

#gar_auth("shiny_app_token.rds")

## ui.R
ui <- fluidPage(title = "googleAuthR Shiny Demo",
                tableOutput("tabla")
)

## server.R
server <- function(input, output, session){
  
  # create a non-reactive access_token as we should never get past this if not authenticated
  #gar_shiny_auth(session)
  
  drive_download( "https://drive.google.com/file/d/197e49JClaqLpKTs1zwaKag1QcTC22BBg/view?usp=sharing",overwrite = TRUE)
  
  drive_download("https://drive.google.com/file/d/1p-IhG1YD2D0pFYhpU_KthBu5DxP9oAli/view?usp=sharing", overwrite = TRUE)
  
  output$tabla <-  renderTable({
    base = read_excel("DocenteFinal.xlsx")
    head(base)
  })
}

shinyApp(ui, server)
