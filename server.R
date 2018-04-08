

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(WDI)
library(plotly)
library(tidyverse)
library(wdidata)


shinyServer(function(input, output, session) {
  generate_plot <- eventReactive(input$generate_graph, {
    validate(
      need(abs(input$to_year - input$from_year) > input$interval, "Interval should be smaller than the range of years")
    )
    valid_years <- seq(as.numeric(input$from_year), as.numeric(input$to_year), by = as.numeric(input$interval))
    download <-
      WDI(
        country = if_else(condition = input$country != "", input$country, "all"),
        indicator = input$indicator,
        start = input$from_year,
        end = input$to_year
      )
    validate(
      need(!is.null(download), "The requested data can not be loaded. Please try a different set of inputs.")
      )
    
    download <- download %>% 
      filter(year %in% valid_years)
    
    indicator_id <- names(download)[3]
    indicator_full_name <-
      names(indicators)[which(indicators == indicator_id)]
    names(download)[3] <- "indicator"
    download %>%
      plot_ly(
        x = ~ year,
        y = ~ indicator,
        color = ~ country,
        type = "scatter",
        mode = "lines"
      ) %>%
      layout(
        xaxis = list(
          autotick = FALSE,
          dtick = input$interval,
          title = "Years"
        ),
        yaxis = list(title = indicator_full_name),
        margin = list(
          l = 50,
          r = 50,
          b = 100,
          t = 100,
          pad = 4
        ),
        autosize = TRUE
      )
  })
  
    output$wdi_plot <- renderPlotly(generate_plot())


  })
