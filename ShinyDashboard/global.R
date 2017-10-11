library(shiny)
library(shinydashboard)
library(shinythemes)
library(DT)
library(googleVis)
library(ggplot2)
library(dplyr)

load("Data/shiny_sec_data.rda")
# remove row names
rownames(state_stats) <- NULL
# create variable with colnames as choice
choice <- colnames(state_stats)[4:6]
fin_choice <- c(NULL, unique(state_stats$consol_name))
