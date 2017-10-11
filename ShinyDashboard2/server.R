library(dplyr)


shinyServer(function(input, output){

#### financial state data
  
      col_data = reactive({
      nums_shiny %>% 
        filter(consol_name == input$fin_metr & year == 2016) %>% 
        group_by(AD_Desc,year) %>% 
        summarise(total = sum(value, na.rm = T))
    })
    
    scat_data = reactive({
      nums_shiny %>% filter(consol_name == input$fin1 | consol_name == input$fin2 & year == 2016) %>% 
        group_by(name) %>% 
        summarise(input1 = sum(value[consol_name == input$fin1], na.rm = T),
                  input2 = sum(value[consol_name == input$fin2], na.rm = T)) %>% 
        filter(input1>0, input2>0) %>% 
        inner_join(nums_shiny %>% distinct(name, .keep_all = T) %>% select(name, AD_Desc), by = 'name')
    })
    
    scat_data_ind = reactive({
      nums_shiny %>% filter(consol_name == input$fin1 | consol_name == input$fin2 & year == 2016) %>% 
        group_by(name) %>% 
        summarise(input1 = sum(value[consol_name == input$fin1], na.rm = T),
                  input2 = sum(value[consol_name == input$fin2], na.rm = T)) %>% 
        filter(input1>0, input2>0) %>% 
        inner_join(nums_shiny %>% distinct(name, .keep_all = T) %>% select(name, AD_Desc), by = 'name') %>% 
        group_by(AD_Desc) %>% 
        summarise(x_ax_dols = sum(input1), y_ax_dols = sum(input2))
    })
  
    output$gg1 <- renderPlot({
      ggplot(gg_dt) + 
        geom_col(aes(x = year, y = count, fill = form_group)) + ggtitle("Filings by year")
    })
    
    output$gg2 <- renderPlot({
      ggplot(ggdata2 %>% filter(first10k > 2012)) + geom_col(aes(x= first10k, y = instances)) + ggtitle("New companies")
    })
    
    output$gg3 <- renderPlot({
      ggplot(ggdata2 %>% filter(last10k %in% 2012:2015)) + 
        geom_col(aes(x= last10k, y = instances)) + 
        ggtitle("Companies no longer filing")
    })
    
    output$col_gg <- renderPlot({
      ggplot(col_data()) + 
        geom_col(aes(x= year, y = total, fill = AD_Desc)) + 
        ggtitle("Total financial value by industry")
    })
    
    output$scat_gg <- renderPlotly({
      ggplot(scat_data()) + 
        geom_point(aes(x= input1, y = input2, color = AD_Desc, text = paste('Name: ', name))) + 
        ggtitle("Companies by two financial variables") +
        ylab(input$fin2) + xlab(input$fin1) +
        geom_smooth(aes(x= input1, y = input2),method=lm)
    })
    
    output$scat_ind <- renderPlotly({
        ggplot(scat_data_ind()) + 
        geom_point(aes(x= x_ax_dols, y = y_ax_dols, color = AD_Desc)) + 
        ggtitle("Companies by two financial variables") +
        ylab(input$fin2) + xlab(input$fin1)
      
    })

######by state
    state_stat <- reactive({
      state_stats %>%
        filter(consol_name == input$fin_metr) %>% 
        group_by(state_imp) %>% 
        summarise(co_count = sum(co_count, na.rm = T), total = sum(total, na.rm = T), inst = sum(inst, na.rm = T))
    })
    
    # show map using googleVis
    output$map <- renderGvis({
      gvisGeoChart(data = state_stat(), "state_imp", input$selected,
                   options=list(region="US", displayMode="regions", 
                                resolution="provinces",
                                width="auto", height="auto"))
    })
    
    
    output$hist <- renderPlot({
      state_stat() %>% 
        ggplot(aes_string(x=input$selected)) +
        geom_histogram() +
        ggtitle(input$selected)
      
      # show histogram using googleVis  
      #renderGvis({
      #gvisHistogram(state_stat[,input$selected, drop=FALSE])
      
    })
    
    # show data using DataTable
    output$table <- DT::renderDataTable({
      datatable(state_stat(), rownames=FALSE) %>% 
        formatStyle(input$selected, background="skyblue", fontWeight='bold')
    })
    
    # show statistics using infoBox
    output$maxBox <- renderInfoBox({
      max_value <- max(state_stat()[,input$selected])
      max_state <- 
        state_stat()$state_imp[state_stat()[,input$selected] == max_value]
      infoBox(max_state, max_value, icon = icon("hand-o-up"))
    })
    output$minBox <- renderInfoBox({
      min_value <- min(state_stat()[,input$selected])
      min_state <- 
        state_stat()$state_imp[state_stat()[,input$selected] == min_value]
      infoBox(min_state, min_value, icon = icon("hand-o-down"))
    })
    output$avgBox <- renderInfoBox({
      med_val = median(sapply((state_stat()[,input$selected]), as.numeric))
      str(state_stat()[,input$selected])
      infoBox(paste0("Medi.", input$selected),
              med_val , 
              icon = icon("calculator"), fill = TRUE)
    })
    
    
})