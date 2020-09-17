
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Define server  -------------------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ModuloExtraServer = function(id, producto = id){
  
  moduleServer(id,
               # Empieza Servidor Modulo  ..................................
               function(input,output,session){
                 
                 # Archivo Subido ......................
                 datos = reactive({
                   # df0 = df_cartera
                   shiny::req(input$archivo)
                   inFile = input$archivo
                   if(is.null(inFile)) cat("******** No hay archivo  *********")
                   df0 = read_excel(inFile$datapath, 1)
                   
                   return(df0)
                 })
                 
                 # Tabla de Datos .........................
                 output$tabla = renderDataTable({
                   df0 = df_cartera
                   # shiny::req(input$archivo)
                   
                   if(!is.null(input$archivo$datapath)) df0 = datos()
                   
                   datatable(df0, rownames = F, 
                             extensions = c('FixedColumns','Scroller'),
                             options = list(
                               dom = 't',
                               pageLength = 10,
                               scrollX = TRUE,
                               fixedColumns = TRUE,
                               deferRender = TRUE,
                               scrollY = 200,
                               scroller = TRUE
                             ))
                 })
                 
                 # Grafico Variable Sexo  .....................
                 output$graf_sexo = renderHighchart({
                   df0 = df_cartera
                   # shiny::req(input$archivo)
                   if(!is.null(input$archivo$datapath)) df0 = datos()
                   
                   df = count(df0, sexo)
                   
                   hc <- df %>% 
                     hchart('column', hcaes(x = 'sexo', y = 'n', group = 'sexo')) %>%
                     hc_colors(c("#00AFBB", "#E7B800"))
                   
                 })
                 
                 
                 # Grafico Variable Edad  .....................
                 output$graf_edad = renderPlotly({
                   df0 = df_cartera
                   # shiny::req(input$archivo)
                   if(!is.null(input$archivo$datapath)) df0 = datos()
                   
                   df = df0
                   df$Edad = age(df$fecha_nacimiento)
                   
                   df %>%
                     plot_ly(
                       x = ~sexo,
                       y = ~Edad,
                       split = ~sexo,
                       type = 'violin',
                       box = list(
                         visible = T
                       ),
                       meanline = list(
                         visible = T
                       )
                     ) %>%
                     layout(
                       xaxis = list(
                         title = "Sexo"
                       ),
                       yaxis = list(
                         title = "Edad",
                         zeroline = F
                       ),
                       # Fondo Transparente
                       plot_bgcolor  = "rgba(0, 0, 0, 0)",
                       paper_bgcolor = "rgba(0, 0, 0, 0)",
                       fig_bgcolor   = "rgba(0, 0, 0, 0)"
                     )
                   
                   
                 })
                 
                 # Duracion vs Cuantia .................
                 output$graf_dura_cuant = renderHighchart({
                   
                   df0 = df_cartera
                   # shiny::req(input$archivo)
                   if(!is.null(input$archivo$datapath)) df0 = datos()
                   
                   hc = df0 %>% 
                     hchart('scatter', hcaes(x = duracion, y = cuantia, group = sexo)) %>%
                     hc_colors(c("#00AFBB", "#E7B800"))
                 })
                 
                 # Gastos Internos vs Externos  ..............
                 output$graf_gastos = renderHighchart({
                   
                   df0 = df_cartera
                   # shiny::req(input$archivo)
                   if(!is.null(input$archivo$datapath)) df0 = datos()
                   
                   hc = df0 %>% 
                     hchart('scatter', hcaes(x = gastos_internos, y = gastos_externos, group = sexo)) %>%
                     hc_colors(c("#00AFBB", "#E7B800"))
                 })
                 
               }
  )
}