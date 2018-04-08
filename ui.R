
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)
library(wdidata)

shinyUI(fluidPage(

  # Application title
  titlePanel("World Development Trendifier"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      span("Please enter your required data:"),
      numericInput("from_year", "From: ", 2000, min = 1960, max = 2017),
      numericInput("to_year", "To: ", 2004, min = 1960, max = 2017),
      selectizeInput("country", "Choose Country: ", choices = wdidata::countries, options = list(maxItems = 5, placeholder = 'Please select countries below', onInitialize = I('function() { this.setValue(""); }'))),
      selectizeInput("indicator", "Choose Indicator: ", choices = wdidata::indicators, options = list(maxItems = 1, placeholder = 'Please select indicator(s) below', onInitialize = I('function() { this.setValue(""); }'))),
      selectInput("interval", "Interval", choices = c(1,2,5,10), label = c("1 Year", "2 Years",
                                                                           "5 Years", "10 Years")),
      actionButton("generate_graph", "Generate Graph")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Output", plotlyOutput("wdi_plot")),
        tabPanel("Documentation", 
                 h2("World Development Trendifier"),
                 h3("Documentation"),
                 p("This short documentation aims to provide you, the user, with all the necessary information on how to use this program. This documentation will walk you through all the parts of the application and intended scenarios"),
                 div(h4("Basic Usage"),
                 p("The basic usage of this web application consists of the following steps: "),
                   tags$ol(
                     tags$li("Select the country you want the data from. You can select up to 5 countries/economic regions."),
                     tags$li("Select the indicator you want to see the data of."),
                     tags$li("Select the starting and ending year of your data set"),
                     tags$li("(Optional) Select an interval between your years."),
                     tags$li("Click \"Generate Graph\" to generate a new graph")
                   )),
                 div(h4("Special Considerations"),
                     tags$ul(
                       tags$li("You can only select years between 1960 and the latest year (currently 2017)"),
                       tags$li("If no data is available for a particular indicator/country combination, an error will be returned"),
                       tags$link("You have to click \"Generate Graph\" every time to redraw the graph"),
                       tags$li("The graph is interactive. You can use the plotly tools to explore the data further.")
                     )
                     ),
        id = "outputtabset"
      )
    )
  )
)
)
)
