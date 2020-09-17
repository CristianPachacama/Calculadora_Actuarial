
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
          
          box(title = "Datos Cartera",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              h3('aaaaa'),
              # Subida Archivos .................
              fileInput(inputId = ns("archivo"), "Subir archivo excel",
                        # multiple = FALSE,
                        accept = c(".xlsx")),
              # Tabla Datos ...................
              dataTableOutput(outputId = ns("tabla"))  
          ),
          
          box(title = "Resumen Cartera",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              h3('bbbb')
          ),
          box(title = "Datos Seguro",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              h3('cccc')
          ),
          box(title = "Resumen Cruzado",status = "primary",
              solidHeader = FALSE,collapsible = TRUE,
              h3('dddd')
          )
  )
}