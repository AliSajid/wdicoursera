
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(WDI)
library(plotly)
library(tidyverse)

return_countries <- function(data) {
  data_transformed <- as_tibble(data)
  countries <- data_transformed$iso2c
  names(countries) <- data_transformed$country
  countries
}

return_indicators <- function(data) {
  data_transformed <- as_tibble(data)
  indicators <- data_transformed$indicator
  names(indicators) <- data_transformed$name
  indicators
}



shinyServer(function(input, output, session) {
  
  output$country_selector <- renderUI({
    selectInput("country", "Choose Country: ", choices = return_countries(WDI_data$country), multiple = TRUE)
  })

  output$indicator_selector <- renderUI({
    selectInput("indicator", "Choose Indicator: ", choices = return_indicators(WDI_data$series))
  })
  
  output$documentation <- renderText(paste("Country: ", input$country, "Indicator: ", input$indicator))
})
