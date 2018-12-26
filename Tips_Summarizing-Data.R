# Mac OS X 10.13.6 (High Sierra); RStudio as part of Anaconda 1.9.6
    
        # Getting the data from the web
        library(data.table) 
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
        download.file(fileUrl, destfile = "./data/restaurants.csv", method = "curl")
        restData <- read.csv("./data/restaurants.csv")

        # Analyse data set
        head(restData, n=3) # view the first three rows; by default it returns 6 rows
        tail(restData, n=3) # view the last three rows; by default it returns 6 rows
        summary(restData)   # summarry
        str(restData)       # more in details, e.g, type of data.frame, classes....
        
        # Quantiles for quantitative variables
        quantile(restData$councilDistrict, na.rm = TRUE) 
                 # to have idea about how data are distributed
        quantile(restData$councilDistrict, probs = c(0.5, 0.7, 0.9)) # look to the different probabilties

        # Make table
table(restData$zipCode, useNA="ifany")  # use "NA" if any missing value exist; by default, table function in R 
                                        # does not tell the number of missing values (NA)
table(restData$councilDistrict, restData$zipCode) # 2 dimensional table, good for qualitative variables

        # Check missing values
sum(is.na(restData$councilDistrict))  # tells how many NA (sum) are in the column "councilDistrict"
any(is.na(restData$councilDistrict))  # tells if it exisst NA in the column "councilDistrict"
all(restData$zipCode > 0)             # tells all zipcodes which are positive

        # Row and column sums
colSums(is.na(restData))           # sum of NA values (per columns) from the entire data set
all(colSums(is.na(restData)) == 0) # verifyies if the sum of all NA is zero (TRUE <=> no NA)

        # Find values with specific characteristics
table(restData$zipCode %in% c("21212"))              # find if it exists zipcode 21212
table(restData$zipCode %in% c("21212", "21213"))     # find if it exists zipcode 21212 or 21213
restData[restData$zipCode %in% c("21212", "21213"),] # subset of data set: restaurants having one of these zip codes
                        
        # Cross table or summary of our data
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF) # cross tabs, where a ceratin relationship exist between the data
xt   # print Freq of data based on the gender (male/female), admited or rejected

        # Flat tables
warpbreaks$replicate <- rep(1:9, len = 54) # preferred when we have large number of var which are hard to see
xt = xtabs(breaks ~., data = warpbreaks)     # warpbreaks is another standard data set in R (54 obs, 3 var)
xt    # many small tables with value of "breaks", which are broken down with other variables (tension and wool)
ftable(xt)  # summarize above generated "small tables"' data are more compact, easy to see

        # Size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")