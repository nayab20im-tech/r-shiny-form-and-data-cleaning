library(shiny)

ui <- fluidPage(
  div(
    style = "width: 70vw; min-height: 100vh; margin: 5vh auto;
             padding: 30px; border-radius: 10px; overflow-y: auto;",

    h2("User Information Form", align = "center"),
    br(),

    fluidRow(
      column(6, textInput("name", "Enter Your Full Name")),
      column(6, textAreaInput("personal_info", "Enter Your Personal Details"))
    ),

    fluidRow(
      column(6, passwordInput("password", "Enter Your Password")),
      column(6, numericInput("age", "Enter Your Age", value = 25, min = 18, max = 55))
    ),

    fluidRow(
      column(6, sliderInput("experience", "Years of Experience", 0, 40, 5)),
      column(6, sliderInput("contract_duration", "Contract Duration (Years)", 0, 10, c(1, 5)))
    ),

    fluidRow(
      column(6, dateInput("dob", "Date Of Birth", value = "2000-01-01")),
      column(6, dateRangeInput("vacation_period", "Vacation Period"))
    ),

    fluidRow(
      column(6, selectInput(
        "languages", "Programming Languages",
        choices = c("Python", "R", "Java", "C++", "JavaScript"),
        multiple = TRUE
      )),
      column(6, checkboxGroupInput(
        "hobbies", "Hobbies",
        choices = c("Reading", "Gaming", "Traveling", "Music", "Sports")
      ))
    ),

    checkboxInput("available", "Available for Side Job"),

    fluidRow(
      column(6, fileInput("resume", "Upload Resume", accept = c(".pdf", ".docx"))),
      column(6, fileInput("id_proof", "Upload ID Proof", accept = c(".pdf", ".jpg", ".png")))
    ),

    div(
      style = "text-align:center; margin-top:20px;",
      actionButton("submit", "Submit", class = "btn btn-primary"),
      actionButton("cancel", "Cancel", class = "btn btn-danger"),
      actionButton("home", "Return Home", class = "btn btn-secondary")
    ),

    h3("Submitted Information", align = "center"),
    tableOutput("form_table")
  )
)

server <- function(input, output, session) {

  user_data <- reactive({
    validate(
      need(input$age >= 18 && input$age <= 55, "Age must be between 18 and 55.")
    )

    list(
      Name = input$name,
      Age = input$age,
      Experience = input$experience,
      Languages = paste(input$languages, collapse = ", "),
      Available = ifelse(input$available, "Yes", "No")
    )
  })

  output$form_table <- renderTable({
    req(input$submit)
    data <- user_data()
    data.frame(Field = names(data), Value = unlist(data))
  })

  observeEvent(input$submit, {
    showModal(modalDialog("Form submitted successfully!", easyClose = TRUE))
  })

  observeEvent(input$cancel, {
    updateTextInput(session, "name", "")
    updateNumericInput(session, "age", 25)
    showModal(modalDialog("Form cleared", easyClose = TRUE))
  })

  observeEvent(input$home, {
    showModal(modalDialog("Returning to home", easyClose = TRUE))
  })
}

shinyApp(ui = ui, server = server)
