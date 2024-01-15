# Load in the necessary libraries

library(shiny)
library(tidyverse)
library(png)
library(ggimage)
library(grid)
library(patchwork)

## Load in the data file as well as background image file

pen_data = read_csv('data/penalty.csv')
img = readPNG('data/goalpost.png')

## Set up the navigation bar

ui = navbarPage(
  title = 'Penalty',
  tabPanel(
    title = 'World Cup Penalty Location Visualization',
    titlePanel(title = 'Penalty World Cup Data: 1982 - 2018'),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = 'yr',
          label = 'Year',
          choices = sort(unique(pen_data$Year)),
          selected = 2018),
        selectInput(
          inputId = 'match',
          label = 'Match',
          choices = sort(unique(pen_data$Match)),
          selected = 'Columbia vs. England')
      ),
      mainPanel(plotOutput("goalmap", width = "50%"))
    )
  ),
  tabPanel(title = 'Penalty Summary Table',
           dataTableOutput('table')),
  tabPanel(title = 'About',
           includeMarkdown('about.Rmd'))
)

# Set up the I/O for client-side

server = function(input, output) {

  match_by_year = reactive({
    pen_data |>
      filter(Year == input$yr)
  })

  observeEvent(
    eventExpr = input$yr,
    handlerExpr = {
      updateSelectInput(inputId = 'match',
                        choices = sort(match_by_year()$Match))
    }
  )

  output$goalmap = renderPlot({

    pen_new = pen_data |>
      filter(Year == input$yr) |>
      filter(Match == input$match) |>
      shotzone() |>
      pen_outcome()

    pen_1 = pen_new |>
      filter(Country == pen_new$Country[1]) |>
      ggplot() +
      aes(x = X_position, y = Y_position, group = Outcome) +
      annotation_custom(rasterGrob(img,
                                   width = unit(1,"npc"),
                                   height = unit(1,"npc")),
                        -Inf, Inf, -Inf, Inf) +
      geom_point(aes(shape = Outcome, color = Outcome), size = 7.5) +
      geom_hline(yintercept=1,linetype=2, size = 1.5) +
      geom_hline(yintercept=2,linetype=2, size = 1.5) +
      geom_vline(xintercept=1,linetype=2, size = 1.5) +
      geom_vline(xintercept=2,linetype=2, size = 1.5) +
      ylim(-0.5, 3.5) +
      xlim(-0.1, 3.1)+
      theme(axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.title.x=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks.y=element_blank(),
            axis.title.y=element_blank()) +
      labs(title = pen_new$Country[1])

    pen_2 = pen_new |>
      filter(Country == pen_new$Country[2]) |>
      ggplot() +
      aes(x = X_position, y = Y_position, group = Outcome) +
      annotation_custom(rasterGrob(img,
                                   width = unit(1,"npc"),
                                   height = unit(1,"npc")),
                        -Inf, Inf, -Inf, Inf) +
      geom_point(aes(shape=Outcome, color=Outcome), size = 7.5) +
      geom_hline(yintercept=1,linetype=2, size = 1.5) +
      geom_hline(yintercept=2,linetype=2, size = 1.5) +
      geom_vline(xintercept=1,linetype=2, size = 1.5) +
      geom_vline(xintercept=2,linetype=2, size = 1.5) +
      ylim(-0.5, 3.5) +
      xlim(-0.1, 3.1)+
      theme(axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            axis.title.x=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks.y=element_blank(),
            axis.title.y=element_blank()) +
      labs(title = pen_new$Country[2])

    pen_2/pen_1
  }, width = 800, height = 700)

  output$table = renderDataTable({
    pen_data |>
      filter(Year == input$yr) |>
      filter(Match == input$match) |>
      shotzone() |>
      pen_outcome() |>
      select(-OnTarget, -Goal, -Elimination) |>
      select(Year:Zone, X_position, Y_position, everything())
  })
}


shinyApp(ui = ui, server = server)
