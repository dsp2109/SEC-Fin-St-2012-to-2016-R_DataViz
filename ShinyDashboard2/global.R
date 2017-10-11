library(shiny)
library(shinydashboard)
library(shinythemes)
library(DT)
library(googleVis)
library(ggplot2)
library(dplyr)
library(plotly)

load("Data/shiny_sec_data.rda")
load("Data/ggfilings.rda")

rownames(state_stats) <- NULL
choice <- colnames(state_stats)[4:6]

ind_choice = unique(nums_shiny$AD_Desc)
fin_choice = unique(nums_shiny$consol_name)
fin_st_choice <- c(NULL, unique(state_stats$consol_name))
