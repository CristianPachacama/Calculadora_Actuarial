# Funciones Extras

# Edad  ......................
age = function(dob, age.day = today(), units = "years", floor = TRUE) {
  require(lubridate)
  calc.age = interval(dob, age.day) / duration(num = 1, units = units)
  if (floor) return(as.integer(floor(calc.age)))
  return(calc.age)
}