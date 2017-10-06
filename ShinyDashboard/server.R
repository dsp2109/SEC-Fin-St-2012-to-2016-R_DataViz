library(dplyr)


shinyServer(function(input, output){
    # show map using googleVis
    output$map <- renderGvis({
        gvisGeoChart(state_stat, "state.name", input$selected,
                     options=list(region="US", displayMode="regions", 
                                  resolution="provinces",
                                  width="auto", height="auto"))
    })
    
   
    output$hist <- renderPlot({
      state_stat %>% 
        ggplot(aes_string(x=input$selected)) +
        geom_histogram(bins=12) +
        ggtitle(input$selected)
        
      # show histogram using googleVis  
      #renderGvis({
        #gvisHistogram(state_stat[,input$selected, drop=FALSE])
        
    })
    
    # show data using DataTable
    output$table <- DT::renderDataTable({
        datatable(state_stat, rownames=FALSE) %>% 
            formatStyle(input$selected, background="skyblue", fontWeight='bold')
    })
    
    # show statistics using infoBox
    output$maxBox <- renderInfoBox({
        max_value <- max(state_stat[,input$selected])
        max_state <- 
            state_stat$state.name[state_stat[,input$selected] == max_value]
        infoBox(max_state, max_value, icon = icon("hand-o-up"))
    })
    output$minBox <- renderInfoBox({
        min_value <- min(state_stat[,input$selected])
        min_state <- 
            state_stat$state.name[state_stat[,input$selected] == min_value]
        infoBox(min_state, min_value, icon = icon("hand-o-down"))
    })
    output$avgBox <- renderInfoBox(
        infoBox(paste("AVG.", input$selected),
                mean(state_stat[,input$selected]), 
                icon = icon("calculator"), fill = TRUE))
})