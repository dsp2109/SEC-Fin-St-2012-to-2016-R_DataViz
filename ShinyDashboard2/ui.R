

shinyUI(dashboardPage(
                      skin = "black",  
                      dashboardHeader(title = "SEC Financial St Data"),
                      
                      dashboardSidebar(
                        
                        sidebarUserPanel("Fin St by: Yr, Indstr",
                                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
                        sidebarMenu(
                          h5("Public Filing Overview"),
                          menuItem("Filings by year", tabName = "filings", icon = icon("bar-chart")),

                          menuItem("Histogram", tabName = "histogram", icon = icon("bar-chart")),
                          h5("Financials through time"),
                          menuItem("Financial St. Data", tabName = "columns", icon = icon("bar-chart")),
    
                          h5("Financial Ratio Analysis"),
                          menuItem("Scatter by Co", tabName = "scatter", icon = icon("braille")),
                          menuItem("Scatter by Industry", tabName = "scatter_ind", icon = icon("braille")),
                          menuItem("Financial Ratios", tabName = "ratios", icon = icon("calculator")),
                          h5("By State"),
                          menuItem("Map", tabName = "map", icon = icon("map")),
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
                                  
                          tabItem(tabName = "histogram",
                                  selectizeInput("in_yr",
                                                 "Select Year to Display",
                                                 c(2012, 2013,2014,2015, 2016), selected = 2016),
                                  selectizeInput("fin_metr",
                                                 "Select Line Item to Display",
                                                 fin_st_choice, selected = 'Assets'),
                                  plotlyOutput("hist")),                          

                                  tabItem(tabName = "columns",
                                          # selectizeInput("selected",
                                          #                "Select Industry to Display",
                                          #                choice, selected = ''),
                                          selectizeInput("fin_metr",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Assets'),
                                          plotlyOutput("dens_gg", height = 330),
                                          plotlyOutput("col_gg", height = 500)
                                          
  
                                          ), #end columns
                                  
                                  tabItem(tabName = "ratios",
                                          h3("UNDER CONSTRUCTION"),
                                          
                        
                                          selectizeInput("fin1",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Revenues'),
                                          selectizeInput("in_yr",
                                                         "Select Year to Display",
                                                         c(2012, 2013,2014,2015, 2016), selected = 2016),
                                          selectizeInput("fin2",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Assets'),
                                          selectizeInput("in_yr2",
                                                         "Select Year to Display",
                                                         c(2012, 2013,2014,2015, 2016), selected = 2016),
                                          plotlyOutput("ratio_hist", height = 400)
                                          ), #end scatter co
                          
                          tabItem(tabName = "scatter_ind",
                                  
                                  selectizeInput("fin1",
                                                 "Select Line Item to Display",
                                                 fin_choice, selected = 'Revenues'),
                                  selectizeInput("fin2",
                                                 "Select Line Item to Display",
                                                 fin_choice, selected = 'Assets'),
                                  plotlyOutput("scat_ind", height = 600)
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
                            

                            # for gvis: fluidRow(box(htmlOutput("hist"), height = 300, width = 12))), #end of 2nd tab
                            tabItem(tabName = "data",
                                    fluidRow(box(DT::dataTableOutput("table"), width = 12)))
                          
                          
                          ) 
                          )
                        )
)