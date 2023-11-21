library(tidyverse)


# Write a function that takes height (cm) and weight (kg) as input and calcualtes BMI
calculateBMI = function(height, weight) {
  # Your code here
  return(weight / (height/100)^2)
}

#Test, expected output: 23.29123
calculateBMI(183, 78)











# Write a function that takes a vector as input and returns a logical vector if a value is duplicated
findDuplicates = function(v) {
  # Your code here
  result = logical(length = length(v))
  
  for(i in 1:length(v)) {
    result[i] = sum(v[i] == v) > 1
  }
  
  return(result)
}

#Test, expected output: TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE
findDuplicates(c(1,2,3,4,5,6,7,1,5,9))













# Write a function that takes a string as input and returns the string reversed
reverseString = function(s) {
  # Your code here
  result = character(length = nchar(s))
  
  for(i in 1:nchar(s)) {
    result[i] = substr(s, i, i)
  }
  
  return(paste0(rev(result), collapse = ""))
}

#Test, expected output: "god yzal eht revo spmuj xof nworb kciuq eht"
reverseString("the quick brown fox jumps over the lazy dog")











# Write a function that generates the Fibonacci sequence up to a given number n.
fibonacci = function(n) {
  # Your code here
  result = integer(length = n)
  result[1] = 0
  result[2] = 1
  
  i = 3
  while(i <= n) {
    result[i] = result[i-2] + result[(i-1)]
    i = i + 1
  }
  
  return(result)
}

#Test, expected output: 0   1   1   2   3   5   8  13  21  34  55  89 144 233 377
fibonacci(15)









#-----------after introducing: next, break, stop, if, else ------------------------------------#



# Rewrite the BMI function to handle if height is some times in meters
calculateBMI = function(height, weight) {
  # Your code here
  if(height < 3) height = height * 100
  return(weight / (height/100)^2)
}

#Test, expected output: 23.29123, 23.29123
calculateBMI(183, 78); calculateBMI(1.83, 78)











# Write a function that takes a vector as input, skips all even numbers and returns the sum of the odd numbers
sumOfOdds = function(numbers) {
  # Your code here
  sum = 0
  
  for(num in numbers) {
    if(num %% 2 == 0) next
    sum = sum + num
  }
  
  return(sum)
}

#Test, expected output: 16
sumOfOdds(c(1,2,3,4,5,6,7,8))










# Write a function that takes a number as input, and returns "Positive" if above 0, "Negative" if below 0 and "Zero" if input is 0
classifyNumber = function(x) {
  if (x > 0) {
    result = "Positive"
  } else if (x < 0) {
    result = "Negative"
  } else {
    result = "Zero"
  }
  
  return(result)
}

#Test, expected output: "Negative", "Zero", "Positive"
classifyNumber(-8); classifyNumber(0); classifyNumber(42);











#Rewrite your fibonacci function so that it stops if given a negative numbers and can handle n < 3
fibonacci = function(n) {
  # Your code here
  
  if(n <= 0) stop("n has to be >0")
  
  result = integer(length = n)
  result[1] = 0
  result[2] = 1
  
  if(n == 1) return(result[1])
  if(n == 2) return(result[1:2])
  
  i = 3
  while(i <= n) {
    result[i] = result[i-2] + result[(i-1)]
    i = i + 1
  }
  
  return(result)
}

#Test, expected output: 0   1   1   2   3   5   8  13  21  34  55  89 144 233 377
fibonacci(15)

#Test, expected output: Error in fibonacci(-5) : n has to be >0
fibonacci(-5)

#Test, expected output: 0; 0 1
fibonacci(1); fibonacci(2)



