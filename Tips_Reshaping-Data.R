# Mac OS X 10.13.6 (High Sierra); RStudio as part of Anaconda 1.9.6

# Reshaping Data 
        ## Goal is to obtain tidy data; in many cases we need to Reshape data such that 
        ## principles of tidy data to be respected: (1) each variable forms a column;
        ## (2) each observation forms a row; (3) each table/file stores data about one kind of Obs, etc.

library(reshape2)
head(mtcars) # mtcars is a standard data set in R
        
        # Melt the data set: tell which are "id variables", and which are "measure variables"
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3) # printing "head" and "tail" we can see that data were reshaped how we asked

        # Casting data frames
cylData <- dcast(carMelt, cyl ~ variable) # re-format data set in a different sort of shapes
cylData   # we re-cast data into a particula data set, a particular data frame
          # we see that "cyl" was broken down by mpg and hp variables

cylData <- dcast(carMelt, cyl ~ variable, mean) # re-format data set: "cyl" - row; var - column; compute mean
cylData

        # Averaging values
head(InsectSprays) # InsectSprays is a standard data set in R
tapply(InsectSprays$count, InsectSprays$spray, sum) # count spray A, B, C, ... and do the sum

        # Another way - Split
spIns = split(InsectSprays$count, InsectSprays$spray) # take insect spray count and split on each category of spray
spIns  # we get a list value for each type of spary A, B, C, ...

sprCount = lapply(spIns, sum) # apply a function "sum" to above list
sprCount
unlist(sprCount)              # if we want to go back to the vector format
sapply(spIns, sum)            # doing the same things as did unlist(sprCount)

        #Another way - plyr package doing many things in ONE step
library(plyr)
ddply(InsectSprays, .(spray), summarize, sum = sum(count)) # gives exactly what we got above using "split"
        # here we can create a new variable
spraySums <- ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN = sum))
dim(spraySums)
head(spraySums)

