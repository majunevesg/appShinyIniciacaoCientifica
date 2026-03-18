library(shiny)
library(shinydashboard)
library(GGally)
library(ggplot2)
library(broom)
library(mfx)

ui <- dashboardPage(
  dashboardHeader(title = "Análise de Dados sobre saúde"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Sobre", tabName = "sobre", icon = icon("info-circle")),
      menuItem("Seleção do Arquivo", tabName = "dados", icon = icon("file-upload")),
      menuItem("Ajuste do Modelo", tabName = "model", icon = icon("cogs")),
      menuItem("Análise de Diagnóstico", tabName = "adiag", icon = icon("chart-bar"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "sobre",
              h2("Sobre"),
              tags$p("O aplicativo foi desenvolvido em um projeto de Iniciação Científica, com intuito 
                     de implementar novas técnicas de Estatística nas pesquisas em saúde"),
              tags$p("A seguir são apresentados os artigos que motiviram e auxiliaram nosso estudo."),
              h3("Referências"),
              h3("Contato"),
              tags$p(strong("Desenvolvedora :"), "Maria Júlia Neves Gregório"),
              tags$p(" maju-neves@hotmail.com"),
              tags$p(strong("Orientador :"), tags$a(href="http://lattes.cnpq.br/7953363504273397", "Tiago Maia Magalh?es"))
              
              ),
      
      tabItem(tabName = "dados",
              h2("Seleção do Arquivo"),
              
              fluidRow(
                box(
                  fileInput(inputId="arquivo", "Selecione o arquivo",accept = ".csv"),
                  checkboxInput("header", "Header", TRUE),
                  checkboxInput("mostra", "Mostrar", FALSE)
                ),
                box(
                  title = "Observações",
                  "O arquivo precisa estar no formato CSV.",
                  br(),
                  "A primeira coluna deverá conter a variável resposta, sendo ela binaria
                  (assumindo 0 ou 1), e as demais, as variáveis explicativas. Além disso, a primeira 
                  linha deverá conter o nome das variáveis. "
                )
                ),
              
              fluidRow(
                box(
                  title ="Dados", 
                  tableOutput("dados"),
                  width = 12
                )
              )
                ),
      
      tabItem(tabName = "model",
              h2("Ajuste do Modelo"),
              
              fluidRow(
                box(
                  title = "Modelo Ajustado",
                  verbatimTextOutput("model")
                ),
                box(
                  title = "Razão de Chances",
                  selectInput(inputId = "varodds", "Selecione a variável explicativa que você deseja associar a resposta", choices = ""),
                  verbatimTextOutput("odds")
                )
              ),
              
              fluidRow(
                box(
                  title = "Seleção das variáveis não significativas",
                  selectInput(inputId = "insi", "Selecione as variaveis não significativas", choices = "" ,multiple = TRUE ),
                  actionButton(inputId = "acao", label = "Refaça o modelo")
                )
              )
              
      ),
      
      tabItem(tabName = "adiag",
              h2("Análise de Diagnóstico"),
              plotOutput("adiag")
      )
      )
)
)

server <- function(input, output, session) {
  
  k <- reactive({
    if(is.null(input$arquivo))     return(NULL)
    k <- read.csv(input$arquivo$datapath, header = TRUE, stringsAsFactors = FALSE)
    
    updateSelectInput(session = session, inputId = "insi", choices = names(k[-1]))
    
    updateSelectInput(session = session, inputId = "varodds", choices = names(k[-1]))
    
    return(k)
  })
  
  output$dados <- renderTable({
    k <- req(k())
    
    if(input$mostra==TRUE){
      if (input$header==TRUE)
      {
        return(head(k))
      }
      else {
        return(k)
      }
    }
    
    
  })
  
  output$model <- renderPrint({
    k <- req(k())
    
    if (input$acao == TRUE){
      
      y <- k[, 1]
      x <- k[, -1]
      real.cols = colnames(x)
      
      insi <- input$insi
      x <- data.frame(x[ , -which(real.cols %in% insi)])
      mData <- data.frame(Y = y, X = x)
      
      mod <- glm(Y ~ ., data = mData, family = binomial)
      
      print(summary(mod))
    }
    else{
      
      y <- k[, 1]
      x <- k[, -1]
      
      mData <- data.frame(Y = y, X = x)
      real.cols = colnames(x)
      
      mod <- glm(Y ~ ., data = mData, family = binomial)
      
      print(summary(mod))
    }
    
    output$adiag <- renderPlot({
      ggnostic(mod)
    })
    
  })
  
  output$odds <- renderPrint({
    k <- req(k())
    y <- k[, 1]
    x <- k[, -1]
    
    real.cols = colnames(x)
    varodds <- input$varodds
    x <- x[ , which(real.cols %in% varodds)]
    mData <- data.frame(Y = y, X = x)
    
    logitor(Y ~ ., data = mData)
  })
  
  
}

shinyApp(ui, server)

