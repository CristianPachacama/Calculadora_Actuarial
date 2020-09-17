
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
                   # print(input$archivo$datapath)
                   if(is.null(input$archivo$datapath)) df0 = df_cartera
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
                 
               }
  )
}