## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  # initialize xSolve, which will hold the inverted matrix
  xSolve <- NULL
  
  # define set() function to set the contents of the matrix
  setMatrix <- function(xSet) {
    x <<- xSet      # set the matrix contents (in the parent environment)
    xSolve <- NULL  # initialize xSolve, since new contents invalidate any previous caching
  }
  
  # define get() function to return the contents of the matrix 
  getMatrix <- function() x
  
  # define setSolve function to cache a solve for this matrix
  setSolve <- function(s) xSolve <<- s
  
  # define getSolve function to retrieve the cached solve
  getSolve <- function() xSolve
  
  # return the getter and setter functions
  c(set = setMatrix, get = getMatrix, setSolve = setSolve, getSolve = getSolve)
}


## Write a short comment describing this function

cacheSolve <- function(matrix, ...) {
        ## Return a matrix that is the inverse of 'x'
  s <- matrix$getSolve()
  if (!is.null(x)) {
    message("cache hit")
    return(s)
  }
  s <- solve(matrix$getMatrix())
  matrix$setSolve(s)
  return(s)
}

# define an invertible 5x5 matrix, for testing purposes
testMatrix <- matrix(c(2,9,3,6,4,7,7,3,5,3,2,10,7,8,9,6,6,6,10,6,2,9,2,2,4), nrow=5, ncol=5)






#makeVector <- function(x = numeric()) {
#  m <- NULL
#  set <- function(y) {
#    x <<- y
#    m <<- NULL
#  }
#  get <- function() x
#  setmean <- function(mean) m <<- mean
#  getmean <- function() m
#  list(set = set, get = get,
#       setmean = setmean,
#       getmean = getmean)
#}

#cachemean <- function(x, ...) {
#  m <- x$getmean()
#  if(!is.null(m)) {
#    message("getting cached data")
#    return(m)
#  }
#  data <- x$get()
#  m <- mean(data, ...)
#  x$setmean(m)
#  m
#}

