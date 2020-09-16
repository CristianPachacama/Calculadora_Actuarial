
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define server  -------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ModuloServer = function(id, producto = id){
  
  moduleServer(id,
               # Empieza Servidor Modulo  ..................................
               function(input,output,session){
                 
                 # Actualizar Widget Tipo Seguro  ..........................
                 output$wid_tipo_seguro = renderUI({
                   ns = session$ns
                   if(producto == '1_fallecimiento'|producto=='1_diferido'){
                     widg_tipo_seg = selectInput(inputId = ns('tipo_seguro'),
                                                 label='Tipo Seguro:',
                                                 choices = c('Entera',
                                                             'Temporal'), 
                                                 width='90%')
                   }else{
                     widg_tipo_seg = NULL
                   }
                   return(widg_tipo_seg)
                 })
                 
                 # Actualizar Widget Duracion  ..........................
                 output$wid_duracion = renderUI({
                   ns = session$ns
                   Tipo_seguro = input$tipo_seguro
                   if(is.null(Tipo_seguro)) Tipo_seguro = 'Temporal'
                   if(Tipo_seguro=='Temporal'){
                     wid_dura = numericInput(inputId = ns('duracion'), 
                                             label = 'Duración de Prestación (años)', 
                                             value = 1, min = 1, max = 95, step = NA, width='90%')
                   }else{
                     wid_dura = NULL
                   }
                   
                   return(wid_dura)
                 })
                 
                 
                 # Actualizar Tipo Crecimiento  .................................
                 output$wid_tipo_crecim = renderUI({
                   ns = session$ns
                   if(producto=='1_cuantia_variable'){
                     wid_tipo_creci = selectInput(inputId = ns('tipo_crecim'),
                                                  label='Tipo de crecimiento',
                                                  choices = c('Geométrico' = 'Geometrico', 
                                                              'Aritmético' = 'Aritmetico'),
                                                  selected = 1, width='90%')
                   }else{
                     wid_tipo_creci = NULL
                   }
                   
                   return(wid_tipo_creci)
                 })
                 
                 
                 # Actulizar Crecimiento    ......................................
                 output$wid_crecimiento = renderUI({
                   ns = session$ns
                   try({Tipo_crecim = input$tipo_crecim})
                   if(is.null(Tipo_crecim)) Tipo_crecim = 'NO ES CUANTIA VARIABLE'
                   widg_crecim = switch(Tipo_crecim,
                                        'Geometrico' = {
                                          sliderInput(inputId = ns('crecimiento'), 
                                                      label = 'Crecimiento de la Prestación:', 
                                                      min = 0, max = 100, 
                                                      value = 4, 
                                                      step = 0.1, round = FALSE, 
                                                      format = "#,##0.#####", 
                                                      post  = " %",
                                                      locale = "us", 
                                                      ticks = TRUE, animate = FALSE)
                                        },
                                        'Aritmetico' = {
                                          numericInput(inputId = ns('crecimiento'),
                                                       label = 'Crecimiento de la Prestación',
                                                       value = 0 , min = 0, width='90%')
                                        }
                   )
                   return(widg_crecim)
                 })
                 
                 # Actualizar Widget Temporalidad Primas  ..........................
                 output$wid_temporalidad = renderUI({
                   ns = session$ns
                   widg_tempo = switch(input$tipo_fraccion,
                                       'Si' = {
                                         selectInput(inputId = ns('temporalidad'),
                                                     label='Temporalidad de Primas:',
                                                     choices = c('Mensual',
                                                                 'Trimestral',
                                                                 'Semestral'), 
                                                     width='90%')
                                       },
                                       'No' = {
                                         NULL
                                       }
                   )
                   return(widg_tempo)
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
                                          NULL
                                        }
                   )
                   return(widg_crecim)
                 })
                 
                 # Actualizar Widget Diferimiento  ..........................
                 output$wid_diferido = renderUI({
                   ns = session$ns
                   if(producto=='1_diferido'){
                     wid_difer = numericInput(inputId = ns('diferido'), 
                                              label = 'Diferimiento (años)', 
                                              value = 1, min = 1, max = 95, 
                                              step = NA, width='90%')
                   }else{
                     wid_difer = NULL
                   }
                   
                   return(wid_difer)
                 })
                 
                 
                 
                 #............................................................................
                 # PARAMETROS Y CALCULOS .....................................................
                 #............................................................................
                 resultado = reactive({
                   try({
                     Tipo_seguro = NULL
                     Tipo_seguro = input$tipo_seguro
                   }) 
                   
                   try({
                     Edad = input$edad
                     Edad = age(as.Date(Edad))
                     # print(Edad)
                   })
                   try({Sexo = input$sexo})
                   try({Tipo_interes = input$tipo_interes/100})
                   try({Duracion = input$duracion})
                   try({Cuantia = input$cuantia})
                   
                   try({
                     Tipo_crecimiento = NULL
                     Tipo_crecimiento = input$tipo_crecim
                   })
                   try({
                     Crecimiento = NULL
                     if(Tipo_crecimiento == 'Geometrico') Crecimiento = input$crecimiento/100
                     if(Tipo_crecimiento == 'Aritmetico') Crecimiento = input$crecimiento
                   })
                   
                   try({Gastos_internos = input$gasto_int/100})
                   try({Gastos_externos = input$gasto_ext/100})
                   # try({Numero_primas = input$numero_primas}) # Se calcula con fraccionamiento
                   
                   try({Seleccion_frac = input$tipo_fraccion})
                   try({
                     aux = input$temporalidad
                     if(is.null(aux)) aux = 'Sin Fraccion'
                     Temporalidad = switch (aux,
                                            'Mensual' = 12,
                                            'Trimestral' = 4,
                                            'Semestral' = 2
                     )
                   })
                   try({Fraccion = input$fraccion})
                   
                   try({Diferido = input$diferido})
                   
                   #............................................................
                   # Ejecucion Calculos ........................................
                   #............................................................
                   calculos = calculo_producto(producto = producto,
                                               Edad = Edad, Sexo = Sexo,
                                               Tipo_interes = Tipo_interes,
                                               Duracion = Duracion,
                                               Cuantia = Cuantia,
                                               Tipo_crecimiento = Tipo_crecimiento,
                                               Crecimiento = Crecimiento,
                                               Gastos_internos = Gastos_internos,
                                               Gastos_externos = Gastos_externos,
                                               Temporalidad = Temporalidad,
                                               Seleccion_frac = Seleccion_frac,
                                               Fraccion = Fraccion,
                                               Tipo_seguro = Tipo_seguro,
                                               Diferido = Diferido)
                   # calculos = calculo_producto(producto,Edad)
                   return(calculos)
                 })
                 
                 #................................................
                 # Print Resultados ..............................
                 #................................................
                 output$print_resultados = renderPrint({
                   resultado()
                 })
                 
                 
                 #................................................
                 # Visualizaciones ...............................
                 #................................................
                 output$box_prima_pura = renderInfoBox({
                   prima = resultado()$prima_pura
                   titulo = "Prima Pura"
                   if(is.null(prima)){
                     prima = 0; color = 'black'
                   }else{
                     color = 'blue'
                   }
                   try({
                     caja = infoBox(title = titulo, fill = TRUE,
                                    value = round(prima,2),
                                    icon = icon("stats", lib = "glyphicon"),color=color)
                   })
                   return(caja)
                 })
                 #....
                 output$box_prima_inventario = renderInfoBox({
                   prima = resultado()$prima_inventario
                   titulo = "Prima inventario"
                   if(is.null(prima)){
                     prima = 0; color = 'black'
                   }else{
                     color = 'purple'
                   }
                   try({
                     caja = infoBox(title = titulo, fill = TRUE,
                                    value = round(prima,2),
                                    icon = icon("stats", lib = "glyphicon"),color=color)
                   })
                   return(caja)
                 })
                 #....
                 output$box_prima_comercial = renderInfoBox({
                   prima = resultado()$prima_comercial
                   titulo = "Prima comercial"
                   if(is.null(prima)){
                     prima = 0; color = 'black'
                   }else{
                     color = 'yellow'
                   }
                   try({
                     caja = infoBox(title = titulo, fill = TRUE,
                                    value = round(prima,2),
                                    icon = icon("stats", lib = "glyphicon"),color=color)
                   })
                   return(caja)
                 })
                 # .............................................
                 # Primas no fijas .............................
                 # .............................................
                 output$box_prima_fraccionada = renderInfoBox({
                   prima = resultado()$prima_fraccionada
                   titulo = "Prima fraccionada"
                   if(is.null(prima)){
                     prima = 0; color = 'black'
                   }else{
                     color = 'blue'
                   }
                   try({
                     caja = infoBox(title = titulo, fill = TRUE,
                                    value = round(prima,2),
                                    icon = icon("stats", lib = "glyphicon"),color=color)
                   })
                   return(caja)
                 })
                 #....
                 output$box_prima_nivelada = renderInfoBox({
                   prima = resultado()$prima_nivelada
                   titulo = "Prima nivelada"
                   if(is.null(prima)){
                     prima = 0; color = 'black'
                   }else{
                     color = 'blue'
                   }
                   try({
                     caja = infoBox(title = titulo, fill = TRUE,
                                    value = round(prima,2),
                                    icon = icon("stats", lib = "glyphicon"),color=color)
                   })
                   return(caja)
                 })
                 
                 
                 # .............................................
                 # Grafico Reserva .............................
                 # .............................................
                 output$wid_reserva = renderUI({
                   ns = session$ns
                   # Parametros
                   try({
                     Tipo_seguro = NULL
                     Tipo_seguro = input$tipo_seguro
                   })
                   try({
                     Seleccion_frac = input$tipo_fraccion
                   })
                   if(is.null(Tipo_seguro)) Tipo_seguro = 'Temporal'
                   
                   # Wiget de Grafico Reserva ......
                   if(Tipo_seguro=='Temporal' & Seleccion_frac=='No'){
                     wid_reser = highchartOutput(ns('graf_reserva'))
                   }
                   if(Tipo_seguro=='Entera'){
                     wid_reser = br()
                   }
                   return(wid_reser)
                 })
                 
                 # Grafico Reserva ......................
                 output$graf_reserva = renderHighchart({
                   try({
                     Duracion = NULL
                     Duracion = input$duracion
                   })
                   
                   df = data.frame(t = 0:Duracion, Reserva = resultado()$reserva )
                   
                   hchart(df,type = "area",
                          hcaes(x = t, y = Reserva),
                          name = "Reserva",
                          color = "#1abc9c",
                          showInLegend = TRUE
                   )
                 })
                 
                 
                 return(resultado)
                 
               }
  )
  
}

