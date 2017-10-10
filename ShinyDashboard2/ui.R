

shinyUI(dashboardPage(skin = "black",
                      dashboardHeader(title = "SEC Financial St Data"),
                      dashboardSidebar(
                        
                        sidebarUserPanel("SEC Data by Year and Industry",
                                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
                        sidebarMenu(
                          menuItem("Filings", tabName = "filings", icon = icon("map")),
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
                                  plotOutput("gg1"),
                                  plotOutput("gg2"),
                                  fluidRow(infoBoxOutput("maxBox"),
                                           infoBoxOutput("minBox"),
                                           infoBoxOutput("avgBox")),
                                  
                                  tabItem(tabName = "columns",
                                          
                                          plotOutput("hist")),
                                  
                                  
                                  
                                  tabItem(tabName = "scatter",
                                          fluidRow(box(DT::dataTableOutput("table"), width = 12)))
                          )
                        )
                      )
))
