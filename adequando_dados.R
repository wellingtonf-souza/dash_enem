#=========================================================================
#====================   adequando os dados    ============================
#=========================================================================

#======================   amostra 2014  ==============================

library(tidyverse)

amostra_2014 = read.csv2("C:/Users/welli/Desktop/dash_enem/amostra_2014.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova,
# sendo que em 2014 o código para a redação conforme os requisitos
# foi 7, nos anos seguintes adotou-se o 1
amostra_2014 %>% select(IN_PRESENCA_CN,
                        IN_PRESENCA_CH,
                        IN_PRESENCA_LC,
                        IN_PRESENCA_MT,
                        IN_STATUS_REDACAO) %>% summary() 

amostra_2014 = amostra_2014 %>% select(-c(IN_PRESENCA_CN,
                                          IN_PRESENCA_CH,
                                          IN_PRESENCA_LC,
                                          IN_PRESENCA_MT,
                                          IN_STATUS_REDACAO,
                                          Q010,
                                          Q011,
                                          Q017))

amostra_2014 = amostra_2014 %>% 
  mutate(ID_DEPENDENCIA_ADM_ESC = 
           case_when(ID_DEPENDENCIA_ADM_ESC==1~"Federal",
                     ID_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     ID_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     ID_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         ID_LOCALIZACAO_ESC = 
           case_when(ID_LOCALIZACAO_ESC==1~"Urbana",
                     ID_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         ST_CONCLUSAO = 
           case_when(
             ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             ST_CONCLUSAO==2	~"Estou cursando",
             ST_CONCLUSAO==3	~"Estou cursando",
             ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 1 ~"Pública",
             TP_ESCOLA == 2 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena" 
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(ID_DEPENDENCIA_ADM_ESC = ifelse(ID_DEPENDENCIA_ADM_ESC=="NA",NA,ID_DEPENDENCIA_ADM_ESC),
         ID_LOCALIZACAO_ESC = ifelse(ID_LOCALIZACAO_ESC=="NA",NA,ID_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

amostra_2014 = amostra_2014 %>% 
  mutate(Q001 = 
    fct_collapse(Q001,"Não estudou"="A",
              "Da 1ª à 4ª série do Ensino Fundamental"="B",  
              "Da 5ª à 8ª série do Ensino Fundamental"="C",
              "Ensino Médio incompleto"="D",
              #"Ensino Médio"="E",
              "Ensino Médio"=c("E","F"),
              "Ensino Superior"="G",
              "Pós-graduação"="H",
              "Não sei"="I"
    )
  )

amostra_2014 = amostra_2014 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        #"Ensino Médio"="E",
                        "Ensino Médio"=c("E","F"),
                        "Ensino Superior"="G",
                        "Pós-graduação"="H",
                        "Não sei"="I"
           )
  )  

amostra_2014 = amostra_2014 %>% 
  mutate(Q003 = 
           fct_collapse(Q003,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

amostra_2014 = amostra_2014 %>% 
  mutate(Q035 = fct_collapse(Q035,"Somente em escola pública"="A",
                           "Parte em escola pública e parte em escola privada"=c("B","D"),
                           "Somente em escola privada"="C",
                           "NA"=c("","E","F","G","H")
                           )
         )


#====================== nec espec 2014  ==============================

nec_espec_2014 = read.csv2("C:/Users/welli/Desktop/dash_enem/nec_espec_2014.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova,
# sendo que em 2014 o código para a redação conforme os requisitos
# foi 7, nos anos seguintes adotou-se o 1
nec_espec_2014 %>% select(IN_PRESENCA_CN,
                        IN_PRESENCA_CH,
                        IN_PRESENCA_LC,
                        IN_PRESENCA_MT,
                        IN_STATUS_REDACAO) %>% summary() 

nec_espec_2014 = nec_espec_2014 %>% select(-c(IN_PRESENCA_CN,
                                          IN_PRESENCA_CH,
                                          IN_PRESENCA_LC,
                                          IN_PRESENCA_MT,
                                          IN_STATUS_REDACAO,
                                          Q010,
                                          Q011,
                                          Q017))

nec_espec_2014 = nec_espec_2014 %>% 
  mutate(ID_DEPENDENCIA_ADM_ESC = 
           case_when(ID_DEPENDENCIA_ADM_ESC==1~"Federal",
                     ID_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     ID_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     ID_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         ID_LOCALIZACAO_ESC = 
           case_when(ID_LOCALIZACAO_ESC==1~"Urbana",
                     ID_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         ST_CONCLUSAO = 
           case_when(
             ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             ST_CONCLUSAO==2	~"Estou cursando",
             ST_CONCLUSAO==3	~"Estou cursando",
             ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 1 ~"Pública",
             TP_ESCOLA == 2 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena" 
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(ID_DEPENDENCIA_ADM_ESC = ifelse(ID_DEPENDENCIA_ADM_ESC=="NA",NA,ID_DEPENDENCIA_ADM_ESC),
         ID_LOCALIZACAO_ESC = ifelse(ID_LOCALIZACAO_ESC=="NA",NA,ID_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

nec_espec_2014 = nec_espec_2014 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        #"Ensino Médio"="E",
                        "Ensino Médio"=c("E","F"),
                        "Ensino Superior"="G",
                        "Pós-graduação"="H",
                        "Não sei"="I"
           )
  )

nec_espec_2014 = nec_espec_2014 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        #"Ensino Médio"="E",
                        "Ensino Médio"=c("E","F"),
                        "Ensino Superior"="G",
                        "Pós-graduação"="H",
                        "Não sei"="I"
           )
  )  

nec_espec_2014 = nec_espec_2014 %>% 
  mutate(Q003 = 
           fct_collapse(Q003,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

nec_espec_2014 = nec_espec_2014 %>% 
  mutate(Q035 = fct_collapse(Q035,"Somente em escola pública"="A",
                      "Parte em escola pública e parte em escola privada"=c("B","D"),
                      "Somente em escola privada"="C",
                      "NA"=c("","E","F","G","H")
                      )
         )

#======================   amostra 2015  ==============================
amostra_2015 = read.csv2("C:/Users/welli/Desktop/dash_enem/amostra_2015.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova
amostra_2015 %>% select(TP_PRESENCA_CN,
                        TP_PRESENCA_CH,
                        TP_PRESENCA_LC,
                        TP_PRESENCA_MT,
                        TP_STATUS_REDACAO) %>% summary() 

amostra_2015 = amostra_2015 %>% select(-c(TP_PRESENCA_CN,
                                          TP_PRESENCA_CH,
                                          TP_PRESENCA_LC,
                                          TP_PRESENCA_MT,
                                          TP_STATUS_REDACAO,
                                          Q010,
                                          Q024,
                                          Q025))

amostra_2015 = amostra_2015 %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = 
           case_when(TP_DEPENDENCIA_ADM_ESC==1~"Federal",
                     TP_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     TP_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     TP_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         TP_LOCALIZACAO_ESC = 
           case_when(TP_LOCALIZACAO_ESC==1~"Urbana",
                     TP_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         TP_ST_CONCLUSAO = 
           case_when(
             TP_ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             TP_ST_CONCLUSAO==2	~"Estou cursando",
             TP_ST_CONCLUSAO==3	~"Estou cursando",
             TP_ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 2 ~"Pública",
             TP_ESCOLA == 3 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena",
             TRUE~"Não declarado"
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = ifelse(TP_DEPENDENCIA_ADM_ESC=="NA",NA,TP_DEPENDENCIA_ADM_ESC),
         TP_LOCALIZACAO_ESC = ifelse(TP_LOCALIZACAO_ESC=="NA",NA,TP_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

amostra_2015 = amostra_2015 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )

amostra_2015 = amostra_2015 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )  

amostra_2015 = amostra_2015 %>% 
  mutate(Q006 = 
           fct_collapse(Q006,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

amostra_2015 = amostra_2015 %>% 
  mutate(Q047 = fct_collapse(Q047,"Somente em escola pública"="A",
                      "Parte em escola pública e parte em escola privada"=c("B","C"),
                      "Somente em escola privada"=c("D","E"),
                      "NA"=c("")
                      )
         )

#====================== nec espec 2015 ==============================

nec_espec_2015 = read.csv2("C:/Users/welli/Desktop/dash_enem/nec_espec_2015.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova
nec_espec_2015 %>% select(TP_PRESENCA_CN,
                        TP_PRESENCA_CH,
                        TP_PRESENCA_LC,
                        TP_PRESENCA_MT,
                        TP_STATUS_REDACAO) %>% summary() 

nec_espec_2015 = nec_espec_2015 %>% select(-c(TP_PRESENCA_CN,
                                          TP_PRESENCA_CH,
                                          TP_PRESENCA_LC,
                                          TP_PRESENCA_MT,
                                          TP_STATUS_REDACAO,
                                          Q010,
                                          Q024,
                                          Q025))

nec_espec_2015 = nec_espec_2015 %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = 
           case_when(TP_DEPENDENCIA_ADM_ESC==1~"Federal",
                     TP_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     TP_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     TP_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         TP_LOCALIZACAO_ESC = 
           case_when(TP_LOCALIZACAO_ESC==1~"Urbana",
                     TP_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         TP_ST_CONCLUSAO = 
           case_when(
             TP_ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             TP_ST_CONCLUSAO==2	~"Estou cursando",
             TP_ST_CONCLUSAO==3	~"Estou cursando",
             TP_ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 2 ~"Pública",
             TP_ESCOLA == 3 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena",
             TRUE~"Não declarado"
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = ifelse(TP_DEPENDENCIA_ADM_ESC=="NA",NA,TP_DEPENDENCIA_ADM_ESC),
         TP_LOCALIZACAO_ESC = ifelse(TP_LOCALIZACAO_ESC=="NA",NA,TP_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

nec_espec_2015 = nec_espec_2015 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )

nec_espec_2015 = nec_espec_2015 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )  

nec_espec_2015 = nec_espec_2015 %>% 
  mutate(Q006 = 
           fct_collapse(Q006,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

nec_espec_2015 = nec_espec_2015 %>% 
  mutate(Q047 = fct_collapse(Q047,"Somente em escola pública"="A",
                             "Parte em escola pública e parte em escola privada"=c("B","C"),
                             "Somente em escola privada"=c("D","E"),
                             "NA"=c("")
  )
  )

#======================   amostra 2016  ==============================
amostra_2016 = read.csv2("C:/Users/welli/Desktop/dash_enem/amostra_2016.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova
amostra_2016 %>% select(TP_PRESENCA_CN,
                        TP_PRESENCA_CH,
                        TP_PRESENCA_LC,
                        TP_PRESENCA_MT,
                        TP_STATUS_REDACAO) %>% summary() 

amostra_2016 = amostra_2016 %>% select(-c(TP_PRESENCA_CN,
                                          TP_PRESENCA_CH,
                                          TP_PRESENCA_LC,
                                          TP_PRESENCA_MT,
                                          TP_STATUS_REDACAO,
                                          Q010,
                                          Q024,
                                          Q025))

amostra_2016 = amostra_2016 %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = 
           case_when(TP_DEPENDENCIA_ADM_ESC==1~"Federal",
                     TP_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     TP_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     TP_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         TP_LOCALIZACAO_ESC = 
           case_when(TP_LOCALIZACAO_ESC==1~"Urbana",
                     TP_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         TP_ST_CONCLUSAO = 
           case_when(
             TP_ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             TP_ST_CONCLUSAO==2	~"Estou cursando",
             TP_ST_CONCLUSAO==3	~"Estou cursando",
             TP_ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 2 ~"Pública",
             TP_ESCOLA == 3 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena",
             TRUE~"Não declarado"
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = ifelse(TP_DEPENDENCIA_ADM_ESC=="NA",NA,TP_DEPENDENCIA_ADM_ESC),
         TP_LOCALIZACAO_ESC = ifelse(TP_LOCALIZACAO_ESC=="NA",NA,TP_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

amostra_2016 = amostra_2016 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )

amostra_2016 = amostra_2016 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )  

amostra_2016 = amostra_2016 %>% 
  mutate(Q006 = 
           fct_collapse(Q006,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

amostra_2016 = amostra_2016 %>% 
  mutate(Q047 = fct_collapse(Q047,"Somente em escola pública"="A",
                             "Parte em escola pública e parte em escola privada"=c("B","C"),
                             "Somente em escola privada"=c("D","E"),
                             "NA"=c("")
  )
  )

#====================== nec espec 2016 ==============================

nec_espec_2016 = read.csv2("C:/Users/welli/Desktop/dash_enem/nec_espec_2016.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova
nec_espec_2016 %>% select(TP_PRESENCA_CN,
                        TP_PRESENCA_CH,
                        TP_PRESENCA_LC,
                        TP_PRESENCA_MT,
                        TP_STATUS_REDACAO) %>% summary() 

nec_espec_2016 = nec_espec_2016 %>% select(-c(TP_PRESENCA_CN,
                                          TP_PRESENCA_CH,
                                          TP_PRESENCA_LC,
                                          TP_PRESENCA_MT,
                                          TP_STATUS_REDACAO,
                                          Q010,
                                          Q024,
                                          Q025))

nec_espec_2016 = nec_espec_2016 %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = 
           case_when(TP_DEPENDENCIA_ADM_ESC==1~"Federal",
                     TP_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     TP_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     TP_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         TP_LOCALIZACAO_ESC = 
           case_when(TP_LOCALIZACAO_ESC==1~"Urbana",
                     TP_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         TP_ST_CONCLUSAO = 
           case_when(
             TP_ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             TP_ST_CONCLUSAO==2	~"Estou cursando",
             TP_ST_CONCLUSAO==3	~"Estou cursando",
             TP_ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 2 ~"Pública",
             TP_ESCOLA == 3 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena",
             TRUE~"Não declarado"
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = ifelse(TP_DEPENDENCIA_ADM_ESC=="NA",NA,TP_DEPENDENCIA_ADM_ESC),
         TP_LOCALIZACAO_ESC = ifelse(TP_LOCALIZACAO_ESC=="NA",NA,TP_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

nec_espec_2016 = nec_espec_2016 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )

nec_espec_2016 = nec_espec_2016 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )  

nec_espec_2016 = nec_espec_2016 %>% 
  mutate(Q006 = 
           fct_collapse(Q006,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

nec_espec_2016 = nec_espec_2016 %>% 
  mutate(Q047 = fct_collapse(Q047,"Somente em escola pública"="A",
                             "Parte em escola pública e parte em escola privada"=c("B","C"),
                             "Somente em escola privada"=c("D","E"),
                             "NA"=c("")
  )
  )

#======================   amostra 2017  ==============================
amostra_2017 = read.csv2("C:/Users/welli/Desktop/dash_enem/amostra_2017.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova
amostra_2017 %>% select(TP_PRESENCA_CN,
                        TP_PRESENCA_CH,
                        TP_PRESENCA_LC,
                        TP_PRESENCA_MT,
                        TP_STATUS_REDACAO) %>% summary() 

amostra_2017 = amostra_2017 %>% select(-c(TP_PRESENCA_CN,
                                          TP_PRESENCA_CH,
                                          TP_PRESENCA_LC,
                                          TP_PRESENCA_MT,
                                          TP_STATUS_REDACAO,
                                          Q010,
                                          Q024,
                                          Q025))

amostra_2017 = amostra_2017 %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = 
           case_when(TP_DEPENDENCIA_ADM_ESC==1~"Federal",
                     TP_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     TP_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     TP_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         TP_LOCALIZACAO_ESC = 
           case_when(TP_LOCALIZACAO_ESC==1~"Urbana",
                     TP_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         TP_ST_CONCLUSAO = 
           case_when(
             TP_ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             TP_ST_CONCLUSAO==2	~"Estou cursando",
             TP_ST_CONCLUSAO==3	~"Estou cursando",
             TP_ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 2 ~"Pública",
             TP_ESCOLA == 3 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena",
             TRUE~"Não declarado"
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = ifelse(TP_DEPENDENCIA_ADM_ESC=="NA",NA,TP_DEPENDENCIA_ADM_ESC),
         TP_LOCALIZACAO_ESC = ifelse(TP_LOCALIZACAO_ESC=="NA",NA,TP_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

amostra_2017 = amostra_2017 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )

amostra_2017 = amostra_2017 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )  

amostra_2017 = amostra_2017 %>% 
  mutate(Q006 = 
           fct_collapse(Q006,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

amostra_2017 = amostra_2017 %>% 
  mutate(Q027 = fct_collapse(Q027,"Somente em escola pública"="A\n",
                             "Parte em escola pública e parte em escola privada"=c("B\n","C\n"),
                             "Somente em escola privada"=c("D\n","E\n"),
                             "NA"=c("")
  )
  )

#======================   amostra 2017  ==============================
nec_espec_2017 = read.csv2("C:/Users/welli/Desktop/dash_enem/nec_espec_2017.csv",header = T)

# variaveis que indicam que os participantes realizaram a prova
nec_espec_2017 %>% select(TP_PRESENCA_CN,
                        TP_PRESENCA_CH,
                        TP_PRESENCA_LC,
                        TP_PRESENCA_MT,
                        TP_STATUS_REDACAO) %>% summary() 

nec_espec_2017 = nec_espec_2017 %>% select(-c(TP_PRESENCA_CN,
                                          TP_PRESENCA_CH,
                                          TP_PRESENCA_LC,
                                          TP_PRESENCA_MT,
                                          TP_STATUS_REDACAO,
                                          Q010,
                                          Q024,
                                          Q025))

nec_espec_2017 = nec_espec_2017 %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = 
           case_when(TP_DEPENDENCIA_ADM_ESC==1~"Federal",
                     TP_DEPENDENCIA_ADM_ESC==2~"Estadual",
                     TP_DEPENDENCIA_ADM_ESC==3~"Municipal",
                     TP_DEPENDENCIA_ADM_ESC==4~"Privada",
                     TRUE~"NA"),
         
         TP_LOCALIZACAO_ESC = 
           case_when(TP_LOCALIZACAO_ESC==1~"Urbana",
                     TP_LOCALIZACAO_ESC==2~"Rural",
                     TRUE~"NA"),
         
         TP_SEXO = 
           case_when(TP_SEXO=="F"~"Feminino",
                     TRUE~"Masculino"),
         
         TP_ST_CONCLUSAO = 
           case_when(
             TP_ST_CONCLUSAO==1	~"Já concluí o Ensino Médio",
             TP_ST_CONCLUSAO==2	~"Estou cursando",
             TP_ST_CONCLUSAO==3	~"Estou cursando",
             TP_ST_CONCLUSAO==4	~"Não concluí e não estou cursando o Ensino Médio"),
         
         TP_ESCOLA = 
           case_when(
             TP_ESCOLA == 2 ~"Pública",
             TP_ESCOLA == 3 ~"Privada",
             TRUE~"NA"
           ),
         
         TP_COR_RACA = 
           case_when(
             TP_COR_RACA == 0 ~	"Não declarado",
             TP_COR_RACA == 1 ~	"Branca",
             TP_COR_RACA == 2 ~	"Preta",
             TP_COR_RACA == 3 ~	"Parda",
             TP_COR_RACA == 4 ~	"Amarela",
             TP_COR_RACA == 5 ~	"Indígena",
             TRUE~"Não declarado"
             
           ),
         
         IN_BAIXA_VISAO = 
           case_when(
             IN_BAIXA_VISAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_CEGUEIRA = 
           case_when(
             IN_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDEZ = 
           case_when(
             IN_SURDEZ==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_AUDITIVA = 
           case_when(
             IN_DEFICIENCIA_AUDITIVA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_SURDO_CEGUEIRA = 
           case_when(
             IN_SURDO_CEGUEIRA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_FISICA = 
           case_when(
             IN_DEFICIENCIA_FISICA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIENCIA_MENTAL = 
           case_when(
             IN_DEFICIENCIA_MENTAL==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DEFICIT_ATENCAO = 
           case_when(
             IN_DEFICIT_ATENCAO==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_DISLEXIA = 
           case_when(
             IN_DISLEXIA==1~"Sim",
             TRUE~"Não"
           ),
         
         IN_AUTISMO = 
           case_when(
             IN_AUTISMO==1~"Sim",
             TRUE~"Não"
           )
  ) %>% 
  mutate(TP_DEPENDENCIA_ADM_ESC = ifelse(TP_DEPENDENCIA_ADM_ESC=="NA",NA,TP_DEPENDENCIA_ADM_ESC),
         TP_LOCALIZACAO_ESC = ifelse(TP_LOCALIZACAO_ESC=="NA",NA,TP_LOCALIZACAO_ESC),
         TP_ESCOLA = ifelse(TP_ESCOLA=="NA",NA,TP_ESCOLA))

nec_espec_2017 = nec_espec_2017 %>% 
  mutate(Q001 = 
           fct_collapse(Q001,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )

nec_espec_2017 = nec_espec_2017 %>% 
  mutate(Q002 = 
           fct_collapse(Q002,"Não estudou"="A",
                        "Da 1ª à 4ª série do Ensino Fundamental"="B",  
                        "Da 5ª à 8ª série do Ensino Fundamental"="C",
                        "Ensino Médio incompleto"="D",
                        "Ensino Médio"="E",
                        "Ensino Superior"="F",
                        "Pós-graduação"="G",
                        "Não sei"="H"
           )
  )  

nec_espec_2017 = nec_espec_2017 %>% 
  mutate(Q006 = 
           fct_collapse(Q006,"Nenhuma renda"="A",
                        "Até um salário mínimo"="B",
                        "Mais de um até 1,5"='C',
                        'Mais de 1,5 e até 2'="D",
                        "Mais de 2 e até 2,5"="E",
                        "Mais de 2,5 e até 3"="F",
                        "Mais de 3 e até 4"='G',
                        "Mais de 4 e até 5"='H',
                        "Mais de 5 e até 6"="I",
                        "Mais de 6 e até 7"="J",
                        "Mais de 7 e até 8"="K",
                        "Mais de 8 e até 9"="L",
                        "Mais de 9 e até 10"="M",
                        "Mais de 10 e até 12"="N",
                        "Mais de 12 e até 15"="O",
                        "Mais de 15 e até 20"="P",
                        "Acima 20 salários mínimos"="Q"
                        
                        
           )
  ) 

nec_espec_2017 = nec_espec_2017 %>% 
  mutate(Q027 = fct_collapse(Q027,"Somente em escola pública"="A\n",
                             "Parte em escola pública e parte em escola privada"=c("B\n","C\n"),
                             "Somente em escola privada"=c("D\n","E\n"),
                             "NA"=c("")
  )
  )

#======================  juntando as bases  ==============================

amostra_2014_2017 = data.frame(
  ANO = c(rep(2017,dim(amostra_2017)[1]),rep(2016,dim(amostra_2016)[1]),rep(2015,dim(amostra_2015)[1]),rep(2014,dim(amostra_2014)[1])),
  NOTA_CN = c(amostra_2017$NU_NOTA_CN,amostra_2016$NU_NOTA_CN,amostra_2015$NU_NOTA_CN,amostra_2014$NOTA_CN),
  NOTA_CH = c(amostra_2017$NU_NOTA_CH,amostra_2016$NU_NOTA_CH,amostra_2015$NU_NOTA_CH,amostra_2014$NOTA_CH),
  NOTA_LC = c(amostra_2017$NU_NOTA_LC,amostra_2016$NU_NOTA_LC,amostra_2015$NU_NOTA_LC,amostra_2014$NOTA_LC),
  NOTA_MT = c(amostra_2017$NU_NOTA_MT,amostra_2016$NU_NOTA_MT,amostra_2015$NU_NOTA_MT,amostra_2014$NOTA_MT),
  NOTA_REDACAO = c(amostra_2017$NU_NOTA_REDACAO,amostra_2016$NU_NOTA_REDACAO,amostra_2015$NU_NOTA_REDACAO,
                   amostra_2014$NU_NOTA_REDACAO),
  CO_MUNICIPIO_RESIDENCIA = c(amostra_2017$CO_MUNICIPIO_RESIDENCIA,amostra_2016$CO_MUNICIPIO_RESIDENCIA,
                              amostra_2015$CO_MUNICIPIO_RESIDENCIA,amostra_2014$COD_MUNICIPIO_RESIDENCIA),
  UF_RESIDENCIA = fct_c(amostra_2017$SG_UF_RESIDENCIA,amostra_2016$SG_UF_RESIDENCIA,amostra_2015$SG_UF_RESIDENCIA,amostra_2014$UF_RESIDENCIA),
  DEPENDENCIA_ADM_ESC = c(amostra_2017$TP_DEPENDENCIA_ADM_ESC,amostra_2016$TP_DEPENDENCIA_ADM_ESC,
                    amostra_2015$TP_DEPENDENCIA_ADM_ESC,amostra_2014$ID_DEPENDENCIA_ADM_ESC),
  LOCALIZACAO_ESC = c(amostra_2017$TP_LOCALIZACAO_ESC,amostra_2016$TP_LOCALIZACAO_ESC,
              amostra_2015$TP_LOCALIZACAO_ESC,amostra_2014$ID_LOCALIZACAO_ESC),
  IDADE = c(amostra_2017$NU_IDADE,amostra_2016$NU_IDADE,amostra_2015$NU_IDADE,amostra_2014$IDADE),
  SEXO = c(amostra_2017$TP_SEXO,amostra_2016$TP_SEXO,amostra_2015$TP_SEXO,amostra_2014$TP_SEXO),
  ST_CONCLUSAO = c(amostra_2017$TP_ST_CONCLUSAO,amostra_2016$TP_ST_CONCLUSAO,
           amostra_2015$TP_ST_CONCLUSAO,amostra_2014$ST_CONCLUSAO),
  TP_ESCOLA = c(amostra_2017$TP_ESCOLA,amostra_2016$TP_ESCOLA,amostra_2015$TP_ESCOLA,amostra_2014$TP_ESCOLA),
  COR_RACA = c(amostra_2017$TP_COR_RACA,amostra_2016$TP_COR_RACA,amostra_2015$TP_COR_RACA,amostra_2014$TP_COR_RACA),
  BAIXA_VISAO = c(amostra_2017$IN_BAIXA_VISAO,amostra_2016$IN_BAIXA_VISAO,amostra_2015$IN_BAIXA_VISAO,amostra_2014$IN_BAIXA_VISAO),
  CEGUEIRA = c(amostra_2017$IN_CEGUEIRA,amostra_2016$IN_CEGUEIRA,amostra_2015$IN_CEGUEIRA,amostra_2014$IN_CEGUEIRA),
  SURDEZ = c(amostra_2017$IN_SURDEZ,amostra_2016$IN_SURDEZ,amostra_2015$IN_SURDEZ,amostra_2014$IN_SURDEZ),
  DEFICIENCIA_FISICA = c(amostra_2017$IN_DEFICIENCIA_FISICA,amostra_2016$IN_DEFICIENCIA_FISICA,
                         amostra_2015$IN_DEFICIENCIA_FISICA,amostra_2014$IN_DEFICIENCIA_FISICA),
  AUTISMO = c(amostra_2017$IN_AUTISMO,amostra_2016$IN_AUTISMO,
                         amostra_2015$IN_AUTISMO,amostra_2014$IN_AUTISMO),
  Q001 = fct_c(amostra_2017$Q001,amostra_2016$Q001,
           amostra_2015$Q001,amostra_2014$Q001),
  Q002 = fct_c(amostra_2017$Q002,amostra_2016$Q002,
           amostra_2015$Q002,amostra_2014$Q002),
  Q006 = fct_c(amostra_2017$Q006,amostra_2016$Q006,
           amostra_2015$Q006,amostra_2014$Q003),
  Q027 = fct_c(amostra_2017$Q027,amostra_2016$Q047,
               amostra_2015$Q047,amostra_2014$Q035)
)

nec_espec_2014_2017 = data.frame(
  ANO = c(rep(2017,dim(nec_espec_2017)[1]),rep(2016,dim(nec_espec_2016)[1]),rep(2015,dim(nec_espec_2015)[1]),rep(2014,dim(nec_espec_2014)[1])),
  NOTA_CN = c(nec_espec_2017$NU_NOTA_CN,nec_espec_2016$NU_NOTA_CN,nec_espec_2015$NU_NOTA_CN,nec_espec_2014$NOTA_CN),
  NOTA_CH = c(nec_espec_2017$NU_NOTA_CH,nec_espec_2016$NU_NOTA_CH,nec_espec_2015$NU_NOTA_CH,nec_espec_2014$NOTA_CH),
  NOTA_LC = c(nec_espec_2017$NU_NOTA_LC,nec_espec_2016$NU_NOTA_LC,nec_espec_2015$NU_NOTA_LC,nec_espec_2014$NOTA_LC),
  NOTA_MT = c(nec_espec_2017$NU_NOTA_MT,nec_espec_2016$NU_NOTA_MT,nec_espec_2015$NU_NOTA_MT,nec_espec_2014$NOTA_MT),
  NOTA_REDACAO = c(nec_espec_2017$NU_NOTA_REDACAO,nec_espec_2016$NU_NOTA_REDACAO,nec_espec_2015$NU_NOTA_REDACAO,
                   nec_espec_2014$NU_NOTA_REDACAO),
  CO_MUNICIPIO_RESIDENCIA = c(nec_espec_2017$CO_MUNICIPIO_RESIDENCIA,nec_espec_2016$CO_MUNICIPIO_RESIDENCIA,
                              nec_espec_2015$CO_MUNICIPIO_RESIDENCIA,nec_espec_2014$COD_MUNICIPIO_RESIDENCIA),
  UF_RESIDENCIA = fct_c(nec_espec_2017$SG_UF_RESIDENCIA,nec_espec_2016$SG_UF_RESIDENCIA,nec_espec_2015$SG_UF_RESIDENCIA,nec_espec_2014$UF_RESIDENCIA),
  DEPENDENCIA_ADM_ESC = c(nec_espec_2017$TP_DEPENDENCIA_ADM_ESC,nec_espec_2016$TP_DEPENDENCIA_ADM_ESC,
                          nec_espec_2015$TP_DEPENDENCIA_ADM_ESC,nec_espec_2014$ID_DEPENDENCIA_ADM_ESC),
  LOCALIZACAO_ESC = c(nec_espec_2017$TP_LOCALIZACAO_ESC,nec_espec_2016$TP_LOCALIZACAO_ESC,
                      nec_espec_2015$TP_LOCALIZACAO_ESC,nec_espec_2014$ID_LOCALIZACAO_ESC),
  IDADE = c(nec_espec_2017$NU_IDADE,nec_espec_2016$NU_IDADE,nec_espec_2015$NU_IDADE,nec_espec_2014$IDADE),
  SEXO = c(nec_espec_2017$TP_SEXO,nec_espec_2016$TP_SEXO,nec_espec_2015$TP_SEXO,nec_espec_2014$TP_SEXO),
  ST_CONCLUSAO = c(nec_espec_2017$TP_ST_CONCLUSAO,nec_espec_2016$TP_ST_CONCLUSAO,
                   nec_espec_2015$TP_ST_CONCLUSAO,nec_espec_2014$ST_CONCLUSAO),
  TP_ESCOLA = c(nec_espec_2017$TP_ESCOLA,nec_espec_2016$TP_ESCOLA,nec_espec_2015$TP_ESCOLA,nec_espec_2014$TP_ESCOLA),
  COR_RACA = c(nec_espec_2017$TP_COR_RACA,nec_espec_2016$TP_COR_RACA,nec_espec_2015$TP_COR_RACA,nec_espec_2014$TP_COR_RACA),
  BAIXA_VISAO = c(nec_espec_2017$IN_BAIXA_VISAO,nec_espec_2016$IN_BAIXA_VISAO,nec_espec_2015$IN_BAIXA_VISAO,nec_espec_2014$IN_BAIXA_VISAO),
  CEGUEIRA = c(nec_espec_2017$IN_CEGUEIRA,nec_espec_2016$IN_CEGUEIRA,nec_espec_2015$IN_CEGUEIRA,nec_espec_2014$IN_CEGUEIRA),
  SURDEZ = c(nec_espec_2017$IN_SURDEZ,nec_espec_2016$IN_SURDEZ,nec_espec_2015$IN_SURDEZ,nec_espec_2014$IN_SURDEZ),
  DEFICIENCIA_FISICA = c(nec_espec_2017$IN_DEFICIENCIA_FISICA,nec_espec_2016$IN_DEFICIENCIA_FISICA,
                         nec_espec_2015$IN_DEFICIENCIA_FISICA,nec_espec_2014$IN_DEFICIENCIA_FISICA),
  AUTISMO = c(nec_espec_2017$IN_AUTISMO,nec_espec_2016$IN_AUTISMO,
              nec_espec_2015$IN_AUTISMO,nec_espec_2014$IN_AUTISMO),
  Q001 = fct_c(nec_espec_2017$Q001,nec_espec_2016$Q001,
               nec_espec_2015$Q001,nec_espec_2014$Q001),
  Q002 = fct_c(nec_espec_2017$Q002,nec_espec_2016$Q002,
               nec_espec_2015$Q002,nec_espec_2014$Q002),
  Q006 = fct_c(nec_espec_2017$Q006,nec_espec_2016$Q006,
               nec_espec_2015$Q006,nec_espec_2014$Q003),
  Q027 = fct_c(nec_espec_2017$Q027,nec_espec_2016$Q047,
               nec_espec_2015$Q047,nec_espec_2014$Q035)
)

amostra_2014_2017$Q027 = ifelse(as.character(amostra_2014_2017$Q027)=="NA",NA,as.character(amostra_2014_2017$Q027))
nec_espec_2014_2017$Q027 = ifelse(as.character(nec_espec_2014_2017$Q027)=="NA",NA,as.character(nec_espec_2014_2017$Q027))

saveRDS(nec_espec_2014_2017,file = "nec_espec_2014_2017.rds")
saveRDS(amostra_2014_2017,file = "amostra_2014_2017.rds")

