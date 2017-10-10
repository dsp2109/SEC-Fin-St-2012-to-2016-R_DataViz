library(shiny)
library(shinydashboard)
library(shinythemes)
library(DT)
library(googleVis)
library(ggplot2)
library(dplyr)

load("Data/shiny_sec_data.rda")
load("Data/ggfilings.rda")
rm(state_stats)

choice = unique(nums_shiny$AD_Desc)
fin_choice = unique(nums_shiny$fin_line)


ggplot(ggdata2 %>% filter(last10k %in% 2012:2015)) + 
  geom_col(aes(x= last10k, y = instances)) + 
  ggtitle("Companies no longer filing")

print(class(gg_dt))
print(ls())
print(getwd())