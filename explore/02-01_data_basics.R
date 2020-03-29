data()

library("dplyr")
data(package = "dplyr")

library("readxl")
library("knitr")
library("tidyverse")
df1 <- read_excel(path = "data-raw/DSR-table1.xlsx", sheet = "DSR-table1")
glimpse(df1)

kable(df1)
class(df1)


df2 <- read_csv(file = "data-raw/scanvote.csv")
head(df2, n = 5L)
class(df2)

library("utils")
url <- "http://www.prdh.umontreal.ca/BDLC/data/alb/Population.txt"

df3  <- read.table(url,   
                   skip = 2, 
                   header = TRUE, 
                   stringsAsFactors = FALSE)

df3 <- as_tibble(df3)

glimpse(df3)

write_csv(df3, path = "data-raw/alberta-mortality.csv")

#Data scraping
url <- "https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv"
df4 <- read_csv(url)
glimpse(df4)
write_csv(df4,path = "data-raw/spi-matches.csv")
#It works! Confirmed I am a genius. Data looks tidy to me

df5 <- read_excel("data-raw/nsn-extract-5-9-18.xlsx", sheet = "PTA 5-9-18")
glimpse(df5)
write_csv(df5, path = "data-raw/nsn-extract-5-9-18.csv")
# 10989 obervations, 7 variables. NSN is a numerical-ish ID number. rep_office is nominal categorical. commmon_name is nominal categorical. +
# description is a nominal categorical variable? Price is continuous quantative. UI nominal categorical, 38 levels. AAC is nominal categorical with 2 levels.
# Data looks tidy