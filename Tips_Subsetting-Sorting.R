# Mac OS X 10.13.6 (High Sierra); RStudio as part of Anaconda 1.9.6

      # Subsetting
                ## Create data to be used in this file 
        library(data.table)   
        set.seed(13435)
        X <- data.frame("var1" = sample(1:5),    # sampling to obtain random 1:5 
                        "var2" = sample(6:10),   # sampling to obtain random 6:10 
                        "var3" = sample(11:15))  # sampling to obtain random 11:15 
        X <-X[sample(1:5),]; X$var2[c(1,3)] = NA 
        X
        
                ## Subsetting a column
        X[, 1]         # open the first column of the data frame
        X[,"var1"]     # can subset a column by using name of that column
        X[1:2, "var2"] # subset the first 2 rows, and column "var2"
        
                 ## Subsetting using logical statements &, | (AND, OR)
        X[(X$var1<=3 & X$var3 >11),] # open all rows for which var1<=3 AND var3>11
        X[(X$var1<=3 | X$var3 >15),] # open all rows for which var1<=3 OR var3>15
        
                ## Subsetting with missing values, using "which"
        X[which(X$var2 > 8),] # produce all rows for which var2>8; in this way we skip over NA values
        
        # Sorting
        sort(X$var1)                    # sort values of var1 (in increasing order by default)
        sort(X$var1, decreasing = TRUE) # sort values of var1 in decreasing order
        sort(X$var2, na.last = TRUE)    # if we want to sort NA at the end of values of var2
        
        # Ordering
        X[order(X$var1),]         # order all rows by taking values of var1 in increasing order
        X[order(X$var1, X$var3),] # order by multiple variables (e.g., var 1 and var3; var1-first in ordering)
        
        # Ordering with plyr
        library(plyr)          # ordering using plyr package
        arrange(X, var1)       # sort data frame X after the var1 (increasing values by default)
        arrange(X, desc(var1)) # same as above if we want descendent order (decreasing)
        
        # Adding rows and colums
        X$var4 <- rnorm(5) # add a new variable "var4" with random normal vector of length/
        X$var4             # as same dimension as the number of rows of data set; print new X$var4
        
        Y <- cbind(X, rnorm(5)) # column binding (cbind) with a vector in the right side of X
        Y  # print Y after right-binding
        
        Y <- cbind(rnorm(5), X) # column binding (cbind) with a vector in the left side of X
        Y  # print Y after left-binding
        
        Z <- rbind(X, rnorm(5)) # rows binding at the tail/bottom of data frame
        Z  # print Z after bottom-binding
        
        Z <- rbind(rnorm(5), X) # rows binding at the top of the data frame
        Z  # print Z after top-binding
        