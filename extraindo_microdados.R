#=========================================================================
#====================          ENEM 2014        ==========================
#=========================================================================

setwd("C:/Users/welli/Documents/IC/md_2014/DADOS")

library(RSQLite)
library(DBI)
library(data.table)
library(dplyr)

con=dbConnect(RSQLite::SQLite(),dbname="enem_2014")

# dbWriteTable(conn = con, name = "enem_2014", value = "MICRODADOS_ENEM_2014.csv",
#              row.names = F, header = TRUE, sep = ";",dec=".")

dbListTables(con)
dbListFields(con,"enem_2014")

set.seed(3634459)
amostra_2014 = dbGetQuery(con,"SELECT IN_PRESENCA_CN,IN_PRESENCA_CH,IN_PRESENCA_LC,IN_PRESENCA_MT,
                               NOTA_CN,NOTA_CH,NOTA_LC,NOTA_MT,
                               IN_STATUS_REDACAO,
                               NU_NOTA_REDACAO,
                               COD_MUNICIPIO_RESIDENCIA,
                               NO_MUNICIPIO_RESIDENCIA,
                               UF_RESIDENCIA,
                               ID_DEPENDENCIA_ADM_ESC,
                               ID_LOCALIZACAO_ESC,
                               IDADE,
                               TP_SEXO,
                               ST_CONCLUSAO,
                               TP_ESCOLA,
                               TP_COR_RACA,
                               IN_BAIXA_VISAO,
                               IN_CEGUEIRA,
                               IN_SURDEZ,
                               IN_DEFICIENCIA_AUDITIVA,
                               IN_SURDO_CEGUEIRA,
                               IN_DEFICIENCIA_FISICA,
                               IN_DEFICIENCIA_MENTAL,
                               IN_DEFICIT_ATENCAO,
                               IN_DISLEXIA,
                               IN_AUTISMO,
                               Q001, 
                               Q002,
                               Q003,
                               Q010,
                               Q011,
                               Q017,
                               Q035
                               FROM enem_2014 WHERE IN_PRESENCA_CN=1 AND 
                                                    IN_PRESENCA_CH=1 AND 
                                                    IN_PRESENCA_LC=1 AND 
                                                    IN_PRESENCA_MT=1 AND
                                                    IN_STATUS_REDACAO = 7
                                                    ORDER BY RANDOM() LIMIT 100000;")

write.csv2(amostra_2014,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/amostra_2014.csv")  

set.seed(7245687)
nec_espec_2014 = dbGetQuery(con,"SELECT IN_PRESENCA_CN,IN_PRESENCA_CH,IN_PRESENCA_LC,IN_PRESENCA_MT,
                          NOTA_CN,NOTA_CH,NOTA_LC,NOTA_MT,
                          IN_STATUS_REDACAO,
                          NU_NOTA_REDACAO,
                          COD_MUNICIPIO_RESIDENCIA,
                          NO_MUNICIPIO_RESIDENCIA,
                          UF_RESIDENCIA,
                          ID_DEPENDENCIA_ADM_ESC,
                          ID_LOCALIZACAO_ESC,
                          IDADE,
                          TP_SEXO,
                          ST_CONCLUSAO,
                          TP_ESCOLA,
                          TP_COR_RACA,
                          IN_BAIXA_VISAO,
                          IN_CEGUEIRA,
                          IN_SURDEZ,
                          IN_DEFICIENCIA_AUDITIVA,
                          IN_SURDO_CEGUEIRA,
                          IN_DEFICIENCIA_FISICA,
                          IN_DEFICIENCIA_MENTAL,
                          IN_DEFICIT_ATENCAO,
                          IN_DISLEXIA,
                          IN_AUTISMO,
                          Q001, 
                          Q002,
                          Q003,
                          Q010,
                          Q011,
                          Q017,
                          Q035
                          FROM enem_2014 WHERE IN_PRESENCA_CN=1 AND 
                          IN_PRESENCA_CH=1 AND 
                          IN_PRESENCA_LC=1 AND 
                          IN_PRESENCA_MT=1 AND
                          IN_STATUS_REDACAO = 7 AND 
                          (IN_BAIXA_VISAO = 1 OR
                          IN_CEGUEIRA = 1 OR
                          IN_SURDEZ = 1 OR
                          IN_DEFICIENCIA_AUDITIVA = 1 OR
                          IN_SURDO_CEGUEIRA = 1 OR
                          IN_DEFICIENCIA_FISICA = 1 OR
                          IN_DEFICIENCIA_MENTAL = 1 OR
                          IN_DEFICIT_ATENCAO = 1 OR
                          IN_DISLEXIA = 1 OR
                          IN_AUTISMO = 1);")

write.csv2(nec_espec_2014,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/nec_espec_2014.csv")

dbDisconnect(con)

#=========================================================================
#====================          ENEM 2015        ==========================
#=========================================================================

setwd("C:/Users/welli/Documents/IC/md_2015/DADOS")

library(RSQLite)
library(DBI)
library(data.table)
library(dplyr)

con=dbConnect(RSQLite::SQLite(),dbname="enem_2015")

# dbWriteTable(conn = con, name = "enem_2015", value = "MICRODADOS_ENEM_2015.csv",
#              row.names = F, header = TRUE, sep = ";",dec=".")

dbListTables(con)
dbListFields(con,"enem_2015")

set.seed(6824164)
amostra_2015 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                          NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                          TP_STATUS_REDACAO,
                          NU_NOTA_REDACAO,
                          CO_MUNICIPIO_RESIDENCIA,
                          NO_MUNICIPIO_RESIDENCIA,
                          SG_UF_RESIDENCIA,
                          TP_DEPENDENCIA_ADM_ESC,
                          TP_LOCALIZACAO_ESC,
                          NU_IDADE,
                          TP_SEXO,
                          TP_ST_CONCLUSAO,
                          TP_ESCOLA,
                          TP_COR_RACA,
                          IN_BAIXA_VISAO,
                          IN_CEGUEIRA,
                          IN_SURDEZ,
                          IN_DEFICIENCIA_AUDITIVA,
                          IN_SURDO_CEGUEIRA,
                          IN_DEFICIENCIA_FISICA,
                          IN_DEFICIENCIA_MENTAL,
                          IN_DEFICIT_ATENCAO,
                          IN_DISLEXIA,
                          IN_AUTISMO,
                          Q001, 
                          Q002,
                          Q006,
                          Q010,
                          Q024,
                          Q025,
                          Q047
                          FROM enem_2015 WHERE TP_PRESENCA_CN=1 AND 
                          TP_PRESENCA_CH=1 AND 
                          TP_PRESENCA_LC=1 AND 
                          TP_PRESENCA_MT=1 AND
                          TP_STATUS_REDACAO = 1
                          ORDER BY RANDOM() LIMIT 100000;")

write.csv2(amostra_2015,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/amostra_2015.csv")  

set.seed(7245687)
nec_espec_2015 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                            NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                            TP_STATUS_REDACAO,
                            NU_NOTA_REDACAO,
                            CO_MUNICIPIO_RESIDENCIA,
                            NO_MUNICIPIO_RESIDENCIA,
                            SG_UF_RESIDENCIA,
                            TP_DEPENDENCIA_ADM_ESC,
                            TP_LOCALIZACAO_ESC,
                            NU_IDADE,
                            TP_SEXO,
                            TP_ST_CONCLUSAO,
                            TP_ESCOLA,
                            TP_COR_RACA,
                            IN_BAIXA_VISAO,
                            IN_CEGUEIRA,
                            IN_SURDEZ,
                            IN_DEFICIENCIA_AUDITIVA,
                            IN_SURDO_CEGUEIRA,
                            IN_DEFICIENCIA_FISICA,
                            IN_DEFICIENCIA_MENTAL,
                            IN_DEFICIT_ATENCAO,
                            IN_DISLEXIA,
                            IN_AUTISMO,
                            Q001, 
                            Q002,
                            Q006,
                            Q010,
                            Q024,
                            Q025,
                            Q047
                            FROM enem_2015 WHERE TP_PRESENCA_CN=1 AND 
                            TP_PRESENCA_CH=1 AND 
                            TP_PRESENCA_LC=1 AND 
                            TP_PRESENCA_MT=1 AND
                            TP_STATUS_REDACAO = 1 AND 
                            (IN_BAIXA_VISAO = 1 OR
                            IN_CEGUEIRA = 1 OR
                            IN_SURDEZ = 1 OR
                            IN_DEFICIENCIA_AUDITIVA = 1 OR
                            IN_SURDO_CEGUEIRA = 1 OR
                            IN_DEFICIENCIA_FISICA = 1 OR
                            IN_DEFICIENCIA_MENTAL = 1 OR
                            IN_DEFICIT_ATENCAO = 1 OR
                            IN_DISLEXIA = 1 OR
                            IN_AUTISMO = 1);")

write.csv2(nec_espec_2015,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/nec_espec_2015.csv")

dbDisconnect(con)

#=========================================================================
#====================          ENEM 2016        ==========================
#=========================================================================

setwd("C:/Users/welli/Documents/IC/md_2016/DADOS")

library(RSQLite)
library(DBI)
library(data.table)
library(dplyr)

con=dbConnect(RSQLite::SQLite(),dbname="enem_2016")

# dbWriteTable(conn = con, name = "enem_2016", value = "MICRODADOS_ENEM_2016.csv",
#              row.names = F, header = TRUE, sep = ";",dec=".")

dbListTables(con)
dbListFields(con,"enem_2016")

set.seed(6824164)
amostra_2016 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                          NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                          TP_STATUS_REDACAO,
                          NU_NOTA_REDACAO,
                          CO_MUNICIPIO_RESIDENCIA,
                          NO_MUNICIPIO_RESIDENCIA,
                          SG_UF_RESIDENCIA,
                          TP_DEPENDENCIA_ADM_ESC,
                          TP_LOCALIZACAO_ESC,
                          NU_IDADE,
                          TP_SEXO,
                          TP_ST_CONCLUSAO,
                          TP_ESCOLA,
                          TP_COR_RACA,
                          IN_BAIXA_VISAO,
                          IN_CEGUEIRA,
                          IN_SURDEZ,
                          IN_DEFICIENCIA_AUDITIVA,
                          IN_SURDO_CEGUEIRA,
                          IN_DEFICIENCIA_FISICA,
                          IN_DEFICIENCIA_MENTAL,
                          IN_DEFICIT_ATENCAO,
                          IN_DISLEXIA,
                          IN_AUTISMO,
                          Q001, 
                          Q002,
                          Q006,
                          Q010,
                          Q024,
                          Q025,
                          Q047
                          FROM enem_2016 WHERE TP_PRESENCA_CN=1 AND 
                          TP_PRESENCA_CH=1 AND 
                          TP_PRESENCA_LC=1 AND 
                          TP_PRESENCA_MT=1 AND
                          TP_STATUS_REDACAO = 1
                          ORDER BY RANDOM() LIMIT 100000;")

write.csv2(amostra_2016,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/amostra_2016.csv")  

set.seed(7245687)
nec_espec_2016 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                            NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                            TP_STATUS_REDACAO,
                            NU_NOTA_REDACAO,
                            CO_MUNICIPIO_RESIDENCIA,
                            NO_MUNICIPIO_RESIDENCIA,
                            SG_UF_RESIDENCIA,
                            TP_DEPENDENCIA_ADM_ESC,
                            TP_LOCALIZACAO_ESC,
                            NU_IDADE,
                            TP_SEXO,
                            TP_ST_CONCLUSAO,
                            TP_ESCOLA,
                            TP_COR_RACA,
                            IN_BAIXA_VISAO,
                            IN_CEGUEIRA,
                            IN_SURDEZ,
                            IN_DEFICIENCIA_AUDITIVA,
                            IN_SURDO_CEGUEIRA,
                            IN_DEFICIENCIA_FISICA,
                            IN_DEFICIENCIA_MENTAL,
                            IN_DEFICIT_ATENCAO,
                            IN_DISLEXIA,
                            IN_AUTISMO,
                            Q001, 
                            Q002,
                            Q006,
                            Q024,
                            Q010,
                            Q025, 
                            Q047
                            FROM enem_2016 WHERE TP_PRESENCA_CN=1 AND 
                            TP_PRESENCA_CH=1 AND 
                            TP_PRESENCA_LC=1 AND 
                            TP_PRESENCA_MT=1 AND
                            TP_STATUS_REDACAO = 1 AND 
                            (IN_BAIXA_VISAO = 1 OR
                            IN_CEGUEIRA = 1 OR
                            IN_SURDEZ = 1 OR
                            IN_DEFICIENCIA_AUDITIVA = 1 OR
                            IN_SURDO_CEGUEIRA = 1 OR
                            IN_DEFICIENCIA_FISICA = 1 OR
                            IN_DEFICIENCIA_MENTAL = 1 OR
                            IN_DEFICIT_ATENCAO = 1 OR
                            IN_DISLEXIA = 1 OR
                            IN_AUTISMO = 1);")

write.csv2(nec_espec_2016,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/nec_espec_2016.csv")

dbDisconnect(con)

#=========================================================================
#====================          ENEM 2017        ==========================
#=========================================================================

setwd("C:/Users/welli/Documents/IC/md_2017/DADOS")

library(RSQLite)
library(DBI)
library(data.table)
library(dplyr)

con=dbConnect(RSQLite::SQLite(),dbname="enem_2017")

# dbWriteTable(conn = con, name = "enem_2017", value = "MICRODADOS_ENEM_2017.csv",
#              row.names = F, header = TRUE, sep = ";",dec=".")

dbListTables(con)
dbListFields(con,"enem_2017")

set.seed(3543709)
amostra_2017 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                          NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                          TP_STATUS_REDACAO,
                          NU_NOTA_REDACAO,
                          CO_MUNICIPIO_RESIDENCIA,
                          NO_MUNICIPIO_RESIDENCIA,
                          SG_UF_RESIDENCIA,
                          TP_DEPENDENCIA_ADM_ESC,
                          TP_LOCALIZACAO_ESC,
                          NU_IDADE,
                          TP_SEXO,
                          TP_ST_CONCLUSAO,
                          TP_ESCOLA,
                          TP_COR_RACA,
                          IN_BAIXA_VISAO,
                          IN_CEGUEIRA,
                          IN_SURDEZ,
                          IN_DEFICIENCIA_AUDITIVA,
                          IN_SURDO_CEGUEIRA,
                          IN_DEFICIENCIA_FISICA,
                          IN_DEFICIENCIA_MENTAL,
                          IN_DEFICIT_ATENCAO,
                          IN_DISLEXIA,
                          IN_AUTISMO,
                          Q001, 
                          Q002,
                          Q006,
                          Q010,
                          Q024,
                          Q025,
                          Q027
                          FROM enem_2017 WHERE TP_PRESENCA_CN=1 AND 
                          TP_PRESENCA_CH=1 AND 
                          TP_PRESENCA_LC=1 AND 
                          TP_PRESENCA_MT=1 AND
                          TP_STATUS_REDACAO = 1
                          ORDER BY RANDOM() LIMIT 100000;")

write.csv2(amostra_2017,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/amostra_2017.csv")  

set.seed(104983)
nec_espec_2017 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                            NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                            TP_STATUS_REDACAO,
                            NU_NOTA_REDACAO,
                            CO_MUNICIPIO_RESIDENCIA,
                            NO_MUNICIPIO_RESIDENCIA,
                            SG_UF_RESIDENCIA,
                            TP_DEPENDENCIA_ADM_ESC,
                            TP_LOCALIZACAO_ESC,
                            NU_IDADE,
                            TP_SEXO,
                            TP_ST_CONCLUSAO,
                            TP_ESCOLA,
                            TP_COR_RACA,
                            IN_BAIXA_VISAO,
                            IN_CEGUEIRA,
                            IN_SURDEZ,
                            IN_DEFICIENCIA_AUDITIVA,
                            IN_SURDO_CEGUEIRA,
                            IN_DEFICIENCIA_FISICA,
                            IN_DEFICIENCIA_MENTAL,
                            IN_DEFICIT_ATENCAO,
                            IN_DISLEXIA,
                            IN_AUTISMO,
                            Q001, 
                            Q002,
                            Q006,
                            Q024,
                            Q010,
                            Q025, 
                            Q027
                            FROM enem_2017 WHERE TP_PRESENCA_CN=1 AND 
                            TP_PRESENCA_CH=1 AND 
                            TP_PRESENCA_LC=1 AND 
                            TP_PRESENCA_MT=1 AND
                            TP_STATUS_REDACAO = 1 AND 
                            (IN_BAIXA_VISAO = 1 OR
                            IN_CEGUEIRA = 1 OR
                            IN_SURDEZ = 1 OR
                            IN_DEFICIENCIA_AUDITIVA = 1 OR
                            IN_SURDO_CEGUEIRA = 1 OR
                            IN_DEFICIENCIA_FISICA = 1 OR
                            IN_DEFICIENCIA_MENTAL = 1 OR
                            IN_DEFICIT_ATENCAO = 1 OR
                            IN_DISLEXIA = 1 OR
                            IN_AUTISMO = 1);")

write.csv2(nec_espec_2017,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/nec_espec_2017.csv")

dbDisconnect(con)

#=========================================================================
#====================          ENEM 2018        ==========================
#=========================================================================

setwd("C:/Users/welli/Desktop/microdados_enem2018/DADOS/")

library(RSQLite)
library(DBI)
library(data.table)
library(dplyr)

con=dbConnect(RSQLite::SQLite(),dbname="enem_2018")

# dbWriteTable(conn = con, name = "enem_2018", value = "MICRODADOS_ENEM_2018.csv",
#              row.names = F, header = TRUE, sep = ";",dec=".") 

dbListTables(con)
dbListFields(con,"enem_2018")

set.seed(3862586)
amostra_2018 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                          NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                          TP_STATUS_REDACAO,
                          NU_NOTA_REDACAO,
                          CO_MUNICIPIO_RESIDENCIA,
                          NO_MUNICIPIO_RESIDENCIA,
                          SG_UF_RESIDENCIA,
                          TP_DEPENDENCIA_ADM_ESC,
                          TP_LOCALIZACAO_ESC,
                          NU_IDADE,
                          TP_SEXO,
                          TP_ST_CONCLUSAO,
                          TP_ESCOLA,
                          TP_COR_RACA,
                          IN_BAIXA_VISAO,
                          IN_CEGUEIRA,
                          IN_SURDEZ,
                          IN_DEFICIENCIA_AUDITIVA,
                          IN_SURDO_CEGUEIRA,
                          IN_DEFICIENCIA_FISICA,
                          IN_DEFICIENCIA_MENTAL,
                          IN_DEFICIT_ATENCAO,
                          IN_DISLEXIA,
                          IN_AUTISMO,
                          Q001, 
                          Q002,
                          Q006,
                          Q010,
                          Q024,
                          Q025,
                          Q027
                          FROM enem_2018 WHERE TP_PRESENCA_CN=1 AND 
                          TP_PRESENCA_CH=1 AND 
                          TP_PRESENCA_LC=1 AND 
                          TP_PRESENCA_MT=1 AND
                          TP_STATUS_REDACAO = 1
                          ORDER BY RANDOM() LIMIT 100000;")

write.csv2(amostra_2018,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/amostra_2018.csv")  

set.seed(2358526)
nec_espec_2018 = dbGetQuery(con,"SELECT TP_PRESENCA_CN,TP_PRESENCA_CH,TP_PRESENCA_LC,TP_PRESENCA_MT,
                            NU_NOTA_CN,NU_NOTA_CH,NU_NOTA_LC,NU_NOTA_MT,
                            TP_STATUS_REDACAO,
                            NU_NOTA_REDACAO,
                            CO_MUNICIPIO_RESIDENCIA,
                            NO_MUNICIPIO_RESIDENCIA,
                            SG_UF_RESIDENCIA,
                            TP_DEPENDENCIA_ADM_ESC,
                            TP_LOCALIZACAO_ESC,
                            NU_IDADE,
                            TP_SEXO,
                            TP_ST_CONCLUSAO,
                            TP_ESCOLA,
                            TP_COR_RACA,
                            IN_BAIXA_VISAO,
                            IN_CEGUEIRA,
                            IN_SURDEZ,
                            IN_DEFICIENCIA_AUDITIVA,
                            IN_SURDO_CEGUEIRA,
                            IN_DEFICIENCIA_FISICA,
                            IN_DEFICIENCIA_MENTAL,
                            IN_DEFICIT_ATENCAO,
                            IN_DISLEXIA,
                            IN_AUTISMO,
                            Q001, 
                            Q002,
                            Q006,
                            Q024,
                            Q010,
                            Q025, 
                            Q027
                            FROM enem_2018 WHERE TP_PRESENCA_CN=1 AND 
                            TP_PRESENCA_CH=1 AND 
                            TP_PRESENCA_LC=1 AND 
                            TP_PRESENCA_MT=1 AND
                            TP_STATUS_REDACAO = 1 AND 
                            (IN_BAIXA_VISAO = 1 OR
                            IN_CEGUEIRA = 1 OR
                            IN_SURDEZ = 1 OR
                            IN_DEFICIENCIA_AUDITIVA = 1 OR
                            IN_SURDO_CEGUEIRA = 1 OR
                            IN_DEFICIENCIA_FISICA = 1 OR
                            IN_DEFICIENCIA_MENTAL = 1 OR
                            IN_DEFICIT_ATENCAO = 1 OR
                            IN_DISLEXIA = 1 OR
                            IN_AUTISMO = 1);")

write.csv2(nec_espec_2018,row.names = F,file = "C:/Users/welli/Desktop/dash_enem/nec_espec_2018.csv")

dbDisconnect(con)
