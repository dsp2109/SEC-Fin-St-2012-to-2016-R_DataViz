library(dplyr)


shinyServer(function(input, output){

    col_data = reactive({
      nums_shiny %>% 
        filter(consol_name == input$fin_metr & year == 2016) %>% 
        group_by(AD_Desc,year) %>% 
        summarise(total = sum(value, na.rm = T))
    })
    
    scat_data = reactive({
      nums_shiny %>% filter(consol_name == input$fin1 | consol_name == input$fin2 & year == 2016) %>% 
        group_by(name) %>% 
        summarise(input1 = sum(value[consol_name == input$fin1], na.rm = T),input2 = sum(value[consol_name == input$fin2], na.rm = T)) %>% 
        inner_join(nums_shiny %>% distinct(name, .keep_all = T) %>% select(name, AD_Desc), by = 'name')
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
    
    output$scat_gg <- renderPlot({
      ggplot(scat_data()) + 
        geom_point(aes(x= input1, y = input2, color = AD_Desc)) + 
        ggtitle("Companies by two financial variables") +
        ylab(input$fin2) + xlab(input$fin1) +
        geom_smooth(aes(x= input1, y = input2),method=lm)
    })


})