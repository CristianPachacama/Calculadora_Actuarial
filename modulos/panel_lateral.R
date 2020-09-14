
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define UI -------------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

PanelLateralUI = function(id){
  
  ns = NS(id)
  
  # Panel Lateral .............................................
  absolutePanel(
    top = 70, right = 50, width = 600, height = 180,
    draggable = TRUE, fixed = FALSE,
    wellPanel(
      # Titulo Panel
      h3('Parámetros',align='center'),
      hr(),
      # PARAMETROS
      
      fluidRow(
        column(6,
               # Fecha de Nacimiento 
               dateInput(inputId = ns('edad'), 
                         label = 'Fecha de nacimiento:', 
                         value = NULL, 
                         min = NULL, max = NULL, 
                         format = "yyyy-mm-dd", 
                         startview = "year", 
                         weekstart = 0, language = "es", width='90%'),
               # Sexo
               radioButtons(inputId = ns('sexo'),
                            label = 'Sexo:', 
                            choices = c('Hombre'=1,'Mujer'=2), 
                            selected = NULL, width='90%'),
               # Tipo de interes
               sliderInput(inputId = ns('interes'), 
                           label = 'Tipo de interés', 
                           min = 0, max = 100, 
                           value = 6, 
                           step = 0.1, round = FALSE, 
                           format = "#,##0.#####", 
                           post  = " %",
                           locale = "us", 
                           ticks = TRUE, 
                           animate = FALSE, 
                           width='90%'),
               # Duracion Prestacion
               numericInput(inputId = ns('duracion'), 
                            label = 'Duración de Prestación (años)', 
                            value = NA, min = 1, max = 95, step = NA, width='90%'),
               # Seleccion Capital o renta
               numericInput(inputId = ns('capital_renta'), 
                            label = 'Cuantía:', 
                            value = NA, min = 0, step = NA, width='90%'),
               # Crecimiento Prestacion
               selectInput(inputId = ns('tipo_crecim'),
                           label='Tipo de crecimiento',
                           choices = c('Geométrico' = 'Geometrico', 
                                       'Aritmético' = 'Aritmetico'),
                           selected = 1, width='90%'),
               # Actualizar en Server segun tipo:
               uiOutput(outputId = ns("crecimiento_input"))
               
        ),
        
        # Columna 2 ............................................
        column(6,
               
               # Gastos Internos
               sliderInput(inputId = ns('gasto_int'), 
                           label = 'Gastos Internos', 
                           min = 0, max = 100, 
                           value = 4, 
                           step = 0.1, round = FALSE, 
                           format = "#,##0.#####", 
                           post  = " %",
                           locale = "us", 
                           ticks = TRUE, animate = FALSE, 
                           width='90%'),
               # Gastos Internos
               sliderInput(inputId = ns('gasto_ext'), 
                           label = 'Gastos Externos', 
                           min = 0, max = 100, 
                           value = 4, 
                           step = 0.1, round = FALSE, 
                           format = "#,##0.#####", 
                           post  = " %",
                           locale = "us", 
                           ticks = TRUE, animate = FALSE, 
                           width='90%'),
               # Numero de Primas
               numericInput(inputId = ns('numero_primas'), 
                            label = 'Número de Primas a Pagar:', 
                            value = 1, min = 1, max = NA, step = NA, width='90%'),
               # Temporalidad
               selectInput(inputId = ns('temporalidad'),
                           label='Temporalidad de Primas',
                           choices = c('Mensual',
                                       'Trimestral',
                                       'Semestral',
                                       'Anual'), 
                           width='90%'),
               
               # Fraccionar
               hr(),
               selectInput(inputId = ns('tipo_fraccion'),
                           label='Desea Fraccionar:',
                           choices = c('Si',
                                       'No'),
                           selected = 'No',
                           width='90%'),
               # Actualizar Widget Cantidad Fraccion
               uiOutput(outputId = ns("wid_fraccion"))
        )
      )
      
      
    ),
    style = "opacity: 0.9"
  )
  
  
  
  
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define server  -------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

PanelLateralServer = function(id,producto){
  
  moduleServer(id,
               
               # Empieza Servidor Modulo  .............................................
               
               function(input,output,session){
                 
                 # Actulizar Tipo Crecimiento    ......................................
                 output$crecimiento_input = renderUI({
                   ns = session$ns
                   widg_crecim = switch(input$tipo_crecim,
                                        'Geometrico' = {
                                          sliderInput(inputId = ns('crecimiento_g'), 
                                                      label = 'Crecimiento de la Prestación', 
                                                      min = 0, max = 100, 
                                                      value = 4, 
                                                      step = 0.1, round = FALSE, 
                                                      format = "#,##0.#####", 
                                                      post  = " %",
                                                      locale = "us", 
                                                      ticks = TRUE, animate = FALSE)
                                        },
                                        'Aritmetico' = {
                                          numericInput(inputId = ns('crecimiento_a'),
                                                       label = 'Crecimiento de la Prestación',
                                                       value = 0 , min = 0, width='90%')
                                        }
                   )
                   return(widg_crecim)
                 })
                 
                 
                 # Actualizar Widget Fraccion  .....................................
                 output$wid_fraccion = renderUI({
                   ns = session$ns
                   widg_crecim = switch(input$tipo_fraccion,
                                        'Si' = {
                                          numericInput(inputId = ns('fraccion'),
                                                       label = 'Fraccionamiento (años):',
                                                       value = 1 , min = 1, width='90%')
                                        },
                                        'No' = {
                                          br()
                                        }
                   )
                   return(widg_crecim)
                 })
                 
                 
                 
                 # PRODUCTOS (switch cases) ...................................................
                 resultado = reactive({
                   # validate(need(input$edad, 'Verificar Edad'),
                   #          need(input$sexo, 'Verificar Sexo'),
                   #          need(input$tipo_interes, 'Verificar Tipo Interes'),
                   #          need(input$duracion, 'Verificar Duracion'),
                   #          need(input$cuantia, 'Verificar Cuantia'),
                   #          need(input$tipo_crecim, 'Verificar Tipo Crecimiento'),
                   #          need(input$crecimiento, 'Verificar Crecimiento'),
                   #          need(input$gastos_internos, 'Verificar Gastos Internos'),
                   #          need(input$gastos_externos, 'Verificar Gastos Externos'),
                   #          need(input$numero_primas, 'Verificar Numero Primas'),
                   #          need(input$temporalidad, 'Verificar Temporalidad'),
                   #          need(input$seleccion_frac, 'Verificar Seleccion Fraccion'),
                   #          need(input$fraccion, 'Verificar Fraccion'),
                   #          need(input$temporalidad_frac, 'Verificar Temporalidad Fraccion'),
                   #          need(input$tipo_seguro, 'Verificar Tipop Seguro'),
                   # 
                   # )
                   # 
                   # try({Edad = input$edad})
                   # try({Sexo = input$sexo})
                   # try({Tipo_interes = input$tipo_interes})
                   # try({Duracion = input$duracion})
                   # try({Cuantia = input$cuantia})
                   # try({Tipo_crecimiento = input$tipo_crecim})
                   # try({Crecimiento = input$crecimiento})
                   # try({Gastos_internos = input$gastos_internos})
                   # try({Gastos_externos = input$gastos_externos})
                   # try({Numero_primas = input$numero_primas})
                   # try({Temporalidad = input$temporalidad})
                   # try({Seleccion_frac = input$seleccion_frac})
                   # try({Fraccion = input$fraccion})
                   # try({Temporalidad_frac = input$temporalidad_frac})
                   # try({Tipo_seguro = input$tipo_seguro})
                   # 
                   # calculos = calculo_producto(producto,Edad,Sexo,Tipo_interes,Duracion,Cuantia,
                   #                             Tipo_crecimiento,Crecimiento,Gastos_internos,
                   #                             Gastos_externos, Numero_primas,Temporalidad,
                   #                             Seleccion_frac,Fraccion,Temporalidad_frac,
                   #                             Tipo_seguro)
                   calculos = calculo_producto(producto)
                   return(calculos)
                 })
                 
                 return(resultado)
                 
               }
  )
  
}