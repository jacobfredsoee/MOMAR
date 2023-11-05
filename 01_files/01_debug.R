library(tidyverse)

testMyFunction = function(f, n) {
  sapply(1:n, \(i) {
    f(sample(0:5, 1), sample(0:5, 1))
  }) %>% 
    table(useNA = "always") %>% 
    return
}


myDivide = function(a, b) {
  result = a / b
  
  return(result)
}

# Sometimes we get Inf and NaN and want to know where it comes from
testMyFunction(myDivide, 1000)

#Enable debug
debug(myDivide)
testMyFunction(myDivide, 1000)

#disable debug
undebug(myDivide)



#Debug when condition is met
myDivide2 = function(a, b) {
  result = a / b
  
  if(is.nan(result)) browser()
  
  return(result)
}

testMyFunction(myDivide2, 1000)


#Replace with fix
myDivide3 = function(a, b) {
  result = a / b
  
  if(is.nan(result)) return(NA)
  
  return(result)
}

testMyFunction(myDivide3, 1000)



#Replace with fix
myDivide4 = function(a, b) {
  result = a / b
  
  if(is.nan(result)) return(NA)
  
  if(result == Inf) browser()
  
  return(result)
}

testMyFunction(myDivide4, 1000)



#Replace with fix
myDivideFinal = function(a, b) {
  result = a / b
  
  if(is.nan(result) || result == Inf) return(NA)
  
  return(result)
}

testMyFunction(myDivideFinal, 1000)
