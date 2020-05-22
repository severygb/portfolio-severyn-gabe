library(tidyverse)
library(graphclassmate)
library(magrittr) # I love the compound assignment pipe
library(magick)

#plot by year
year_deaths <- readRDS(file = "data/D4-motorsports-deaths-yearly.rds")

#create basic line chart
p <- ggplot(year_deaths, aes(x = year, y = n)) +
  geom_line() +
  scale_x_date(date_breaks = "10 years", date_labels = "%Y") +
  theme_graphclass() +
  labs(x = "", caption = "Source: Motorsport Memorial", y = "Individual fatalities per year")
  
p %<>% +  #lots of theme changes to make
  theme(
    panel.background = element_rect(fill = "transparent"), # bg of the panel
    plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
    panel.grid.major.x = element_blank(), #get rid of these
    axis.title = element_text(size = 12), #overrides a setting, probably in graphclassmate
    axis.text = element_text(size = 12), #overrides a setting, probably in graphclassmate
    plot.caption = element_text(size = 12), #overrides a setting, probably in graphclassmate
  )

# Add safety advancement annotations -----------------------------------------------------------------------

# WWII, 1941-1945
p %<>% + annotate("rect", xmin = as.Date("1939-12-07"), xmax = as.Date("1945-09-07"), ymin = 0, ymax = 12, 
                  alpha = 0.2, fill = "#8dd3c7")

# seat belts / harnesses, 1957-1963
p %<>% + annotate("rect", xmin = as.Date("1957-01-01"), xmax = as.Date("1963-12-31"), ymin = 0, ymax = 14, 
                  alpha = 0.2, fill = "#80b1d3")

# roll-over hoops mandated at Indy 500 1959
p %<>% + annotate("rect", xmin = as.Date("1959-01-01"), xmax = as.Date("1959-12-31"), ymin = 0, ymax = 16, 
                  alpha = 0.2, fill = "#bebada")                  

# nomex fire suits 1964
p %<>% + annotate("rect", xmin = as.Date("1964-01-01"), xmax = as.Date("1964-12-31"), ymin = 0, ymax = 18, 
                  alpha = 0.2, fill = "#fb8072")

# Carbon fiber monocoque in 1981 by McLaren 
p %<>% + annotate("rect", xmin = as.Date("1981-01-01"), xmax = as.Date("1981-12-31"), ymin = 0, ymax = 53, 
                  alpha = 0.2, fill = "#80b1d3")

# HANS devices widely mandated. 2000-2003
p %<>% + annotate("rect", xmin = as.Date("2000-01-01"), xmax = as.Date("2003-12-31"), ymin = 0, ymax = 65, 
                  alpha = 0.2, fill = "#fdb462")

# SAFER barriers a.k.a. 'soft' walls, 2002
p %<>% + annotate("rect", xmin = as.Date("2002-01-01"), xmax = as.Date("2002-12-31"), ymin = 0, ymax = 67, 
                  alpha = 0.2, fill = "#fb8072")

text_callouts <- wrapr::build_frame(
  "year",                "n",    "label" |
    as.Date("1939-12-07"), y = 8, label= "WWII" |
    as.Date("1957-01-01"), y = 3, label = "Seat belt usage increases" |
    as.Date("1959-01-01"), y = 8, label = "Roll-hoops mandated at Indy 500" |
    as.Date("1964-01-01"), y = 12, label = "Fire-proof suits created" |
    as.Date("1981-01-01"), y = 50, label = "McLaren invents carbon fibre monocoque" |
    as.Date("2000-01-01"), y = 55, label = "HANS devices mandated" |
    as.Date("2002-01-01"), y = 60, label = "'Soft walls' invented"
)

p %<>% + geom_text(data = text_callouts, aes(x = year, y = n, label = label), hjust = 0.0, size = 4.5)


ggsave(filename = "D4-motorsports-fatalities.png",
       path    = "resources",
       width   = 11,
       height  = 5.5,
       units   = "in",
       dpi     = 300, 
       bg = "transparent")


## image editing section --------------------------------------------------

image_file <- "resources/serious-racer.png"
image_url  <- "https://c1.peakpx.com/wallpaper/412/5/307/gray-scale-image-on-man-wearing-full-face-helmet-wallpaper-preview.jpg"

if (!file.exists(image_file)) {
  racer <- image_read(image_url)
  image_write(racer, path = image_file, format = "png")
}
#made custom modifications with an image editor because R couldn't do what I wanted to do...
#added a gradient fade to white to blend the image and plot
racer <- image_read("resources/serious-racer-bg.png")
graph <- image_read("resources/D4-motorsports-fatalities.png")

#soften the image a bit
#racer <- image_colorize(racer, opacity = 25, color = "white") #just kidding, don't like it

# scale to match 
racer <- image_scale(racer, "970x")
graph <- image_scale(graph, "970x")

#layer graph on to the image
final_img <- image_composite(racer, graph, gravity = "South")

final_img

#add a title portion in the big white area of helmet
width  <- image_info(final_img)[["width"]]
title_text <- image_blank(width = width, height = 100, color = "transparent")
title_text <- image_annotate(title_text, 
                           text     = "Racing fatalities in the U.S.", 
                           gravity  = "west", 
                           location = "+160+0", 
                           size     = 24, 
                           color    = "black", 
                           font     = "Georgia")
final_img <- image_composite(final_img, title_text, gravity = "NorthWest")

subtitle_text <- image_blank(width = width, height = 100, color = "transparent")
subtitle_text <- image_annotate(subtitle_text, 
                                text     = "   Individuals killed in car and truck motorsports", 
                                gravity  = "west", 
                                size     = 18, 
                                color    = "black", 
                                font     = "Georgia")
final_img <- image_composite(final_img, subtitle_text, offset = "+80+40")

final_img

finished_path <- "figures/D6-complete.png"
image_write(final_img, path = finished_path, format = "png")


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
