library(tidyverse)
library(magick)

magick_config()

frink <- image_read("https://jeroen.github.io/images/frink.png")
print(frink)

image_crop(image, "100x150+50") #crop out width:100px and height:150px starting +50px from the left
image_scale(image, "200") #resize proportionally to width: 200px
image_scale(image, "x200") #resize proportionally to height: 200px
image_fill(image, "blue", "+100+200") #flood fill with blue starting at the point at x:100, y:200
image_border(frink, "red", "20x10") #adds a border of 20px left+right and 10px top+bottom

# more examples at https://cran.r-project.org/web/packages/magick/vignettes/intro.html
#more syntax at http://www.imagemagick.org/Magick++/Geometry.html

# Add some text
image_annotate(frink, "I like R!", size = 70, gravity = "southwest", color = "green")

# Customize text
image_annotate(frink, "CONFIDENTIAL", size = 30, color = "red", boxcolor = "pink",
               degrees = 60, location = "+50+100")

#also possible to do animations and gifs. Stack images, flatten, stack, etc.
# ! possible to draw images on plots!
#can extend to animate plots too