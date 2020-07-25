# This produces a Shiny app featuring two graphs linked by interactivity

library(shiny)
    library(ggplot2)
    library(ggiraph)

# Load data
data <- mpg

ui <- fluidPage(
    girafeOutput("plot1"),
    girafeOutput("plot2")
)

server <- function(input, output, session) {

    output$plot1 <- renderGirafe({
        scatter <- ggplot(data,aes(x=displ,y=hwy)) +
            geom_point_interactive(aes(tooltip=model, data_id=model))
        x <- girafe(ggobj = scatter)
        x
    })
    observeEvent(input$plot1_selected,{
        output$plot2 <- renderGirafe({
        react <- ggplot(data[which(data$model==input$plot1_selected),], aes(x=cty)) +
              geom_bar()
        y <- girafe(ggobj = react)
        y
        })
    })
}

# Run the application
shinyApp(ui = ui, server = server)
