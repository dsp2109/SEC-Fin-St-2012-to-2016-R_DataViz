library(dplyr)


shinyServer(function(input, output){


   
    output$gg1 <- renderPlot({
      ggplot(gg_dt) + 
        geom_col(aes(x = year, y = cnt, fill = form_group)) + ggtitle("Filings by year")
    })
    
    output$gg2 <- renderPlot({
      ggplot(ggdata2 %>% filter(first10k > 2012)) + geom_col(aes(x= first10k, y = instances)) + ggtitle("New companies")
    })
    
    output$gg3 <- renderPlot({
      ggplot(ggdata2 %>% filter(last10k %in% 2012:2015)) + 
        geom_col(aes(x= last10k, y = instances)) + 
        ggtitle("Companies no longer filing")
    })
    


})