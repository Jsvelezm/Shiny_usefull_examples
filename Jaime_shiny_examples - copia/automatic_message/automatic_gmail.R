library(gmailr)

#use_secret_file("automatic_gmail.json")


correo =  "jsvelezm@gmail.com"


gm_auth_configure(path = "automatic_gmail.json")


correo_salida = "jsvelezm@gamil.com"
correo_llegada = "maria.merchan20@gmail.com"
texto = "Hola a todos, estoy probando mi nueva función para enviar mensajes"
nombre_archivo = "1013124324_604.html"
asunto =  "Correo de prueba"

enviar_correo =  function(correo_llegada,texto,asunto,nombre_archivo)
{
  correo_salida = "jsvelezm@gmail.com"
text_msg <- gm_mime() %>%
  gm_to( correo_llegada ) %>%
  gm_from( correo_salida ) %>%
  gm_text_body(texto) %>% 
  gm_attach_file(nombre_archivo) %>%
  gm_subject(asunto)

gm_send_message(mail = text_msg)

}

enviar_correo(correo_llegada,texto,asunto,nombre_archivo)


library(readxl)

correos = read_excel("correos_ids.xlsx")
correos




correo_salida = "jsvelezm@gamil.com"
texto = "Hola a todos, estoy probando mi nueva función para enviar mensajes"
asunto =  "Correo de prueba"

for( i in c(1:nrow(correos)))
{
  nombre_archivo = paste(correos[i,2],".html", sep = "")  
  enviar_correo(correos[i,1],texto,asunto, nombre_archivo)
}




#convertir a un caracter para verlo
# strwrap(as.character(text_msg))

#aquí enviamos el correo


