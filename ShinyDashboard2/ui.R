

shinyUI(dashboardPage(
                      skin = "black",  
                      dashboardHeader(title = "SEC Financial St Data"),
                      
                      dashboardSidebar(
                        
                        sidebarUserPanel("Fin St by: Yr, Indstr",
                                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
                        sidebarMenu(
                          h5("Public Filing Overview"),
                          menuItem("Filings by year", tabName = "filings", icon = icon("bar-chart")),
                          menuItem("Financial St. Data", tabName = "columns", icon = icon("bar-chart")),
                          h5("Financial Ratios"),
                          menuItem("Scatter by Co", tabName = "scatter", icon = icon("line-chart")),
                          menuItem("Scatter by Indstry", tabName = "scatter_ind", icon = icon("line-chart")),
                          h5("By State"),
                          menuItem("Map", tabName = "map", icon = icon("map")),
                          menuItem("Histogram", tabName = "histogram", icon = icon("bar-chart")),
                          menuItem("Data", tabName = "data", icon = icon("database"))
                        )
                      ),
                      
                      dashboardBody(
                        tags$head(
                          tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                        ),
                        
                        tabItems(
                          tabItem(tabName = "filings",
                                  h1(plotOutput('gg1')),
                                  plotOutput("gg2"),
                                  plotOutput("gg3")
                                  ), #end filings
                                  
                          

                                  tabItem(tabName = "columns",
                                          # selectizeInput("selected",
                                          #                "Select Industry to Display",
                                          #                choice, selected = ''),
                                          selectizeInput("fin_metr",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Assets'),
                                          plotOutput("col_gg", height = 800)
                                          
  
                                          ), #end columns
                                  
                                  tabItem(tabName = "scatter",
                        
                                          selectizeInput("fin1",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Revenues'),
                                          selectizeInput("fin2",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Assets'),
                                          plotlyOutput("scat_gg")
                                          ), #end scatter co
                          
                          tabItem(tabName = "scatter_ind",
                                  
                                  selectizeInput("fin1",
                                                 "Select Line Item to Display",
                                                 fin_choice, selected = 'Revenues'),
                                  selectizeInput("fin2",
                                                 "Select Line Item to Display",
                                                 fin_choice, selected = 'Assets'),
                                  plotlyOutput("scat_ind")
                          ), #end scatter ind
                          
                          
                          
                          ############ by state tabs
                            tabItem(tabName = "map",
                                    selectizeInput("selected",
                                                   "Select Item to Display",
                                                   choice, selected = 'total'),
                                    selectizeInput("fin_metr",
                                                   "Select Line Item to Display",
                                                   fin_choice, selected = 'Assets'),
                                    fluidRow(infoBoxOutput("maxBox"),
                                             infoBoxOutput("minBox"),
                                             infoBoxOutput("avgBox")),
                                    fluidRow(box(htmlOutput("map"), height = 500, width = 12))
                                    ),
                            
                            tabItem(tabName = "histogram",
                                    selectizeInput("selected",
                                                   "Select Item to Display",
                                                   choice, selected = 'total'),
                                    selectizeInput("fin_metr",
                                                   "Select Line Item to Display",
                                                   fin_st_choice, selected = 'Assets'),
                                    plotOutput("hist")),
                            # for gvis: fluidRow(box(htmlOutput("hist"), height = 300, width = 12))), #end of 2nd tab
                            tabItem(tabName = "data",
                                    fluidRow(box(DT::dataTableOutput("table"), width = 12)))
                          
                          
                          ) 
                          )
                        )
)