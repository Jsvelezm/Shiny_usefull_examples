# wizzar shiny example


ui <- fluidPage(
  tags$style("#wizard { display:none; }"),
  tabsetPanel(id = "wizard",
              tabPanel("page1", 
                       "Welcome!",
                       actionButton("page12", "next")
              ),
              tabPanel("page2", 
                       "Only one page to go",
                       actionButton("page21", "prev"),
                       actionButton("page23", "next")
              ),
              tabPanel("page3", 
                       "You're done!",
                       actionButton("page32", "prev"),
                       actionButton("page23", "send")
              )
  )
)

server <- function(input, output, session) {
  switch_tab <- function(page) {
    updateTabsetPanel(session, "wizard", selected = page)
  }
  
  observeEvent(input$page12, switch_tab("page2"))
  observeEvent(input$page21, switch_tab("page1"))
  observeEvent(input$page23, switch_tab("page3"))
  observeEvent(input$page32, switch_tab("page2"))
  
}

shinyApp(ui, server)
