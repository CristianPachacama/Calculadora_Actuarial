library(shiny)
# library(shinyjs)
library(shinythemes)
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


ui = navbarPage("Calculadora Actuarial", id="nav",theme = shinytheme("flatly"),
                
                # Seguros de Vida -----------------------------------------------
                navbarMenu("Seguros de  Vida",
                           # Fallecimiento ...........................
                           tabPanel("Fallecimiento",
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_1_1'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_1_1')
                                    
                           ),
                           # Supervivencia  ..............................
                           tabPanel("Superviviencia",
                                    
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_1_2'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_1_2')
                                    
                           ),
                           # Mixto  ..............................
                           tabPanel("Mixto",
                                    
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_1_3'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_1_3')
                                    
                           ),
                           # Diferido  ..............................
                           tabPanel("Diferido",
                                    
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_1_4'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_1_4')
                                    
                           ),
                           # Cuantia Variable   .......................
                           tabPanel("Cuantía Variable",
                                    
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_1_5'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_1_5')
                                    
                           )
                ),
                
                # Rentas  --------------------------------------
                navbarMenu("Rentas",
                           # Prepagables .......................
                           tabPanel("Prepagables",
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_2_1'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_2_1')
                                    
                           ),
                           
                           # Pospagables .......................
                           tabPanel("Pospagables",
                                    # SALIDAS RESULTADOS  ............
                                    verbatimTextOutput(outputId = 'resp_panel_2_2'),
                                    
                                    # PANEL DE PARAMETROS ............
                                    PanelLateralUI('panel_2_2')
                                    
                           )
                )
                
                
                
)




#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define server  -------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
server = function(input, output, session) {
    
    # Actulizar Tipo Seguro  .......................
    # output$cobertura = renderUI({
    #     
    #     widg_cobertura = switch(input$tipo_seguro,
    #                          'Entera' = {
    #                              br()
    #                          },
    #                          'Temporal' = {
    #                              numericInput(inputId = 'cobertura',
    #                                           label = 'Valor cobertura',
    #                                           value = 0 , min = 0)
    #                          }
    #     )
    #     return(widg_cobertura)
    # })
    
    
    
    # Calculos Seguros de Vida ..........
    calc_panel_1_1 = PanelLateralServer('panel_1_1',producto='1_fallecimiento')
    calc_panel_1_2 = PanelLateralServer('panel_1_2',producto='1_supervivencia')
    calc_panel_1_3 = PanelLateralServer('panel_1_3',producto='1_mixto')
    calc_panel_1_4 = PanelLateralServer('panel_1_4',producto='1_diferido')
    calc_panel_1_5 = PanelLateralServer('panel_1_5',producto='1_cuantia_variable')
    
    # Calculos de Rentas
    calc_panel_2_1 = PanelLateralServer('panel_2_1',producto='2_prepagables')
    calc_panel_2_2 = PanelLateralServer('panel_2_2',producto='2_pospagables')
    
    # Renders ..........................
    output$resp_panel_1_1 = renderPrint({
        calc_panel_1_1()
    })
    output$resp_panel_1_2 = renderPrint({
        calc_panel_1_2()
    })
    output$resp_panel_1_3 = renderPrint({
        calc_panel_1_3()
    })
    output$resp_panel_1_4 = renderPrint({
        calc_panel_1_4()
    })
    output$resp_panel_1_5 = renderPrint({
        calc_panel_1_5()
    })
    # ..................................
    output$resp_panel_2_1 = renderPrint({
        calc_panel_2_1()
    })
    output$resp_panel_2_2 = renderPrint({
        calc_panel_2_2()
    })
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Run APP   -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
shinyApp(ui = ui, server = server)
