# ui.R - GA COVID-19 State Analysis
#

shinyUI(fluidPage(

    # Application title
    titlePanel("U.S. State of Georgia COVID-19 County Data"),

     navbarPage("Georgia COVID-19 Data",
               
            tabPanel("Map View",   
            wellPanel(
                h5("Filter COVID-19 Data using Sliders"),
                sliderInput("casedeath",
                        label="Death Rate/100K Greater than or Equal to:",
                        min=0,
                        max=max(df$Death_Rate),
                        value=0),  
            sliderInput("pop",
                        "Population Size Greater than or Equal to:",
                        min = 1000,
                        max = 250000,
                        value = 1000,
                        step = 10000),
            ),

          leafletOutput("GAMap"),       
            ),

          
          tabPanel(title="Data Table",
                   radioButtons("sortseq","Sort Data Table by ..", 
                                c("County", "# Deaths", "# Cases", "# Hospitalizations"),
                                selected="County",
                                inline=TRUE),
                   
                   materialSwitch("sortDir","Ascending/Descending", inline=TRUE),
                   tableOutput("GATable")
          ),


          navbarMenu("Help",  
            tabPanel(title="Help on Map",
                         imageOutput("MapHelp", width="auto", height="auto") 
            ),
            tabPanel(title="Help on Data Table",
                         imageOutput("DataHelp")
            )
          )
    )
)
)


