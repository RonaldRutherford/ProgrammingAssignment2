## Created by Ronald Rutherford
## on 4/22/2014
## These functions are to save time when the code may need to calculate the inverse of particular matrix repeated times.
## 

## Write a short comment describing this function:
# The first function, makeCacheMatrix creates a special "inverse matrix", which is really a list containing a function to
# set the value of the input matrix
# get the value of the matrix
# set the value of the inverse of input matrix
# return the inverse of the input matrix

makeCacheMatrix <- function(x = matrix()) {
    Im <- NULL
    set <- function(y) {
        x <<- y
        Im <<- {}
    }
    get <- function() x
    setI <- function(It) Im <<- It
    getI <- function() Im
    list(set = set, get = get,
         setI = setI,
         getI = getI)
}


## Write a short comment describing this function
# The following function calculates the inverse of the special "matrix" created with the above function. 
# However, it first checks to see if the inverse has already been calculated. 
# If so, it gets the inverse from the cache and skips the computation. Otherwise, 
# it calculates the inverse of the data and sets the value of the inverse in the cache via the setmean function.
# Note: on large matrixes, these calculations are not trivial and could slow down production code 
# and for user interfaces this delay could diminish the satisfaction of customers.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    Im <- x$getI()
    if(!is.null(Im)) {
        message("getting cached data")
        return(Im)
    }
    data <- x$get()
    Im <- solve(data)
    x$setI(Im)
    Im
}

# Unit Test: 
# set.seed(1)
# xM <- matrix(sample(1:49),nrow=7,ncol=7)
# MadeM <- makeCacheMatrix(xM)
# cacheSolve(MadeM)
# [,1]         [,2]        [,3]        [,4]         [,5]        [,6]        [,7]
# [1,] -0.012594821  0.008326545 -0.01354867  0.03702914 -0.024670725  0.01744989 -0.01498167
# [2,] -0.011187259 -0.017982582 -0.01371820 -0.02322343  0.017624660  0.01335580  0.02720987
# [3,]  0.014531258 -0.017457632  0.04074969 -0.02434018  0.009164102 -0.03120884  0.02901362
# [4,] -0.010150334 -0.004707498  0.01164482 -0.01249872  0.021672585 -0.01430766  0.01934040
# [5,] -0.019428435  0.000297291  0.06790999 -0.05315172  0.014892879 -0.01859500  0.03073953
# [6,] -0.008420845  0.040700998  0.04866060 -0.02380906 -0.041428762 -0.03132303  0.01801529
# [7,]  0.041572990  0.011038968 -0.10951399  0.08413828 -0.003582628  0.05722027 -0.08806434



