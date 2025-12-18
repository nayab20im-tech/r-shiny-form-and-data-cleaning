library(pillar)
library(shiny)
library(janitor)   # For clean_names()
library(dplyr)     # For data manipulation
library(readr)     # For CSV reading

ui <- fluidPage(
  titlePanel("Interactive Data Cleaning Tool"),

  sidebarLayout(
    sidebarPanel(
      h4("1. Upload Data"),
      fileInput("file", "Upload CSV File"),
      textInput("delimiter", "Delimiter (leave blank to auto-detect)", value = ""),
      numericInput("skip", "Skip Rows", value = 0, min = 0),
      numericInput("preview", "Rows to Preview", value = 5, min = 1),
      hr(),

      h4("2. Data Cleaning Options"),
      checkboxInput("snake_case", "Rename columns to snake_case"),
      checkboxInput("remove_constant", "Remove constant columns"),
      checkboxInput("remove_na", "Remove rows with null values"),
      hr(),

      h4("3. Download Cleaned Data"),
      downloadButton("download", "Download Cleaned CSV")
    ),

    mainPanel(
      h4("Raw Data Preview"),
      tableOutput("raw_preview"),
      hr(),
      h4("Cleaned Data Preview"),
      tableOutput("clean_preview")
    )
  )
)

server <- function(input, output, session) {

  raw_data <- reactive({
    req(input$file)
    delim <- ifelse(input$delimiter == "", NULL, input$delimiter)

    tryCatch({
      read_delim(
        input$file$datapath,
        delim = delim,
        skip = input$skip,
        n_max = input$preview,
        show_col_types = FALSE
      )
    }, error = function(e) {
      data.frame(Error = "Failed to read file. Check delimiter or file format.")
    })
  })

  output$raw_preview <- renderTable({
    raw_data()
  })

  full_data <- reactive({
    req(input$file)
    delim <- ifelse(input$delimiter == "", NULL, input$delimiter)

    read_delim(
      input$file$datapath,
      delim = delim,
      skip = input$skip,
      show_col_types = FALSE
    )
  })

  cleaned_data <- reactive({
    df <- full_data()

    if (input$snake_case)
      df <- clean_names(df)

    if (input$remove_constant)
      df <- df[, sapply(df, function(x) length(unique(x)) > 1)]

    if (input$remove_na)
      df <- na.omit(df)

    df
  })

  output$clean_preview <- renderTable({
    head(cleaned_data(), input$preview)
  })

  output$download <- downloadHandler(
    filename = function() {
      paste0("cleaned_data_", Sys.Date(), ".csv")
    },
    content = function(file) {
      write_csv(cleaned_data(), file)
    }
  )
}

shinyApp(ui = ui, server = server)
