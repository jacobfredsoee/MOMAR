library(tidyverse)


# Write a function that takes height (cm) and weight (kg) as input and calcualtes BMI
calculateBMI = function(height, weight) {
  # Your code here
}

#Test, expected output: 23.29123
calculateBMI(183, 78)




# Write a function that takes a vector as input and returns a logical vector if a value is duplicated
findDuplicates = function(v) {
  # Your code here
}

#Test, expected output: TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE
findDuplicates(c(1,2,3,4,5,6,7,1,5,9))




# Write a function that takes a string as input and returns the string reversed
reverseString = function(s) {
  # Your code here
}

#Test, expected output: "god yzal eht revo spmuj xof nworb kciuq eht"
reverseString("the quick brown fox jumps over the lazy dog")



# Write a function that generates the Fibonacci sequence up to a given number n.
fibonacci = function(n) {
  # Your code here
}

#Test, expected output: 0   1   1   2   3   5   8  13  21  34  55  89 144 233 377
fibonacci(15)