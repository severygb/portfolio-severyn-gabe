# Gabe Severyn
# 5/11/2020

# load packages
library("tidyverse")

soil <- read.table("http://homepage.divms.uiowa.edu/~luke/data/soil.dat")
glimpse(soil)

#coplot is a base R function
coplot(resistivity ~ northing | easting, 
       data = soil)

#use panel function to add a smooth fit and edit the aesthetics
my_panel <- function(x, y, ...) {
  panel.smooth(x, y, 
               span = 0.6, 
               iter = 5, 
               lwd  = 1,
               col.smooth = rcb("dark_BG"), 
               ...)
}
coplot(resistivity ~ northing | easting, 
       data = soil, 
       pch  = 21, 
       col  = rcb("mid_BG"), 
       bg   = rcb("pale_BG"), 
       bar.bg = c(num = rcb("pale_BG"), fac = rcb("pale_BG")), 
       panel = my_panel)


#using 4 variables, even better!
data(airquality)

airquality <- as_tibble(airquality) %>% 
  drop_na() %>% 
  glimpse()

coplot(log(Ozone, base = 2) ~ Solar.R | Temp * Wind, 
       data = airquality, 
       pch  = 21, 
       col  = rcb("dark_BG"), 
       bg   = rcb("mid_BG"), 
       bar.bg = c(num = rcb("pale_BG"), fac = rcb("pale_BG")), 
       number = 4, 
       overlap = 0.5,
       panel = my_panel)
