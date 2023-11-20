# Rewrite the BMI function to handle if height is some times in meters
calculateBMI = function(height, weight) {
  # Your code here
}

#Test, expected output: 23.29123, 23.29123
calculateBMI(183, 78); calculateBMI(1.83, 78)



# Write a function that takes a vector as input, skips all even numbers and returns the sum of the odd numbers
sumOfOdds = function(numbers) {
  # Your code here
}

#Test, expected output: 16
sumOfOdds(c(1,2,3,4,5,6,7,8))




# Write a function that takes a number as input, and returns "Positive" if above 0, "Negative" if below 0 and "Zero" if input is 0
classifyNumber = function(x) {
  # Your code here
}

#Test, expected output: "Negative", "Zero", "Positive"
classifyNumber(-8); classifyNumber(0); classifyNumber(42);



#Rewrite your fibonacci function so that it stops if given a negative numbers and can handle n < 3
fibonacci = function(n) {
  # Your code here
}

#Test, expected output: 0   1   1   2   3   5   8  13  21  34  55  89 144 233 377
fibonacci(15)

#Test, expected output: Error in fibonacci(-5) : n has to be >0
fibonacci(-5)

#Test, expected output: 0; 0 1
fibonacci(1); fibonacci(2)

