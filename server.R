library(shiny)
library(httr)
library(rjson)

shinyServer(
  function(input, output) {
    
    chrom <- reactive({
      input$chromosome
    })
    
    pos <- reactive({
      input$position
    })
    
    a <- reactive({
      input$allele
    })
    
    
    
    output$text1 <- renderText({
      request <- paste0("http://localhost/cgi-bin/ucscBeacon/query?chromosome=",chrom(),"&position=",pos(),"&alternateBases=",a())
      r <- GET(request)
      response <- fromJSON(content(r, as = "text"))
      paste0(response$response$exists)
    })
  }
)