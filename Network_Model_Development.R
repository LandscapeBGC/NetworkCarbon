#Geoff says:
#Sounds to me like you might want to try creating an environment and making your iGraph within that environment. 
#Everything in R is passed to functions by value (value is copied, and the copy is passed).  
#Anything not specifically returned by a function disappears when the function exits.  
#So if you pass an igraph to a function, a copy is made and any changes the function make to the igraph object 
#apply to the copy  Unless you return the copy of the igraph from the function and store it in a variable, it will disappear when the function executes. 

#Environments are the exception. A pointer to the environment is passed to the function. Any changes the function makes to values in the environment 
#(e.g. an igraph object in the environment) will persist after the function has run. 

#Rob says: 
#If you ask me, R goes a little overboard on immutability. Optimizing everything to be thread safe is not useful when trying 
#to optimize performance within a thread. I agree that it sounds like an issue with finding a way to keep state, and Rs main 
#option for doing that is use of environments. If you want a way to wrap objects in environments to create semi-mutable 
#state-keepers and also add a lightweight implementation of object-oriented composition and inheritance, I would recommend 
#checking out the R6 package (one of the may implementations of OOP in R).

#I bit the bullet and figured out how to write C++ code that is accessible from R for workflow. Best of both worlds in terms 
#of computational efficiency, the kind of low level control over memory I prefer, and high level workflow management. 
#I want to implement a light weight hierarchical state machine framework that does all computations in machine language 
#compiled from C++, but can be built from R objects and input and generates R objects as output (i.e. a foundation to facilitate 
#building finite-difference approximations and NEO-like distributed mass balance). This is bubbling to the top of my priority list 
#because I have a set of metabolism models for river DIC that I would really like to be more modular. That said, there are lots of things 
#near the top of my priority list that still aren't getting done. 

#Geoff says:
#There might be an intermediate solution for what you are trying to do. I've found that using the "purrr::accumulate" or "purrr::reduce"functions 
#can be a very efficient (C++ based) replacement for a FOR loop (which I had always thought was the only solution when the results from one 
#iteration depend on the results from the prior iteration - until I discovered "accumulate"!).  Combining "accumulate" with a little tinkering 
#with lists vs. arrays, I recently used the incredibly simple "profvis" profiler (in a package by the same name) to take a finite difference 
#approximation model that ran in 17 seconds per node to 0.11 seconds per node without writing any C++ code. I'd be happy to show you (and Ashley's lab) 
#how that worked if anyone is are interested. 

#Because results from "accumulate" are saved in a list, it also provides a potential solution for the problem of immutability that Ashley is struggling with.  
#Thinking about it now, I can imagine how nesting "reduce" within "accumulate" would provide a way to save output from only selected time steps instead of 
#every time step. 

#Final bonus: my original model would increase in computational time exponentially as I increased the number of time steps (indirectly, because of your 
#point about R and over-emphasizing immutability). But the new approach has an ideal linear increase!  Surprisingly, the exponential increase was a result 
#of using arrays. I had though preallocating arrays and updating in place would be fastest.  But generating lists with purrr::accumulate and then rbind-ing 
#the lists into the desired array is just crazy-fast.
