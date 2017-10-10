

shinyUI(dashboardPage(
    dashboardHeader(title = "My Dashboard"),
    dashboardSidebar(
        
        sidebarUserPanel("NYC DSA",
                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
        sidebarMenu(
            menuItem("Map", tabName = "map", icon = icon("map")),
            menuItem("Histogram", tabName = "histogram", icon = icon("bar-chart")),
            menuItem("Data", tabName = "data", icon = icon("database"))
        ),
        selectizeInput("selected",
                       "Select Item to Display",
                       choice)
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "map",
                    fluidRow(infoBoxOutput("maxBox"),
                             infoBoxOutput("minBox"),
                             infoBoxOutput("avgBox")),
                    fluidRow(box(htmlOutput("map"), height = 300, width = 12))),
            tabItem(tabName = "histogram",
                    plotOutput("hist")),
                    # for gvis: fluidRow(box(htmlOutput("hist"), height = 300, width = 12))), #end of 2nd tab
            tabItem(tabName = "data",
                    fluidRow(box(DT::dataTableOutput("table"), width = 12)))
        )
    )
))