# Funciones Extras

# Edad  ......................
age = function(dob, age.day = today(), units = "years", floor = TRUE) {
  require(lubridate)
  calc.age = lubridate::interval(dob, age.day) / lubridate::duration(num = 1, units = units)
  if (floor) return(as.integer(floor(calc.age)))
  return(calc.age)
}

# Reserva ....................
Reserva = function(producto,t,l,tabla,Cuantia,Edad,Duracion,Tipo_interes,Diferido){
  
  PNivel = l$prima_nivelada
  reserva = switch (producto,
    '1_fallecimiento' = {
      Cuantia*Axn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, m=Diferido, k=1) - 
      PNivel*axn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, m=Diferido, payment = "immediate", k=1)
      },
    '1_supervivencia' = {
      Cuantia*Exn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes) - 
        PNivel*axn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, m=Diferido, payment = "immediate", k=1)
    },
    '1_mixto' = {
      Cuantia*AExn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, k=1) - 
        PNivel*axn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, m=Diferido, payment = "immediate", k=1)
    },
    '1_diferido' = {
      Cuantia*Axn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, m=Diferido, k=1) - 
        PNivel*axn(tabla, x=Edad+t, n=Duracion-t, i=Tipo_interes, m=Diferido, payment = "immediate", k=1)
    }
    
  )
  return(reserva)
} 

