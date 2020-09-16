library(shiny)
# library(shinyjs)
library(shinythemes)
library(shinydashboard)
library(lubridate)
library(lifecontingencies)

load('datos/tablas_listas.RData')
source(file = 'modulos/panel_lateral.R',local = T)
# source(file = 'codigo/calculos.R',local = T)
source(file = 'codigo/calculos_testeo.R',local = T)
source(file = 'codigo/extras.R',local = T)

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define UI -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# ui <- fluidPage(
#     
#     # Application title
#     titlePanel("Caculadora Actuarial"),
# 
#     # Sidebar with a slider input for number of bins
#     
#         sidebarPanel(sidebarLayout(
#             PanelLateralUI('panel_1_1')
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#             verbatimTextOutput(outputId = 'resp_panel_1_1')
#         )
#     )
# )
#     


ui = navbarPage(title ="Calculadora Actuarial", id="calculadora",
                header = tags$h2(" - ",tags$head(tags$link(rel='shortcut icon', 
                                                           href='epn.ico', 
                                                           type='image/x-icon'))),
                position = "fixed-top",theme=shinytheme('flatly'),#theme = 'estilo.css',
                footer = fluidRow(column(12,img(src='epn_logo.png',width='30px',align='center'),
                                         tags$b('Proyecto: '),' "Calculadora Actuarial".' ,
                                         '-',tags$a('Facultad de Ciencias - Ingenieria Matemática - EPN (2020)',href='http://www.epn.edu.ec'),
                                         tags$b('  ||  '),tags$b('Desarrollado por: '),
                                         tags$a('Isabel Zambrano',href='http://www.linkedin.com/')
                )
                ),
                
                
                # Seguros de Vida -----------------------------------------------
                navbarMenu("Seguros de  Vida",
                           # Fallecimiento ...........................
                           PanelLateralUI('panel_1_1',titulo='Fallecimiento'),
                           # Supervivencia  ..............................
                           PanelLateralUI('panel_1_2',titulo='Superviviencia'),
                           # Mixto  ..............................
                           PanelLateralUI('panel_1_3',titulo='Mixto'),
                           # Diferido  ..............................
                           PanelLateralUI('panel_1_4',titulo='Diferido'),
                           # Cuantia Variable   .......................
                           PanelLateralUI('panel_1_5',titulo='Cuantía Variable')
                           
                ),
                
                # Rentas  --------------------------------------
                navbarMenu("Rentas",
                           # Prepagables .......................
                           PanelLateralUI('panel_2_1',titulo='Prepagables'),
                           # Pospagables .......................
                           PanelLateralUI('panel_2_2',titulo='Pospagables')
                           
                )
                
)




#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define server  -------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
server = function(input, output, session) {
    
    # Calculos Seguros de Vida ..........
    PanelLateralServer('panel_1_1',producto='1_fallecimiento')
    PanelLateralServer('panel_1_2',producto='1_supervivencia')
    PanelLateralServer('panel_1_3',producto='1_mixto')
    PanelLateralServer('panel_1_4',producto='1_diferido')
    PanelLateralServer('panel_1_5',producto='1_cuantia_variable')
    
    # Calculos de Rentas
    PanelLateralServer('panel_2_1',producto='2_prepagables')
    PanelLateralServer('panel_2_2',producto='2_pospagables')
    
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Run APP   -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
shinyApp(ui = ui, server = server)
