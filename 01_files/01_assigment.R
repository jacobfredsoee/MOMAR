### Create a vector from 1 to n ###
n = 10000


### Algorithm 1 ###
### While and combine ###
result = vector()
i = 1
while(i <= n) {
  result = c(result, i)
  i = i + 1
}


### Algorithm 2 ###
### Repeat and combine ###
result = vector()
i = 1
repeat {
  result = c(result, i)
  i = i + 1
  if(length(result) >= n) break
}


### Algorithm 3 ###
### sapply ###
result = sapply(1:n, function(x) {
  return(x) 
})


### Algorithm 4 ###
### Preallocate and loop ###
result = numeric(length = n)
for(i in 1:n) {
  result[i] = i
}


### Algorithm 5 ###
### Built-in function ###
result = 1:n



### Bonus algorithm ###
### Recursive ###
buildVector = function(n) {
  if (n == 1) {
    return(1)
  } else {
    previous_vector = buildVector(n - 1)
    return(c(previous_vector, n))
  }
}
result = buildVector(n)
