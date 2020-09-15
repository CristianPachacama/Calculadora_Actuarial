# Funcion de Calculo de Primas ............................................
calculo_producto = function(producto,Tipo_seguro,Edad,Sexo,Tipo_interes,
                            Gastos_internos,Gastos_externos,Cuantia,Duracion,
                            Seleccion_frac,Temporalidad,Fraccion,
                            Tipo_crecimiento,Crecimiento,...){
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
                                     Gastos_internos = Gastos_internos,
                                     Gastos_externos = Gastos_externos,
                                     Cuantia = Cuantia,
                                     Duracion = Duracion,
                                     Seleccion_frac = Seleccion_frac,
                                     Temporalidad = Temporalidad,
                                     Fraccion = Fraccion,
                                     Tipo_crecimiento = Tipo_crecimiento,
                                     Crecimiento = Crecimiento),
            #...............................
            #...............................
            '1_supervivencia' = list(producto = producto,
                                     # Tipo_seguro = Tipo_seguro,
                                     Edad = Edad, Sexo=Sexo,
                                     Tipo_interes = Tipo_interes,
                                     Gastos_internos = Gastos_internos,
                                     Gastos_externos = Gastos_externos,
                                     Cuantia = Cuantia,
                                     Duracion = Duracion,
                                     Seleccion_frac = Seleccion_frac,
                                     Temporalidad = Temporalidad,
                                     Fraccion = Fraccion,
                                     Tipo_crecimiento = Tipo_crecimiento,
                                     Crecimiento = Crecimiento),
            #...............................
            #...............................
            '1_mixto' = list(producto = producto,
                             # Tipo_seguro = Tipo_seguro,
                             Edad = Edad, Sexo=Sexo,
                             Tipo_interes = Tipo_interes,
                             Gastos_internos = Gastos_internos,
                             Gastos_externos = Gastos_externos,
                             Cuantia = Cuantia,
                             Duracion = Duracion,
                             Seleccion_frac = Seleccion_frac,
                             Temporalidad = Temporalidad,
                             Fraccion = Fraccion,
                             Tipo_crecimiento = Tipo_crecimiento,
                             Crecimiento = Crecimiento),
            #...............................
            #...............................
            '1_diferido' = list(producto = producto,
                                # Tipo_seguro = Tipo_seguro,
                                Edad = Edad, Sexo=Sexo,
                                Tipo_interes = Tipo_interes,
                                Gastos_internos = Gastos_internos,
                                Gastos_externos = Gastos_externos,
                                Cuantia = Cuantia,
                                Duracion = Duracion,
                                Seleccion_frac = Seleccion_frac,
                                Temporalidad = Temporalidad,
                                Fraccion = Fraccion,
                                Tipo_crecimiento = Tipo_crecimiento,
                                Crecimiento = Crecimiento),
            #...............................
            #...............................
            '1_cuantia_variable' = list(producto = producto,
                                        # Tipo_seguro = Tipo_seguro,
                                        Edad = Edad, Sexo=Sexo,
                                        Tipo_interes = Tipo_interes,
                                        Gastos_internos = Gastos_internos,
                                        Gastos_externos = Gastos_externos,
                                        Cuantia = Cuantia,
                                        Duracion = Duracion,
                                        Seleccion_frac = Seleccion_frac,
                                        Temporalidad = Temporalidad,
                                        Fraccion = Fraccion,
                                        Tipo_crecimiento = Tipo_crecimiento,
                                        Crecimiento = Crecimiento),
            #...............................#...............................
            # Rentas   .....................#...............................
            #...............................#...............................
            '2_prepagables' = list(producto = producto,
                                   # Tipo_seguro = Tipo_seguro,
                                   Edad = Edad, Sexo=Sexo,
                                   Tipo_interes = Tipo_interes,
                                   Gastos_internos = Gastos_internos,
                                   Gastos_externos = Gastos_externos,
                                   Cuantia = Cuantia,
                                   Duracion = Duracion,
                                   Seleccion_frac = Seleccion_frac,
                                   Temporalidad = Temporalidad,
                                   Fraccion = Fraccion,
                                   Tipo_crecimiento = Tipo_crecimiento,
                                   Crecimiento = Crecimiento),
            #...............................
            #...............................
            '2_pospagables' = list(producto = producto,
                                   # Tipo_seguro = Tipo_seguro,
                                   Edad = Edad, Sexo=Sexo,
                                   Tipo_interes = Tipo_interes,
                                   Gastos_internos = Gastos_internos,
                                   Gastos_externos = Gastos_externos,
                                   Cuantia = Cuantia,
                                   Duracion = Duracion,
                                   Seleccion_frac = Seleccion_frac,
                                   Temporalidad = Temporalidad,
                                   Fraccion = Fraccion,
                                   Tipo_crecimiento = Tipo_crecimiento,
                                   Crecimiento = Crecimiento)
    )
  
  return(respuesta)
}