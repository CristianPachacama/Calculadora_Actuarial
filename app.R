library(shiny)
library(shinythemes)
library(shinydashboard)
library(dashboardthemes)
library(lifecontingencies)
library(highcharter)
library(lubridate)

load('datos/tablas_listas.RData')
source(file = 'modulos/modulo_server.R',local = T)
source(file = 'modulos/modulo_ui.R',local = T)
source(file = 'codigo/calculos.R',local = T)
source(file = 'codigo/extras.R',local = T)

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define UI -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ui = dashboardPage(
    # ENCABEZADO ...............................
    dashboardHeader(title = "Calculadora actuarial"),
    # PESTANIAS MENU ...........................
    dashboardSidebar(
        sidebarMenu(
            # SEGUROS
            menuItem("Seguros de Vida",tabName = "seguros_vida",icon = icon("list"),
                     menuSubItem('Fallecimiento',tabName = '1_fallecimiento',icon = icon('line-chart')),
                     menuSubItem('Supervivencia',tabName = '1_supervivencia',icon = icon('line-chart')),
                     menuSubItem('Mixto',tabName = '1_mixto',icon = icon('line-chart')),
                     menuSubItem('Diferido',tabName = '1_diferido',icon = icon('line-chart')),
                     menuSubItem('Cuantía Variable',tabName = '1_cuantia_variable',icon = icon('line-chart'))
            ),
            # RENTAS
            menuItem("Rentas",tabName = "rentas",icon = icon("list"),
                     menuSubItem('Prepagables',tabName = '2_prepagables',icon = icon('line-chart')),
                     menuSubItem('Pospagables',tabName = '2_pospagables',icon = icon('line-chart'))
            )
        )
    ),
    
    # CUERPO  ......................................
    dashboardBody(
        # Custom theme .............................
        shinyDashboardThemes(theme = "blue_gradient"), 
        # c('blue_gradient','flat_red','grey_light','grey_dark','onenote','poor_mans_flatly','purple_gradient')
        
        tabItems(
            
            # Fallecimiento ...........................
            ModuloUI(id='1_fallecimiento',titulo='Fallecimiento'),
            # Supervivencia  ..............................
            ModuloUI(id='1_supervivencia',titulo='Superviviencia'),
            # Mixto  ..............................
            ModuloUI(id='1_mixto',titulo='Mixto'),
            # Diferido  ..............................
            ModuloUI(id='1_diferido',titulo='Diferido'),
            # Cuantia Variable   .......................
            ModuloUI(id='1_cuantia_variable',titulo='Cuantía Variable'),
            
            
            # Prepagables .......................
            ModuloUI(id='2_prepagables',titulo='Prepagables'),
            # Pospagables .......................
            ModuloUI(id='2_pospagables',titulo='Pospagables')
            
        )
        
    )
)


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define server  -------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
server = function(input, output, session) {
    
    # Calculos Seguros de Vida ..........
    ModuloServer(id = '1_fallecimiento')
    ModuloServer(id = '1_supervivencia')
    ModuloServer(id = '1_mixto')
    ModuloServer(id = '1_diferido')
    ModuloServer(id = '1_cuantia_variable')
    
    # Calculos de Rentas
    ModuloServer(id = '2_prepagables')
    ModuloServer(id = '2_pospagables')
    
    
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Run APP   -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
shinyApp(ui = ui, server = server)
