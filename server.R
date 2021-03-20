# GA COVID-19 State Analysis#
# 
#

library(shiny)
library(plotly)

shinyServer(function(input, output) {
    

   casedeath <- reactive({as.numeric(input$casedeath)})
   pop <- reactive({as.numeric(input$pop)})

   output$GAMap <- renderLeaflet({


        topten <- input$topten

        df <- subset(df,Population >= pop() & Death_Rate >= casedeath())
        

        df %>% leaflet() %>% 
            addTiles() %>% 
                     addCircles(lng =~ LONGITUDE, lat = ~LATITUDE,
                     weight=1,
                    popup =paste(df$County_Name,"County", "<br>", 
                                 "Seat: ",df$County_Seat, "<br>",
                                 "#Cases:",df$Cases,"<br>",
                                 "#Hosp:",df$Hospitalization, "<br>", 
                                 "Death Rate: ", df$Death_Rate),
                     radius=~Death_Rate*50)        


    })
    
    output$GATable <- renderTable({
      sortseq <- as.character(input$sortseq)
      sortDir <- as.logical(input$sortDir)
      if(sortseq == "County") {
        df <- df[order(df$County_Name, decreasing= sortDir),] }
        else { if(sortseq == "# Deaths") {
          df <- df[order(df$Deaths, decreasing= sortDir),]}
          else {if(sortseq == "# Cases") {
            df <- df[order(df$Cases, decreasing= sortDir),]}
            else {if(sortseq == "# Hospitalizations") {
              df <- df[order(df$Hospitalizations, decreasing= sortDir),]}
        }
          }
        }
 #     df <- subset(df,Population >= pop() & Death_Rate >= casedeath())
      df %>% select(County_Name, County_Seat, Population,Cases, Hospitalizations,Deaths)
    })

     output$MapHelp <- renderImage({
        filename <- normalizePath(file.path("./www/MapHelp.png"))
        list(src=filename)
        
     }, deleteFile=FALSE) 
     output$DataHelp <- renderImage({
       filename <- normalizePath(file.path("./www/DataHelp.png"))
       list(src=filename)
       
     }, deleteFile=FALSE) 
})
