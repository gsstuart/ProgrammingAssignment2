## makeCacheMatrix()
##
## Receives as an argument a matrix x, and creates an "object" that can be used to retrieve and modify
## this matrix, as well as to retrieve and modify the matrix's inverse (also known as the "solve").
## This function is designed to be used in conjunction with the cacheSolve() function, which provides
## capabilities for both generating and caching the matrix inverse.
##
## The return value of this function is a list of four functions, that can be used to get and set the
## matrix itself, as well as its inverse.
##
makeCacheMatrix <- function(x = matrix()) {
  # initialize xSolve, which will hold the inverse matrix once computed
  xSolve <- NULL
  
  # define set() function to set the contents of the matrix
  setMatrix <- function(xSet) {
    x <<- xSet      # set the matrix contents (in the parent environment)
    xSolve <<- NULL  # initialize xSolve, since new contents invalidate any previous caching
  }
  
  # define get() function to return the contents of the matrix 
  getMatrix <- function() x
  
  # define setSolve function to cache a solve for this matrix
  setSolve <- function(s) xSolve <<- s
  
  # define getSolve function to retrieve the cached solve
  getSolve <- function() xSolve
    
  # return the above-defined getter and setter functions
  c(set = setMatrix, get = getMatrix, setSolve = setSolve, getSolve = getSolve)
}

## cacheSolve()
## 
## Receives as an argument a matrix created with makeCacheMatrix(), and
## returns the inverse of that matrix.  In doing so this function utilizes
## the caching capabilities of makeCacheMatrix().  If the matrix already
## has a cached inverse, it simply returns that cached inverse and does not
## re-compute the inverse.  Otherwise, the inverse is calculated and stored in
## the cache to streamline future retrieval.
##
cacheSolve <- function(x) {
  # attempt to retrieve the cached inverse of the matrix
  s <- x$getSolve()
  # if the cached inverse exists, return it.
  if (!is.null(s)) {
    message("cache hit!")
    return(s)
  }
  # if we're here, then the getSolve() call returned NULL, which means
  # that there's no inverse stored in the cache.  therefore, we will
  # compute the inverse and cache it.
  message("cache miss! computing solve...")
  s <- solve(x$get())
  x$setSolve(s)
  return(s)
}

# define an invertible 5x5 matrix, for testing purposes
testMatrix <- matrix(c(2,9,3,6,4,7,7,3,5,3,2,10,7,8,9,6,6,6,10,6,2,9,2,2,4), nrow=5, ncol=5)
