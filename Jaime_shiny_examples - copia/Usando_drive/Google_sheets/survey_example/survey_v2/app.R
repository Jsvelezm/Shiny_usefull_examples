## app.R ##

###### Lectura de bases ######

##### librerias ####
library(shiny)
library(googlesheets)
library(shiny)


# init some useful variables
Logged = FALSE
start = TRUE
data_id = 1

# seteando la clave de la aplicación

options(googleAuthR.client_id = "807629257711-q5d10ng1egi2qfru5drik4gj9ieknu2s.apps.googleusercontent.com",
        googleAuthR.client_secret = "OCb3yBlkDVRMtSG0tTOWmPcY")

gs_auth(token = "sheet_token.rds")

key_id <- "1w2EIP70p_TMPD1UEBtAyP7ZNOPPb6WUyqMiZZrWo9Nw"

# load for firstime the data

sheet <- gs_key(key_id)
base <- gs_read_csv(sheet)


# save and read google sheets

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






ui1 <- function(){
  tagList(
    div(id = "survey",
        wellPanel(# Input: Nombres ----
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
                  br(),actionButton("send", "Enviar respuesta"))),
    tags$style(type="text/css", "#survey {font-size:10px;   text-align: left;position:absolute;top: 40%;left: 50%;margin-top: -100px;margin-left: -150px;}")
  )}


ui2 <- function(){
  fluidPage(    
        sidebarLayout(
        sidebarPanel("gracias por responder",
                  br(),actionButton("back", "Enviar otra respuesta")),
        mainPanel(DT::dataTableOutput("table")
        )
        )
   
   
  )}


ui =  function(){
  htmlOutput("page") 
}


server = (function(input, output,session) {
  
  
  USER <- reactiveValues(Logged = Logged)
  ids <- reactiveValues(data_id = data_id)
  
  if(start == TRUE){
  output$page <- renderUI({
    div(class="outer",do.call(bootstrapPage,c("",ui1())))
  })
  }
  
  
  observeEvent(input$send,{ 
    if (USER$Logged == FALSE) {
      USER$Logged <- TRUE
      output$page <- renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui2())))
      })
      saveData(Results())
      base_interna$base_int = loadData(key_id)
      start = FALSE
      ids$data_id = ids$data_id + 1
  }})
  
  observeEvent(input$back,{ 
    if (USER$Logged == TRUE) {
      output$page <-renderUI({
        div(class="outer",do.call(bootstrapPage,c("",ui1())))
      }) 
      USER$Logged <- FALSE
    }})
  
  
  
  
  # cargar la info a la base de datos
  Results <- reactive(
    c(nrow(base) + ids$data_id , input$nombres, input$apellidos, input$c_nacimiento, input$c_actual, input$sexo, input$edad, Sys.time())
  )
  
  base_interna <- reactiveValues(base_int = base)
  
  
  output$table <-  DT::renderDataTable({base_interna$base_int})
  
})



#deploy the app
shinyApp(ui, server)