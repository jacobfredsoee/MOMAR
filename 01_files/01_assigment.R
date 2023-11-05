### Create a vector from 1 to n ###
### Rank algorithms according to speed ###
n = 10000


### Algorithm 1 ###
### While and combine ###
result = vector()
i = 1
while(i <= n) { #While i is smaller or equal to  n, do whatever is between the { }
  result = c(result, i)
  i = i + 1
}


### Algorithm 2 ###
### Built-in function ###
result = 1:n


### Algorithm 3 ###
### Repeat and append ###
result = vector()
i = 1
repeat { #Do whatever is between the { } until I tell you to stop (break)
  result = append(result, i)
  i = i + 1
  if(length(result) >= n) break
}


### Algorithm 4 ###
### Preallocate and loop ###
result = numeric(length = n)
for(i in 1:n) { #for each number between 1 and n, call the number i and do whatever is between the { }
  result[i] = i
}


### Algorithm 5 ###
### sapply ###
result = sapply(1:n, function(x) { #for each number between 1 and n, call the anonymous function and call the number x
  return(x) 
})



### Bonus algorithm ###
### Recursive ###
buildVector = function(n) { #bonus point for understanding what this does
  if (n == 1) {
    return(1)
  } else {
    previous_vector = buildVector(n - 1)
    return(c(previous_vector, n))
  }
}
result = buildVector(n)
