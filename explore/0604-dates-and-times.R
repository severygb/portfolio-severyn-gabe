#script functions as a cheat sheet for date and time class representations in R
library("tidyverse")
library("lubridate")

#start w/ character vector
x <- c("2019-03-01", "2019-06-01", "2019-09-01", "2019-12-01")
typeof(x)

#class: Date ---------------------------------------------------------
x_date <- ymd(x)
attributes(x_date)
#there are functions for most date formatting styles (mdy, dmy, etc.)
#Date class is internally stored as the integer number of days since 1970-01-01

# make date from character parts
yyyy <- "2017" 
mm   <- "1"
dd   <- "31" 
(z <- make_date(year = yyyy, month = mm, day = dd))
class(z)

# make date from numeric parts
yyyy <- 2017 
mm   <- 1
dd   <- 31 
(z <- make_date(year = yyyy, month = mm, day = dd))
class(z)


#class: POSIXct ---------------------------------------------------------

#POSIXct stores dates and times as the integer number of seconds since 1970-01-01 00:00:00 GMT
x_date <- as.POSIXct("2019-04-17 11:24:09 EDT")
attributes(x_date)

x_date #prints nicely though

#make POSIXct from character vector in mdyhm form
(x <- c("May 11, 1996 12:05", "September 12, 2001 1:00", "July 1, 1988 3:32"))
(x_posix <- mdy_hm(x))
#lots of similar forms available

#from POSIXct to Date
(x_date <- as_date(x_posix))
class(x_date)

#class: decimal dates ---------------------------------------------------------
#floating point numbers in yyyy.nnn form
#nnn represents the time, day, and month to the nearest 1/1000 of the year
#decimal dates can resolve to between 4-5 hours. A.K.A 4-5 hours uncertainty

#easy to create decimal dates from POSIXct
(x <- "2019-04-18 00:00 EDT")
(x_posix   <- ymd_hm(x, tz = "US/Eastern"))

#can convert from decimal date to other types
(x_decimal <- 219.294)

(x_posix <- date_decimal(x_decimal))
class(x_posix)

(x_date <- as_date(x_posix))
class(x_date)
class(x_decimal)
(x_decimal <- decimal_date(x_posix))