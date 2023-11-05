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
#### What do you expect is returned by these function calls?

x = 10

#Function call 1
c(1, x)
# -------------- #



c = function(a, b) {
  a + b
}

#Function call 2
c(1, x)
# -------------- #


c = function(a, b, ...) {
  return(list(a + b, ...))
}

#Function call 3
c(1, 2, 42, 6, 71)
# -------------- #


c = function(a, b, ...) {
  return(list(a + b, base::c(...), x))
}

#Function call 4
c(1, x)
# -------------- #

#Function call 5
c(1, 2, 42, 6, 71, x)
# -------------- #


#You can also overview package functions
ggplot2::theme_classic #Get the code of the default function
#Modify the function, large base_size and another base_family
theme_classic = function(base_size = 18, base_family = "mono", base_line_size = base_size/22, 
                       base_rect_size = base_size/22) {
  theme_bw(base_size = base_size, base_family = base_family, 
           base_line_size = base_line_size, base_rect_size = base_rect_size) %+replace% 
    theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black", 
                                                                       linewidth = rel(1)), legend.key = element_blank(), 
          strip.background = element_rect(fill = "white", colour = "black", 
                                          linewidth = rel(2)), complete = TRUE)
}

iris %>% 
  ggplot(aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  theme_classic()

#How can I get the default ggplot2 version back? (there are two ways)
