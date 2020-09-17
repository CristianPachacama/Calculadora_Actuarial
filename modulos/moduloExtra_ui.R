
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define UI -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ModuloExtraUI = function(id = "i_producto", titulo="Titulo_Pestania"){
  
  ns = NS(id)
  #............................................................
  # Tabla de Datos ............................................
  #............................................................
  tabItem(tabName = id,
          h3(titulo),
          
          # CAJA  ......................................
          box(title = "Datos Cartera",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              
              # Subida Archivos .................
              fileInput(inputId = ns("archivo"), "Subir archivo excel",
                        # multiple = FALSE,
                        accept = c(".xlsx")),
              # Tabla Datos ...................
              dataTableOutput(outputId = ns("tabla"))  
          ),
          
          
          # CAJA PRIMAS AGREGADAS   ....................
          box(title = "Valores Agregados Primas",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              # h3('cccc'),
              fluidRow(
                infoBoxOutput(outputId = ns('box_prima_pura')),
                infoBoxOutput(outputId = ns('box_prima_inventario')),
                infoBoxOutput(outputId = ns('box_prima_comercial')) 
              ),
              fluidRow(
                infoBoxOutput(outputId = ns('box_prima_fraccionada')),
                infoBoxOutput(outputId = ns('box_prima_nivelada'))
              )
          ),
          
          # CAJA  ......................................
          box(title = "Edad vs Sexo",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              # h3('bbbb'),
              fluidRow(
                column(6,
                       highchartOutput(outputId = ns('graf_sexo'))
                ),
                column(6,
                       plotlyOutput(outputId = ns('graf_edad'))
                )
              )
          ),
          
          # CAJA  ......................................
          box(title = "Duración vs Cuantía",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              # h3('dddd')
              highchartOutput(outputId = ns('graf_dura_cuant'))
          ),
          # CAJA  ......................................
          box(title = "Gastos Internos vs Externos",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              # h3('dddd')
              highchartOutput(outputId = ns('graf_gastos'))
          )
  )
}