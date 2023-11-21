library(tidyverse)

# this tests the functions below n times with random input and report the result as a frequency table
testMyFunction = function(f, n, min = -3, max = 3) {
  sapply(1:n, \(i) {
    f(sample(min:max, 1), sample(min:max, 1)) %>% 
      round(2)
  }) %>% 
    table(useNA = "always") %>%
    data.frame %>% 
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
  
  if(result == Inf || result == -Inf) browser()
  
  return(result)
}

testMyFunction(myDivide4, 1000)






#Replace with fix
myDivideFinal = function(a, b) {
  result = a / b
  
  if(is.nan(result) || result == Inf || result == -Inf) return(NA)
  
  return(result)
}

testMyFunction(myDivideFinal, 1000)








# case study
iris %>% 
  mutate(ratio = apply(., 1, \(r) {
    browser()
    if(r["Species"] == "setosa") {
      r["Petal.Length"] / r["Petal.Width"]
    } else {
      r["Sepal.Length"] / r["Sepal.Width"]
    }
  }))






