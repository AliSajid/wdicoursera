
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

shinyUI(fluidPage(

  # Application title
  titlePanel("World Development Trendifier"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      span("Please enter your required data:"),
      numericInput("from_year", "From: ", 2000, min = 1960, max = 2017),
      numericInput("to_year", "To: ", 2000, min = 1960, max = 2017),
      uiOutput("country_selector"),
      uiOutput("indicator_selector"),
      selectInput("interval", "Interval", choices = c(1,2,5,10), label = c("1 Year", "2 Years",
                                                                           "5 Years", "10 Years"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Output", plotlyOutput("wdi_plot")),
        tabPanel("Documentation", textOutput("documentation")),
        id = "outputtabset"
      )
    )
  )
))
