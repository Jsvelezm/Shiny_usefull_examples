# Construnctor de preguntas

library(googlesheets)
library(shiny)


options(googleAuthR.client_id = "807629257711-q5d10ng1egi2qfru5drik4gj9ieknu2s.apps.googleusercontent.com",
        googleAuthR.client_secret = "OCb3yBlkDVRMtSG0tTOWmPcY")

gs_auth(token = "sheet_token.rds")

key_id <- "1w2EIP70p_TMPD1UEBtAyP7ZNOPPb6WUyqMiZZrWo9Nw"

# seteando la clave de la aplicación

options(googleAuthR.client_id = "807629257711-q5d10ng1egi2qfru5drik4gj9ieknu2s.apps.googleusercontent.com",
        googleAuthR.client_secret = "OCb3yBlkDVRMtSG0tTOWmPcY")

gs_auth(token = "sheet_token.rds")

key_id <- "1w2EIP70p_TMPD1UEBtAyP7ZNOPPb6WUyqMiZZrWo9Nw"

# load for firstime the data

sheet <- gs_key(key_id)
cp <- gs_read_csv(sheet,ws = 2)



# constructor


preguntas=list()

# funcion_para_preguntas de texto


p_text =  function(nombre,etiqueta)
{
  paste("textInput('",nombre,"', '",etiqueta,"')", sep = "")
}

p_text("jaime","nepe")

p_slider =  function(nombre,etiqueta,min,max)
{
  paste("sliderInput('",nombre,"', '",etiqueta,"', ","min = ",min,", max=",max,")", sep = "")
}

p_slider("jaime","nepe",min = 1,max =10)


p_select =  function(nombre,etiqueta,choices)
{
  paste("selectInput('",nombre,"', '",etiqueta,"', ",choices,")", sep = "")
}


p_select("jaime","jaime","jaime")

