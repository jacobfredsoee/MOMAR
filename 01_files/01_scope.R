####### PART 1 #######


#### What do you expect is returned by these functions?

x = 10

#Function 1
sapply(1:10, function(n) {
  return(n + x)
})

#Function 2
sapply(1:10, function(n) {
  x = 20
  return(n + x)
})

#Function 3
sapply(1:10, function(n) {
  x = 20
  x = n + x
  return(x)
})

#Function 4
sapply(1:10, function(n) {
  x <<- n + x
  return(x)
})

#Function 5
sapply(1:10, function(n) {
  x <<- n + x
  x = n
  return(x)
})


#Function 6
x = 10
a = 1
myUselessFunction = function(a) {
  return(a + x)
  a = 2
}
sapply(1:10, function(n) {
  a = 3
  x = 5
  return(myUselessFunction(a = n))
})







####### PART 2 #######


c(1, 2)

c = function(a, b) {
  a + b
}

c(1, 2)

c = function(a, b, ...) {
  return(list(a + b, ...))
}
c(1, 2, 42, 6, 71)

c = function(a, b, ...) {
  return(list(a + b, ..., x))
}
c(1,2)
c(1, 2, 42, 6, 71)



myFunction3(1,2)
