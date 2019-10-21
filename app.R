
source("global.R")

amostra   = readRDS("amostra_2014_2018.rds")
nec_espec = readRDS("nec_espec_2014_2018.rds")

header = dashboardHeader(title = "ENEM Analytics")

sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Início",tabName = "inicio",icon = icon("home")),
    menuItem("Metodologia",tabName = "metodologia",icon = icon("fas fa-info-circle")),
    menuItem("Análise geral",tabName = "analise_geral",icon = icon("fas fa-chart-bar"),
             menuSubItem("Univariada",tabName = "univ"),
             menuSubItem("Bivariada" ,tabName = "bivariada"),
             menuSubItem("Gráficos de série temporal",tabName = "time_series"),
             menuSubItem("Mapas",tabName = "mapa")),
    menuItem("Condições especiais",tabName = "cond_especiais",icon = icon("fas fa-user-tag")),
    menuItem("LinkedIn",icon = icon("fab fa-linkedin"),
             href = "https://www.linkedin.com/in/wellington-ferr-souza/"),
    menuItem("Github",icon = icon("fab fa-github"),
             href = "https://github.com/wellingtonf-souza/dash_enem")
  )
)
  
body = dashboardBody(
  tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
  tabItems(
    tabItem(tabName = "inicio",
            HTML('<center><img src="enem_logo.png" class="img-responsive" width=80% height=80% ></center>'),
            class="active"),
    tabItem(tabName = "metodologia",
            h3(strong("Metodologia")),
            br(),
            h4("O ENEM, Exame Nacional do Ensino Médio, é uma avaliação anual desenvolvida
               pelo Inep que tem entre seus objetivos permitir o acesso à educação superior, 
               a programas governamentais de financiamento e viabilizar o desenvolvimento
               de estudos e indicadores sobre a educação brasileira. Teve inicio em 1998 e 
               hoje é a principal avaliação em larga escala do país, sendo sua nota utilizada
               no Sisu, Sistema de Seleção Unificada. Esta é uma plataforma online do Ministério
               da Educação que seleciona estudantes para instituições públicas de ensino 
               superior. Atualmente o Sisu é a principal forma de ingresso nos cursos superiores,
               fato este que justifica os mais de 5,5 milhões de inscritos na edição de 2018."),
            br(),
            h4("As análises apresentadas neste",em("dashboard"),"foram realizadas utilizando os 
               microdados do ENEM disponibilizados pelo",a(href = "http://portal.inep.gov.br/microdados",
               "Inep."),"Estes possibilitam aos pesquisadores
               avaliar a educação brasileira e consistem no menor nível de desagregação dos dados 
               do exame, apresentando todo conteúdo das avaliações realizadas e questionários 
               socioeconômicos respondidos, respeitando obviamente o sigilo dos participantes."),
           br(),
           h4("Destaca-se que devido à grande quantidade de dados, para a análise geral foi coletado
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
                            selectInput(inputId = "nota.uni",
                                        label = "Selecione uma nota:",
                                        choices = c("Ciências da Natureza"="NOTA_CN",
                                                    "Ciências Humanas"="NOTA_CH",
                                                    "Linguagens e Códigos" = "NOTA_LC",
                                                    "Matemática" = "NOTA_MT",
                                                    "Redação" = "NOTA_REDACAO"))),
                     column(width = 2,
                            selectInput(inputId = "ano.uni",
                                        label = "Selecione um ano:",
                                        choices = 2014:2018)),
                     column(width = 5,
                            selectInput(inputId = "var.uni",
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
            fluidRow(box(width = 12,collapsible=TRUE,
                         title = "Boxplots das notas em relação às categorias da variável",
                         withSpinner(plotlyOutput("graf.boxplot.uni")))),
            fluidRow(box(width = 12,collapsible=TRUE,
                         title = "Densidade das notas em relação às categorias da variável",
                         withSpinner(plotlyOutput("graf.density.uni")))),
            fluidRow(box(width = 12,collapsible=TRUE,
                         title = "Quantitativo de indivíduos em relação às categorias da variável",
                         withSpinner(plotlyOutput("graf.quanti.uni"))))
    ),
    tabItem(tabName = "bivariada",
            fluidRow(column(width = 2,
                            selectInput(inputId = "nota.biv",
                                        label = "Selecione uma nota:",
                                        choices = c("Ciências da Natureza"="NOTA_CN",
                                                    "Ciências Humanas"="NOTA_CH",
                                                    "Linguagens e Códigos" = "NOTA_LC",
                                                    "Matemática" = "NOTA_MT",
                                                    "Redação" = "NOTA_REDACAO"))),
                     column(width = 2,
                            selectInput(inputId = "ano.biv",
                                        label = "Selecione um ano:",
                                        choices = 2014:2018)),
                     column(width = 3,
                            selectInput(inputId = "var.biv",
                                        label = "Selecione a primeira variável:",
                                        choices = c("Renda mensal da família"="Q006",
                                                    "Localização"="LOCALIZACAO_ESC",
                                                    "Sexo"="SEXO",
                                                    "Situação de conclusão do Ensino Médio "="ST_CONCLUSAO",
                                                    "Cor/Raça"="COR_RACA",
                                                    "Até que série o pai, ou o homem responsável, estudou"="Q001",
                                                    "Até que série a mãe, ou a mulher responsável, estudou"="Q002",
                                                    "Tipo de escola que frequentou o Ensino Médio"="Q027"))),
                     uiOutput("segunda.var")
            ),
            fluidRow(
              HTML('<div class="col-sm-12">
                   <div class="box">
                   <div class="box-header">
                   <h3 class="box-title">Heatmap das notas médias dos grupos</h3>
                   </div>
                   <div class="box-body">
                   <script src="assets/spinner.js"></script>
                   <div class="shiny-spinner-output-container">
                   <div class="load-container load1">
                   <div id="spinner-0434c3bd3dfcd8a1fdb8955de224d747" class="loader">Loading...</div>
                   </div>
                   <div id="graf.heatmap" style="width:100%; height:650px; " class="plotly html-widget html-widget-output shiny-report-size"></div>
                   </div>
                   </div>
                   </div>
                   </div>')
                     )
            ),
    tabItem(tabName = "time_series",
            fluidRow(column(width = 3,
                            selectInput(
                              inputId = "var_time_serie",
                              label = "Selecione uma variável:",
                              choices = c("Dependência administrativa"="DEPENDENCIA_ADM_ESC",
                                          "Localização"="LOCALIZACAO_ESC",
                                          "Sexo"="SEXO",
                                          "Situação de conclusão do Ensino Médio "="ST_CONCLUSAO",
                                          "Cor/Raça"="COR_RACA",
                                          "Até que série o pai, ou o homem responsável, estudou"="Q001",
                                          "Até que série a mãe, ou a mulher responsável, estudou"="Q002",
                                          "Renda mensal da família"="Q006",
                                          "Tipo de escola que frequentou o Ensino Médio"="Q027"))
                            )
                            ),
            fluidRow(box(title = "Nota média de matemática no decorrer dos anos",
                         width = 12,collapsible=TRUE,
                         withSpinner(plotlyOutput("graf_serie_mat"))
                         )
                     ),
            fluidRow(box(title = "Nota média de ciências da natureza no decorrer dos anos",
                         width = 12,collapsible=TRUE,
                         withSpinner(plotlyOutput("graf_serie_cn"))
                         )
                     ),
            fluidRow(box(title = "Nota média de ciências humanas no decorrer dos anos",
                         width = 12,collapsible=TRUE,
                         withSpinner(plotlyOutput("graf_serie_ch"))
                         )
                     ),
            fluidRow(box(title = "Nota média de linguagens e códigos no decorrer dos anos",
                         width = 12,collapsible=TRUE,
                         withSpinner(plotlyOutput("graf_serie_lc"))
                         )
                     ),
            fluidRow(box(title = "Nota média de redação no decorrer dos anos",
                         width = 12,collapsible=TRUE,
                         withSpinner(plotlyOutput("graf_serie_red"))
                         )
                     )
            ),
    tabItem(tabName = "mapa",
            fluidRow(column(width = 3,
                            selectInput(
                              inputId = "ano_mapa",
                              label = "Selecione um ano:",
                              choices = 2014:2018)
                            ),
                     column(width = 3,
                            selectInput(
                              inputId = "nota_mapa",
                              label = "Selecione uma nota:",
                              choices = c("Ciências da Natureza"="NOTA_CN",
                                          "Ciências Humanas"="NOTA_CH",
                                          "Linguagens e Códigos" = "NOTA_LC",
                                          "Matemática" = "NOTA_MT",
                                          "Redação" = "NOTA_REDACAO")
                              )
                            )
                     ),
            fluidRow(box(title = "Nota média por estado",
                         width = 6,collapsible=TRUE,
                         withSpinner(highchartOutput("mapa_nota_media"))),
                     box(title = "Participação por estado",
                         width = 6,collapsible=TRUE,
                         withSpinner(highchartOutput("mapa_participantes"))))
            ),
    tabItem(tabName = "cond_especiais",
            fluidRow(column(width = 3,
                            selectInput(
                              inputId = "ano_cond_especiais",
                              label = "Selecione um ano:",
                              choices = 2014:2018)
            ),
            column(width = 3,
                   selectInput(
                     inputId = "nota_cond_especiais",
                     label = "Selecione uma nota:",
                     choices = c("Ciências da Natureza" = "NOTA_CN",
                                 "Ciências Humanas" = "NOTA_CH",
                                 "Linguagens e Códigos" = "NOTA_LC",
                                 "Matemática" = "NOTA_MT",
                                 "Redação" = "NOTA_REDACAO")
                     )
                   ),
            column(width = 3,
                   selectInput(
                     inputId = "cond_espec_selected",
                     label = "Selecione uma condição:",
                     choices = c("Baixa Visão"="BAIXA_VISAO",
                                 "Cegueira" = "CEGUEIRA",
                                 "Surdez" = "SURDEZ",
                                 "Deficiência Física" = "DEFICIENCIA_FISICA",
                                 "Autismo" = "AUTISMO")
                   ))
            ),
            fluidRow(box(width = 6,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Dependência administrativa"),
                         collapsible = T,withSpinner(plotlyOutput("depend_adm_esc_nec_espe_plot"))),
                     box(width = 6,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Localização"),
                         collapsible = T,withSpinner(plotlyOutput("localizacao_esc_nec_espe_plot")))
                     ),
            fluidRow(box(width = 6,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Sexo"),
                         collapsible = T,withSpinner(plotlyOutput("sexo_nec_espe_plot"))),
                     box(width = 6,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Cor/Raça"),
                         collapsible = T,withSpinner(plotlyOutput("cor_nec_espe_plot")))
                     ),
            fluidRow(box(width = 6,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Instrução do pai"),
                         collapsible = T,withSpinner(plotlyOutput("q001_nec_espe_plot"))),
                     box(width = 6,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Instrução da mãe"),
                         collapsible = T,withSpinner(plotlyOutput("q002_nec_espe_plot")))
                     ),
            fluidRow(box(width = 12,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Renda"),
                         collapsible = T,withSpinner(plotlyOutput("renda_nec_espe_plot")))
                     ),
            fluidRow(box(width = 12,
                         title = HTML("Grupo com a condição especial <em> vs </em> geral - Escola do ensino médio"),
                         collapsible = T,withSpinner(plotlyOutput("escola_nec_espe_plot")))
                     ),
            fluidRow(box(width = 12,
                         title = HTML("Participantes com a condição especial no decorrer dos anos"),
                         collapsible = T,withSpinner(plotlyOutput("particip_nec_esp")))
            )
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
  # analise geral - Univariada
  #=====================================
  output$graf.boxplot.uni = renderPlotly({
    g1 = amostra %>% 
      dplyr::select(input$nota.uni,input$var.uni,ANO) %>% 
      dplyr::filter(ANO==input$ano.uni&!!sym(input$var.uni)!="") %>% na.omit() %>% 
      ggplot()+
      geom_boxplot(mapping = aes(!!sym(input$var.uni),
                                 !!sym(input$nota.uni),
                                 fill = !!sym(input$var.uni))) +
      theme_minimal() + 
      theme(legend.position='none') + coord_flip() + labs(fill = "") + xlab("") + ylab("")
      ggplotly(g1)
  })
  
  output$graf.density.uni = renderPlotly({
    g2 = amostra %>% 
      dplyr::select(input$nota.uni,input$var.uni,ANO) %>% 
      dplyr::filter(ANO==input$ano.uni&!!sym(input$var.uni)!="") %>% na.omit() %>%
      ggplot()+
      geom_density(mapping = aes(!!sym(input$nota.uni),
                                        fill=!!sym(input$var.uni)),alpha = 0.5) +
      theme_minimal() + labs(fill = "") + xlab("") + ylab("") 
    ggplotly(g2,tooltip = c("fill"))
  })
  
  output$graf.quanti.uni = renderPlotly({
    g3 = amostra %>% 
      dplyr::select(input$nota.uni,input$var.uni,ANO) %>% 
      dplyr::filter(ANO==input$ano.uni&!!sym(input$var.uni)!="") %>% na.omit() %>% 
      ggplot(mapping = aes(!!sym(input$var.uni)))+
      geom_bar(aes(fill=!!sym(input$var.uni)),col = "black") + 
      theme_minimal() + labs(fill = "") +
      theme(legend.position='none') +
      coord_flip() + xlab("") + ylab("")
    ggplotly(g3,tooltip = c("x","y"))
  })
  #=====================================
  # analise geral - bivariada
  #=====================================
  
  output$segunda.var = renderUI({
    
    escolhas = c("Tipo de escola que frequentou o Ensino Médio"="Q027",
                 "Cor/Raça"="COR_RACA",
                 "Localização"="LOCALIZACAO_ESC",
                 "Sexo"="SEXO",
                 "Situação de conclusão do Ensino Médio "="ST_CONCLUSAO",
                 "Até que série o pai, ou o homem responsável, estudou"="Q001",
                 "Até que série a mãe, ou a mulher responsável, estudou"="Q002",
                 "Renda mensal da família"="Q006")
    escolhas = escolhas[-which(escolhas==input$var.biv)]
    column(width = 3,
           selectInput(inputId = "segunda.var.resp",
                       label = "Selecione a segunda variável:",
                       choices = escolhas))
  })
  
  output$graf.heatmap = renderPlotly({
    g4 = amostra %>% 
      dplyr::select(input$nota.biv,input$var.biv,input$segunda.var.resp,ANO) %>% 
      dplyr::filter(ANO==input$ano.biv&!!sym(input$var.biv)!=""&!!sym(input$segunda.var.resp)!="") %>% 
      na.omit() %>% 
      group_by(!!sym(input$var.biv),!!sym(input$segunda.var.resp)) %>% 
      summarise(nota_media = mean(!!sym(input$nota.biv))) %>% 
      ggplot(aes(!!sym(input$var.biv), !!sym(input$segunda.var.resp), fill= nota_media)) + 
      geom_tile() + xlab("") + ylab("") + labs(fill="") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_fill_viridis(discrete = F)
    ggplotly(g4)
  })
  
  #=====================================
  # Gráficos de série temporal
  #=====================================
  
  output$graf_serie_mat = renderPlotly({
    g5 = amostra %>% 
      dplyr::select(input$var_time_serie,NOTA_MT,ANO) %>% 
      dplyr::filter(!!sym(input$var_time_serie)!="") %>% na.omit() %>% 
      group_by(!!sym(input$var_time_serie),ANO) %>% 
      summarise(nota_media = mean(NOTA_MT)) %>% 
      ggplot(mapping = aes(ANO,nota_media,col = !!sym(input$var_time_serie)))+
      stat_smooth(method = "lm", formula = y ~ poly(x, 4), se = F)+
      geom_point()+
      theme_minimal()+xlab("")+ylab("") + labs(col="")
    ggplotly(g5)
  
  })
  
  output$graf_serie_cn = renderPlotly({
    g6 = amostra %>% 
      dplyr::select(input$var_time_serie,NOTA_CN,ANO) %>% 
      dplyr::filter(!!sym(input$var_time_serie)!="") %>% na.omit() %>% 
      group_by(!!sym(input$var_time_serie),ANO) %>% 
      summarise(nota_media = mean(NOTA_CN)) %>% 
      ggplot(mapping = aes(ANO,nota_media,col = !!sym(input$var_time_serie)))+
      stat_smooth(method = "lm", formula = y ~ poly(x, 4), se = F)+
      geom_point()+
      theme_minimal()+xlab("")+ylab("") + labs(col="")
    ggplotly(g6)
    
  })
  
  output$graf_serie_ch = renderPlotly({
    g7 = amostra %>% 
      dplyr::select(input$var_time_serie,NOTA_CH,ANO) %>% 
      dplyr::filter(!!sym(input$var_time_serie)!="") %>% na.omit() %>% 
      group_by(!!sym(input$var_time_serie),ANO) %>% 
      summarise(nota_media = mean(NOTA_CH)) %>% 
      ggplot(mapping = aes(ANO,nota_media,col = !!sym(input$var_time_serie)))+
      stat_smooth(method = "lm", formula = y ~ poly(x, 4), se = F)+
      geom_point()+
      theme_minimal()+xlab("")+ylab("") + labs(col="")
    ggplotly(g7)
    
  })
  
  output$graf_serie_lc = renderPlotly({
    g8 = amostra %>% 
      dplyr::select(input$var_time_serie,NOTA_LC,ANO) %>% 
      dplyr::filter(!!sym(input$var_time_serie)!="") %>% na.omit() %>% 
      group_by(!!sym(input$var_time_serie),ANO) %>% 
      summarise(nota_media = mean(NOTA_LC)) %>% 
      ggplot(mapping = aes(ANO,nota_media,col = !!sym(input$var_time_serie)))+
      stat_smooth(method = "lm", formula = y ~ poly(x, 4), se = F)+
      geom_point()+
      theme_minimal()+xlab("")+ylab("") + labs(col="")
    ggplotly(g8)
    
  })
  
  output$graf_serie_red = renderPlotly({
    g9 = amostra %>% 
      dplyr::select(input$var_time_serie,NOTA_REDACAO,ANO) %>% 
      dplyr::filter(!!sym(input$var_time_serie)!="") %>% na.omit() %>% 
      group_by(!!sym(input$var_time_serie),ANO) %>% 
      summarise(nota_media = mean(NOTA_REDACAO)) %>% 
      ggplot(mapping = aes(ANO,nota_media,col = !!sym(input$var_time_serie)))+
      stat_smooth(method = "lm", formula = y ~ poly(x, 4), se = F)+
      geom_point()+
      theme_minimal()+xlab("")+ylab("") + labs(col="")
    ggplotly(g9)
    
  })
  #=====================================
  # Mapas
  #=====================================
  output$mapa_nota_media = renderHighchart({
    
    graf.mp = amostra %>% filter(ANO==input$ano_mapa) %>% 
      select(UF_RESIDENCIA,!!sym(input$nota_mapa)) %>% 
      group_by(UF_RESIDENCIA) %>% 
      summarise(media = round(mean(!!sym(input$nota_mapa)),2))
    
    hcmap("countries/br/br-all", data = graf.mp, value = "media",
          joinBy =  c("hc-a2", "UF_RESIDENCIA"), name= "Nota média por estado",
          dataLabels = list(enabled = TRUE, format = '{point.code}'),
          tooltip = list(valueDecimals = 2, valuePrefix = "")) %>%
      hc_title(text = "") %>%
      hc_tooltip(pointFormat = '<br><span style="color:{series.color}">Nota média</span>: <strong>{point.media}</strong>') %>% 
      hc_legend(layout = "vertical", align = "right", valueDecimals = 2) %>%
      hc_credits(enabled = FALSE) 
  })
  
  output$mapa_participantes= renderHighchart({
    
    graf.cont = amostra %>% filter(ANO==input$ano_mapa) %>% 
      group_by(UF_RESIDENCIA) %>% 
      summarise(contagem = n())
    total = sum(graf.cont$contagem)
    graf.cont = graf.cont %>% mutate(prop = round(contagem/total*100,2))
    
    hcmap("countries/br/br-all", data = graf.cont, value = "prop",
          joinBy =  c("hc-a2", "UF_RESIDENCIA"), name= "Participação por estado",
          dataLabels = list(enabled = TRUE, format = '{point.code}'),
          tooltip = list(valueDecimals = 2, valuePrefix = "")) %>%
      hc_title(text = "") %>%
      hc_tooltip(pointFormat = '<br><span style="color:{series.color}">Porcentagem de participantes da amostra</span>: <strong>{point.prop}%</strong>') %>% 
      hc_legend(layout = "vertical", align = "right", valueDecimals = 2) %>%
      hc_credits(enabled = FALSE) 
  })
  
  #=====================================
  # Condições especiais
  #=====================================
  
  output$depend_adm_esc_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(DEPENDENCIA_ADM_ESC) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(DEPENDENCIA_ADM_ESC) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(DEPENDENCIA_ADM_ESC!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = DEPENDENCIA_ADM_ESC,values_from = Média,names_from = Grupo)
    g10 = ggplot() +
      geom_point(dados,mapping = aes(DEPENDENCIA_ADM_ESC,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = DEPENDENCIA_ADM_ESC,xend = DEPENDENCIA_ADM_ESC,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g10,tooltip = c("y"))
    
  })
  
  output$localizacao_esc_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(LOCALIZACAO_ESC) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(LOCALIZACAO_ESC) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(LOCALIZACAO_ESC!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = LOCALIZACAO_ESC,values_from = Média,names_from = Grupo)
    g11 = ggplot() +
      geom_point(dados,mapping = aes(LOCALIZACAO_ESC,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = LOCALIZACAO_ESC,xend = LOCALIZACAO_ESC,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g11,tooltip = c("y"))
    
  })
  
  output$sexo_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(SEXO) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(SEXO) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(SEXO!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = SEXO,values_from = Média,names_from = Grupo)
    g12 = ggplot() +
      geom_point(dados,mapping = aes(SEXO,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = SEXO,xend = SEXO,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g12,tooltip = c("y"))
    
  })
  
  output$cor_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(COR_RACA) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(COR_RACA) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(COR_RACA!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = COR_RACA,values_from = Média,names_from = Grupo)
    g13 = ggplot() +
      geom_point(dados,mapping = aes(COR_RACA,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = COR_RACA,xend = COR_RACA,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g13,tooltip = c("y"))
    
  })
  
  output$q001_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(Q001) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(Q001) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(Q001!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = Q001,values_from = Média,names_from = Grupo)
    g14 = ggplot() +
      geom_point(dados,mapping = aes(Q001,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = Q001,xend = Q001,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g14,tooltip = c("y"))
    
  })
  
  output$q002_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(Q002) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(Q002) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(Q002!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = Q002,values_from = Média,names_from = Grupo)
    g15 = ggplot() +
      geom_point(dados,mapping = aes(Q002,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = Q002,xend = Q002,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g15,tooltip = c("y"))
    
  })
  
  output$renda_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(Q006) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(Q006) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(Q006!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = Q006,values_from = Média,names_from = Grupo)
    g16 = ggplot() +
      geom_point(dados,mapping = aes(Q006,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = Q006,xend = Q006,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g16,tooltip = c("y"))
    
  })
  
  output$escola_nec_espe_plot = renderPlotly({
    
    summarise_geral = amostra %>% 
      filter(ANO==input$ano_cond_especiais) %>% 
      group_by(Q027) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Geral"))
    
    summarise_nec = nec_espec %>% 
      filter(ANO==input$ano_cond_especiais&!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(Q027) %>% 
      summarise(Média = mean(!!sym(input$nota_cond_especiais))) %>% 
      mutate(Grupo = rep("Condição Especial"))
    
    dados = bind_rows(summarise_geral,summarise_nec) %>% filter(Q027!="")
    dados_wider = dados %>% 
      pivot_wider(id_cols = Q027,values_from = Média,names_from = Grupo)
    g17 = ggplot() +
      geom_point(dados,mapping = aes(Q027,Média, col = Grupo),size = 2) +
      geom_segment(dados_wider,mapping = 
                     aes(x = Q027,xend = Q027,
                         y = Geral, yend = `Condição Especial`))+
      theme_minimal() +
      xlab("") + ylab("Nota média") + labs(col="") +
      scale_color_viridis(discrete=TRUE) +
      coord_flip()
    ggplotly(g17,tooltip = c("y"))
    
  })
  
  output$particip_nec_esp = renderPlotly({
    g18 = nec_espec %>% filter(!!sym(input$cond_espec_selected)=="Sim") %>% 
      group_by(ANO) %>% summarise(Participantes = n()) %>%
      ggplot(mapping = aes(x= ANO,y = Participantes)) + geom_line(fill="#440154")+
      theme_minimal() + xlab("Ano")
    ggplotly(g18,tooltip = c("y"))
  })
}

shinyApp(ui,server)
