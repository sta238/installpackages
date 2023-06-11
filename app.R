library(shiny)


ae_nums <- c("1")

ae_links <- paste0(
  "https://r.datatools.utoronto.ca/hub/user-redirect/git-pull?",
  "repo=https%3A%2F%2Fgithub.com%2Fsta238%2Fae",
  ae_nums,
  "&urlpath=shiny%2Fae",
  ae_nums,
  "%2F&branch=main"
)


server <- function(input, output) {
  output$result <- renderText({
    withProgress(message = 'Checking required packages', value = 0, {
      if (!require(learnr)) {
        incProgress(NULL, detail = "Installing learnr")
        incProgress(install.packages("learnr"), detail = "Installing learnr")
      }
      if (!require(kableExtra)) {
        incProgress(NULL, detail = "Installing kableExtra")
        incProgress(install.packages("kableExtra"), detail = "Installing kableExtra")
      }
    })
    if (require(learnr) & require(kableExtra)) {
      "`learnr` and `kableExtra` installed."
    }
  })
}

ui <- shinyUI(fluidPage(
  hr(),
  div(em(textOutput('result'))),
  hr(),
  fluidRow(
    column(
      6,
      h2("Analysis Exercises"),
      HTML(
        paste0("<div><ul>",
               paste0("<li><a href='", ae_links, "' target='_blank'>Analysis Exercises ", 
                      ae_nums, "</a></li>"),
               "</ul></div>")
      )     
    ),
    column(
      6,
      h2("Analysis Exercises"),
      HTML(
        paste0("<div><ul>",
               paste0("<li><a href='", ae_links, "' target='_blank'>Analysis Exercises ", 
                      ae_nums, "</a></li>"),
               "</ul></div>")
      )     
    )
  )
))

shinyApp(ui = ui, server = server)