

shinyUI(dashboardPage(
                      dashboardHeader(title = "SEC Financial St Data"),
                      
                      dashboardSidebar(
                        
                        sidebarUserPanel("Fin St by: Yr, Indstr",
                                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
                        sidebarMenu(
                          menuItem("Filings by year", tabName = "filings", icon = icon("bar-chart")),
                          menuItem("Financial St. Data", tabName = "columns", icon = icon("bar-chart")),
                          menuItem("Scatter by Co", tabName = "scatter", icon = icon("database"))
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
                                          selectizeInput("selected",
                                                         "Select Industry to Display",
                                                         choice, selected = ''),
                                          selectizeInput("fin_metr",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Assets')
                                          
  
                                          ), #end columns
                                  
                                  tabItem(tabName = "scatter",
                        
                                          selectizeInput("selected",
                                                         "Select Item to Display",
                                                         choice, selected = 'total'),
                                          selectizeInput("fin_metr",
                                                         "Select Line Item to Display",
                                                         fin_choice, selected = 'Assets')) #end scatter
                          ) 
                          )
                        )
)