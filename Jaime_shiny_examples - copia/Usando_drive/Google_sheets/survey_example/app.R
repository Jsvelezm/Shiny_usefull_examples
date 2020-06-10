# shiny_app with google_sheet conection
# get 

library(shiny)
library(googlesheets)
library(DT)

options(googleAuthR.client_id = "807629257711-q5d10ng1egi2qfru5drik4gj9ieknu2s.apps.googleusercontent.com",
        googleAuthR.client_secret = "OCb3yBlkDVRMtSG0tTOWmPcY")

##### fuction for sace tokens ####
sheet_token_save = function(rsd_file_name = "sheet_token.rsd"){
  token = gs_auth()
  saveRDS(token,rsd_file_name)
}

#sheet_token_save()

gs_auth(token = "sheet_token.rds")

gargle::gargle_oauth_sitrep()

key_id <- "1w2EIP70p_TMPD1UEBtAyP7ZNOPPb6WUyqMiZZrWo9Nw"

sheet <- gs_key(key_id)
# Read the data
base <- gs_read_csv(sheet)
data_id = 1
saveData <- function(data) {
  # Grab the Google Sheet
  sheet <- gs_key(key_id)
  # Add the data as a new row
  gs_add_row(sheet, input = data)
}

loadData <- function(key_id,hoja= 1) {
  # Grab the Google Sheet
  sheet <- gs_key(key_id)
  # Read the data
  datos = gs_read_csv(sheet,ws = hoja)
  return(datos)
}


 
ui <- fluidPage(
        # App title ----
    titlePanel("Survey test"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
      
      # Sidebar to demonstrate various slider options ----
      sidebarPanel(
        
        # Input: Nombres ----
        textInput("nombres", "Nombre de quien responde"),
                    
        # Input: apellidos ----
        textInput("apellidos", "Apellidos de quien responde"),
        
        # Input: c_nacimiento  ----
        selectInput("c_nacimiento", "Ciudad de nacimiento",
                    choices = c("Bogotá","Cali","Medellín","Jaimitolandia","deux_machine")),
        
        # Input: c_actual ----
        selectInput("c_actual", "Ciudad ",
                    choices = c("Bogotá","Cali","Medellín","Jaimitolandia","deux_machine")),
        
        # Input: sexo ----
        selectInput("sexo", "Sexo biológico",
                    choices = c("Hombre","Mujer")),
        
        # Input: edad ----
        selectInput("edad", "edad",
                    choices = c(1:100)),
        
        actionButton("submit", "Submit"),
        
      ),
      mainPanel(tableOutput("table"))    
  )
  )
server <- function(input, output) {

    #salvando resultados
  
      Results <- reactive(
          c(nrow(base) + data_id , input$nombres, input$apellidos, input$c_nacimiento, input$c_actual, input$sexo, input$edad, Sys.time())
        )
    
      observeEvent(input$submit, {                                                                 
       saveData(Results())
      }
      )
     

}

shinyApp(ui = ui, server = server)