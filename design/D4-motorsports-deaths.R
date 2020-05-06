library(tidyverse)
library(graphclassmate)

#plot by year
year_deaths <- readRDS(file = "data/D4-motorsports-deaths-yearly.rds")

ggplot(year_deaths, aes(x = year, y = n)) +
  geom_line() +
  scale_x_date(date_breaks = "10 years", date_labels = "%Y") +
  theme_graphclass() +
  labs(x = "", title = "Fatalities from car and truck motorsports in the US", 
       caption = "Source: Motorsport Memorial", y = "Individuals")

#fail at bar chart pictogram ---------------
# icon_address  <- "https://cdn2.iconfinder.com/data/icons/people-80/96/Picture1-512.png"
# icon_file <- "resources/person.png"
# 
# if (!file.exists(icon_file)) {
#   download.file(icon_address, icon_file, mode = 'wb')
# }
# 
# # in case you don't alredy have RCurl
# # install.packages("RCurl", dependencies = TRUE)
# source_github <- function(u) {
#   # load package
#   require(RCurl)
#   
#   # read script lines from website and evaluate
#   script <- getURL(u, ssl.verifypeer = FALSE)
#   eval(parse(text = script),envir=.GlobalEnv)
# }
# 
# 
# source_github("https://raw.githubusercontent.com/robertgrant/pictogram/master/pictogram.R")
# 
# num_deaths <- as.integer(year_deaths$n)
# year_labels <- as.character(lubridate::year(year_deaths$year))
# 
# #install.packages("png", dependencies = TRUE)
# require(png)
# 
# #img <- readPNG(system.file("img", icon_file), native = F)
# img <- readPNG(system.file("img", "Rlogo.png", package="png"))
# 
# pictogram(icon = img, n = c(12,3,7),
#           grouplabels= c("12","3","7"))
# 
# pictogram(icon = img, n = num_deaths, grouplabels= year_labels)
