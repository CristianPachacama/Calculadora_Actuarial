# Funcion de Calculo de Primas ............................................
calculo_producto = function(producto,Edad,Sexo,Tipo_interes,Duracion,Cuantia,
                            Tipo_crecimiento,Crecimiento,Gastos_internos,
                            Gastos_externos,Temporalidad, # Numero_primas,
                            Seleccion_frac,Fraccion,#Temporalidad_frac,
                            Tipo_seguro,...){
  require(lifecontingencies)
  respuesta = 
    switch (producto,
            #...............................#...............................
            # Seguros de Vida  .............#...............................
            #...............................#...............................
            '1_fallecimiento' = list(producto = producto,
                                     Tipo_seguro = Tipo_seguro,
                                     Edad = Edad, Sexo=Sexo,
                                     Tipo_interes = Tipo_interes,
                                     Duracion = Duracion,
                                     Cuantia = Cuantia,
                                     Tipo_crecimiento = Tipo_crecimiento,
                                     Crecimiento = Crecimiento,
                                     Gastos_internos = Gastos_internos,
                                     Gastos_externos = Gastos_externos,
                                     Seleccion_frac = Seleccion_frac,
                                     Temporalidad = Temporalidad,
                                     Fraccion = Fraccion),
            #...............................
            #...............................
            '1_supervivencia' = list(producto = producto,
                                     Edad = Edad, Sexo=Sexo,
                                     Tipo_interes = Tipo_interes,
                                     Duracion = Duracion,
                                     Cuantia = Cuantia,
                                     Tipo_crecimiento = Tipo_crecimiento,
                                     Crecimiento = Crecimiento,
                                     Gastos_internos = Gastos_internos,
                                     Gastos_externos = Gastos_externos,
                                     Seleccion_frac = Seleccion_frac,
                                     Temporalidad = Temporalidad,
                                     Fraccion = Fraccion),
            #...............................
            #...............................
            '1_mixto' = list(producto = producto,
                             Edad = Edad, Sexo=Sexo,
                             Tipo_interes = Tipo_interes,
                             Duracion = Duracion,
                             Cuantia = Cuantia,
                             Tipo_crecimiento = Tipo_crecimiento,
                             Crecimiento = Crecimiento,
                             Gastos_internos = Gastos_internos,
                             Gastos_externos = Gastos_externos,
                             Seleccion_frac = Seleccion_frac,
                             Temporalidad = Temporalidad,
                             Fraccion = Fraccion),
            #...............................
            #...............................
            '1_diferido' = list(producto = producto,
                                Edad = Edad, Sexo=Sexo,
                                Tipo_interes = Tipo_interes,
                                Duracion = Duracion,
                                Cuantia = Cuantia,
                                Tipo_crecimiento = Tipo_crecimiento,
                                Crecimiento = Crecimiento,
                                Gastos_internos = Gastos_internos,
                                Gastos_externos = Gastos_externos,
                                Seleccion_frac = Seleccion_frac,
                                Temporalidad = Temporalidad,
                                Fraccion = Fraccion),
            #...............................
            #...............................
            '1_cuantia_variable' = list(producto = producto,
                                        Edad = Edad, Sexo=Sexo,
                                        Tipo_interes = Tipo_interes,
                                        Duracion = Duracion,
                                        Cuantia = Cuantia,
                                        Tipo_crecimiento = Tipo_crecimiento,
                                        Crecimiento = Crecimiento,
                                        Gastos_internos = Gastos_internos,
                                        Gastos_externos = Gastos_externos,
                                        Seleccion_frac = Seleccion_frac,
                                        Temporalidad = Temporalidad,
                                        Fraccion = Fraccion),
            #...............................#...............................
            # Rentas   .....................#...............................
            #...............................#...............................
            '2_prepagables' = list(producto = producto,
                                   Edad = Edad, Sexo=Sexo,
                                   Tipo_interes = Tipo_interes,
                                   Duracion = Duracion,
                                   Cuantia = Cuantia,
                                   Tipo_crecimiento = Tipo_crecimiento,
                                   Crecimiento = Crecimiento,
                                   Gastos_internos = Gastos_internos,
                                   Gastos_externos = Gastos_externos,
                                   Seleccion_frac = Seleccion_frac,
                                   Temporalidad = Temporalidad,
                                   Fraccion = Fraccion),
            #...............................
            #...............................
            '2_pospagables' = list(producto = producto,
                                   Edad = Edad, Sexo=Sexo,
                                   Tipo_interes = Tipo_interes,
                                   Duracion = Duracion,
                                   Cuantia = Cuantia,
                                   Tipo_crecimiento = Tipo_crecimiento,
                                   Crecimiento = Crecimiento,
                                   Gastos_internos = Gastos_internos,
                                   Gastos_externos = Gastos_externos,
                                   Seleccion_frac = Seleccion_frac,
                                   Temporalidad = Temporalidad,
                                   Fraccion = Fraccion)
    )
  
  return(respuesta)
}