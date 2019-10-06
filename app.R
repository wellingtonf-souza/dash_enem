library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)

header = dashboardHeader(title = "ENEM Analytics")

sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Início",tabName = "inicio",icon = icon("home")),
    menuItem("Metodologia",tabName = "metodologia",icon = icon("fas fa-info-circle")),
    menuItem("Análise geral",tabName = "analise_geral",icon = icon("fas fa-chart-bar")),
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
            h4(p("O ENEM, Exame Nacional do Ensino Médio, é uma avaliação anual desenvolvida
               pelo Inep, Instituto Nacional de Estudos e Pesquisas Educacionais Anísio 
               Teixeira. Tem entre seus objetivos permitir o acesso à educação superior, 
               a programas governamentais de financiamento e viabilizar o desenvolvimento
               de estudos e indicadores sobre a educação brasileira. Teve inicio em 1998 e 
               hoje é a principal avaliação em larga escala do país, sendo sua nota utilizada
               no Sisu, Sistema de Seleção Unificada. Esta é uma plataforma online do Ministério
               da Educação, MEC, que seleciona estudantes para instituições públicas de ensino 
               superior. Atualmente, o Sisu é a principal forma de ingresso nos cursos superiores,
               fato este que justifica os mais de 5,5 milhões de inscritos na edição de 2018.")),
            br(),
            h4(p("As análises apresentadas neste",em("dashboard"),"foram realizadas utilizando os 
               microdados do ENEM disponibilizados pelo",a(href = "http://portal.inep.gov.br/microdados",
               "Inep,"),"estes possibilitam aos pesquisadores
               avaliar a educação brasileira e consistem no menor nível de desagregação dos dados 
               do exame, apresentando todo conteúdo das avaliações realizadas e questionários 
               socioeconômicos respondidos, respeitando obviamente o sigilo dos participantes."))
           )
    )
  )
ui = dashboardPage(
  header,
  sidebar,
  body
)
server = function(input,output,session){
  
}

shinyApp(ui,server)
