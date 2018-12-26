# Mac OS X 10.13.6 (High Sierra); RStudio as part of Anaconda 1.9.6

        # Creating New variables

        library(data.table) 
        ## download and read data set
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
        download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
        restData <- read.csv("./data/restaurants.csv")

        # Creating sequences (they are often used to index different operations) 
        s1 <- seq(1,10, by=2)     # sequence from minimum value=1, to max value=10, stepsize=2
        s1
        s2 <- seq(1,10, length=3) # sequence by sepcifying length of the vector
        s2
        x <- c(1, 3, 8, 25, 100)  # given sequence, if we want position of the numbers in the vector then:/
        seq(along = x)            # can generate consequtive numbers helping to look over or access data set
        
        # Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)  # can see from where variables come from; will see that 13 restaurants come from these
                        # neighborhoods, and rest of 1314 from the list are coming from elsewhere

        # Creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE) # condition for which we are looking (<0)
table(restData$zipWrong, restData$zipCode < 0)                # tells if zipcode is wrong ot not

        # Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)  # break zipcodes; condition to break is according to quantile

table(restData$zipGroups, restData$zipCode) #see more details, which values are falling in specific

        # Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)  # break zipcodes in 4 groups according to quantiles

        # Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]   # turn integer variable of zipcode into factor values (asked for 10 zip codes)
class(restData$zcf)  # check the class to be sure that is factor variable

        # Level of factor variables
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE) # create a vector of Yes and No
yesnofac = factor(yesno, levels = c("yes", "no"))          # turn into factor, and treat the lowest value 
                                                           # alphabetically as the first value
relevel(yesnofac, ref = "yes")
as.numeric(yesnofac)

        # Cutting producing factor variables
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

        # Use the mutate function to create new version of variables, and automatically added to the dataset
library(Hmisc); library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData$zipGroups)

        # Common Transformations
abs(x)                 # absolut value
sqrt(x)                # square root
ceiling(x)             # ceiling (3.475) is 4
floor(x)               # floor (3.475) is 3
round(x, digits = 2)   # round(3.475, digits=2) is 3.48
signif(x, digits = 2)  # signif(3.475, digits=2) is 3.5
log2(x); log10(x)      # common logs
exp(x); cos(x); sin(x) # common functions
