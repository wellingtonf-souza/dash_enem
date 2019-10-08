library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(highcharter)
library(shinycssloaders)

amostra   = readRDS("amostra_2014_2017.rds")
nec_espec = readRDS("nec_espec_2014_2017.rds")

header = dashboardHeader(title = "ENEM Analytics")

sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Início",tabName = "inicio",icon = icon("home")),
    menuItem("Metodologia",tabName = "metodologia",icon = icon("fas fa-info-circle")),
    menuItem("Análise geral",tabName = "analise_geral",icon = icon("fas fa-chart-bar"),
             menuSubItem("Univariada",tabName = "univ")),
    menuItem("Condições especiais",tabName = "cond_especiais",icon = icon("fas fa-user-tag")),
    menuItem("LinkedIn",icon = icon("fab fa-linkedin"),
             href = "https://www.linkedin.com/in/wellington-ferr-souza/"),
    menuItem("Github",icon = icon("fab fa-github"),
             href = "https://github.com/wellingtonf-souza/")
  )
)
  
body = dashboardBody(
  tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Caviar Dreams", Arial;
        font-weight: bold
      }
    '))),
  #tags$li(tags$style(HTML('li { font-family: "Caviar Dreams", Arial; }'))),
  tags$div(tags$style(HTML('.box-header h3 { font-family: "Caviar Dreams", Arial;}'))),
  tags$div(tags$style(HTML('div { font-family: "Caviar Dreams", Arial;}'))),
  tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
  tabItems(
    tabItem(tabName = "inicio",
            HTML('<center><img src="enem_logo.png" class="img-responsive" width=80% height=80% ></center>'),
            class="active"),
    tabItem(tabName = "metodologia",
            h3(strong("Metodologia")),
            br(),
            h4("O ENEM, Exame Nacional do Ensino Médio, é uma avaliação anual desenvolvida
               pelo Inep, Instituto Nacional de Estudos e Pesquisas Educacionais Anísio 
               Teixeira. Tem entre seus objetivos permitir o acesso à educação superior, 
               a programas governamentais de financiamento e viabilizar o desenvolvimento
               de estudos e indicadores sobre a educação brasileira. Teve inicio em 1998 e 
               hoje é a principal avaliação em larga escala do país, sendo sua nota utilizada
               no Sisu, Sistema de Seleção Unificada. Esta é uma plataforma online do Ministério
               da Educação, MEC, que seleciona estudantes para instituições públicas de ensino 
               superior. Atualmente, o Sisu é a principal forma de ingresso nos cursos superiores,
               fato este que justifica os mais de 5,5 milhões de inscritos na edição de 2018."),
            br(),
            h4("As análises apresentadas neste",em("dashboard"),"foram realizadas utilizando os 
               microdados do ENEM disponibilizados pelo",a(href = "http://portal.inep.gov.br/microdados",
               "Inep."),"Estes possibilitam aos pesquisadores
               avaliar a educação brasileira e consistem no menor nível de desagregação dos dados 
               do exame, apresentando todo conteúdo das avaliações realizadas e questionários 
               socioeconômicos respondidos, respeitando obviamente o sigilo dos participantes."),
           br(),
           h4("Destaca-se que devido à grande quantidade de dados para a análise geral foi coletada
              em cada ano uma amostra aleatória de 100 mil indivíduos que efetivamente fizeram todas as provas, 
              ou seja, não faltaram nem foram eliminados de nenhuma das 4 provas e não tiveram sua redação
              invalidada. Já para a análise das condições especiais, todos os indivíduos que assinalaram 
              a condição e fizeram efetivamente todas as provas, bem como a redação, foram coletados."),
           br(),
           h4("Este aplicativo foi desenvolvido via linguagem de programação",
              a(href = "https://cran.r-project.org/","R"),"e pacote",
              a(href = "https://rstudio.github.io/shinydashboard/", "shinydashboard.")
           )
    ),
    tabItem(tabName = "univ",
            fluidRow(column(width = 2,
                            selectInput(inputId = "nota.geral",
                                        label = "Selecione uma nota:",
                                        choices = c("Ciências da Natureza"="NOTA_CN",
                                                    "Ciências Humanas"="NOTA_CH",
                                                    "Linguagens e Códigos" = "NOTA_LC",
                                                    "Matemática" = "NOTA_MT",
                                                    "Redação" = "NOTA_REDACAO"))),
                     column(width = 2,
                            selectInput(inputId = "ano.geral",
                                        label = "Selecione um ano:",
                                        choices = 2014:2017)),
                     column(width = 5,
                            selectInput(inputId = "var.geral",
                                        label = "Selecione uma variável:",
                                        choices = c("Dependência administrativa"="DEPENDENCIA_ADM_ESC",
                                                    "Localização"="LOCALIZACAO_ESC",
                                                    "Sexo"="SEXO",
                                                    "Situação de conclusão do Ensino Médio "="ST_CONCLUSAO",
                                                    "Cor/Raça"="COR_RACA",
                                                    "Até que série o pai, ou o homem responsável, estudou"="Q001",
                                                    "Até que série a mãe, ou a mulher responsável, estudou"="Q002",
                                                    "Renda mensal da família"="Q006",
                                                    "Tipo de escola que frequentou o Ensino Médio"="Q027")))
            ),
            fluidRow(box(width = 12,
                         title = "Boxplots das notas em relação às categorias da variável",
                         withSpinner(plotlyOutput("graf.boxplot.geral")))),
            fluidRow(box(width = 12,
                         title = "Densidade das notas em relação às categorias da variável",
                         withSpinner(plotlyOutput("graf.density.geral")))),
            fluidRow(box(width = 12,
                         title = "Quantitativo de indivíduos em relação às categorias da variável",
                         withSpinner(plotlyOutput("graf.quanti.geral"))))
    )
  )
)
ui = dashboardPage(
  header,
  sidebar,
  body
)
server = function(input,output,session){
  
  #=====================================
  # analise geral
  #=====================================
  output$graf.boxplot.geral = renderPlotly({
    g1 = amostra %>% 
      dplyr::select(input$nota.geral,input$var.geral,ANO) %>% 
      dplyr::filter(ANO==input$ano.geral) %>% na.omit() %>% 
      ggplot()+
      geom_boxplot(mapping = aes(!!sym(input$var.geral),
                                 !!sym(input$nota.geral),
                                 fill = !!sym(input$var.geral))) +
      theme_minimal() + 
      theme(legend.position='none') + coord_flip() + labs(fill = "") + xlab("") + ylab("")
      ggplotly(g1)
  })
  
  output$graf.density.geral = renderPlotly({
    g2 = amostra %>% 
      dplyr::select(input$nota.geral,input$var.geral,ANO) %>% 
      dplyr::filter(ANO==input$ano.geral) %>% na.omit() %>% 
      ggplot()+
      geom_density(mapping = aes(!!sym(input$nota.geral),
                                 fill = !!sym(input$var.geral)),alpha = 0.5) +
      theme_minimal() + labs(fill = "") + xlab("") + ylab("")
    ggplotly(g2)
  })
  
  output$graf.quanti.geral = renderPlotly({
    set.seed(12345)
    g3 = amostra %>% 
      dplyr::select(input$nota.geral,input$var.geral,ANO) %>% 
      dplyr::filter(ANO==input$ano.geral) %>% na.omit() %>% 
      ggplot(mapping = aes(!!sym(input$var.geral)))+
      geom_bar(aes(fill=!!sym(input$var.geral)),col = "black") + 
      theme_minimal() + labs(fill = "") +
      theme(legend.position='none') +
      coord_flip() + xlab("") + ylab("")
    ggplotly(g3,tooltip = c("x","y"))
  })
  
}

shinyApp(ui,server)
