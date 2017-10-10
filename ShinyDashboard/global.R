library(shiny)
library(shinydashboard)
library(shinythemes)
library(DT)
library(googleVis)
library(ggplot2)
library(dplyr)

load("Data/shiny_sec_data.rda")
# remove row names
rownames(state_stat) <- NULL
# create variable with colnames as choice
choice <- colnames(state_stat)[-1]