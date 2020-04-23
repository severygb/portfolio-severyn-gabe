library("tidyverse")
library("magick")
library(graphclassmate)

df <- readRDS("data/0602-dotplot-cdc-infants-data.rds")

p <- ggplot(data = df, mapping = aes(x = age, y = rate)) +
  geom_point() +
  facet_wrap(vars(region), as.table = FALSE)
p

p <- p + 
  facet_wrap(vars(region), as.table = FALSE, nrow = 1)
p

p <- p + 
  labs(y = "", 
       title = "Infant deaths per 1000 births, less than one year old, born to US citizens\n", 
       caption = "Source: CDC, 2007-2016")
p

#pick out upper age range by last two characters in the label string
df <- df %>% 
  mutate(age = str_sub(age, 4, 5))  %>% 
  mutate(age = as.integer(age) + 1)

p <- p %+% 
  df +
  labs(x = "\nUpper limit of mother's age group")
p

p <- p + 
  theme_graphclass(line_color = rcb("mid_Gray"), 
                   font_color = "black", 
                   font_size = 12) + 
  theme(axis.line = element_line(colour = rcb("pale_Gray")), 
        strip.text = element_text(color = rcb("dark_Gray"), face = "bold"), 
        plot.margin = unit(c(2, 4, 1, 0), "mm"), # top, right, bottom, and left margins
        panel.border = element_rect(color = rcb("pale_Gray"), fill = NA), 
        panel.spacing = unit(3, "mm"), 
        plot.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.grid.minor = element_blank(), 
        strip.background = element_rect(color = rcb("pale_Gray"), fill = rcb("pale_Gray"))
  )
p

p <- p + 
  aes(fill = race) +
  geom_point(size = 2.5, shape = 21, color = "black") +
  scale_fill_manual(values = c("black", rcb("pale_Gray")))
p


#label data points inside the first panel, pick which one with filter
df_note <- df %>% 
  filter(region == "West") %>% 
  filter(age == 20)

# append a layer with the new data frame and the new aes() in the geom
p <- p + 
  geom_text(data = df_note, 
            mapping = aes(x = age, y = rate, label = race), 
            hjust    = 0, 
            nudge_x  = 1, 
            vjust    = 0, 
            nudge_y  = 0, 
            size     = 4, 
            color    = rcb("dark_Gray"), 
            fontface = "bold")
p
# adjust the y-scale and omit the legend 
final_graph <- p +
  scale_y_continuous(limits = c(0, max(df$rate))) +
  theme(legend.position = "none") 
final_graph

ggsave(plot = final_graph, 
       filename = "0602-dotplot-cdc-infants-1.png",
       path    = "figures",
       width   = 8,
       height  = 4,
       units   = "in",
       dpi     = "retina")

# move into image editing and compiling
image_file <- "resources/0602-dotplot-child.png"
image_url  <- "http://tinyurl.com/y3xjyh63"

if(!file.exists(image_file)) {
  child <- image_read(image_url)  
  image_write(child, path = image_file, format = "png")
}

image_file <- "resources/0602-dotplot-woman.png"
image_url  <- "http://tinyurl.com/y474loe7"

if (!file.exists(image_file)) {
  woman <- image_read(image_url)
  image_write(woman, path = image_file, format = "png")
}

# read images
the_graph <- image_read("figures/0602-dotplot-cdc-infants-1.png")
child     <- image_read("resources/0602-dotplot-child.png")
mother    <- image_read("resources/0602-dotplot-woman.png")

# convert to gray scale 
child  <- image_quantize(child,  max = 10, colorspace = "gray")
mother <- image_quantize(mother, max = 10, colorspace = "gray")

# adjust brightness and contrast
mother <- image_modulate(mother, brightness = 200)
mother <- image_contrast(mother, sharpen = 0)

# overlay a solid color frame with specified opacity. essentially tints the image
child  <- image_colorize(child,  opacity = 25, color = "white")
mother <- image_colorize(mother, opacity = 25, color = "white")

# scale them to the same width (in pixels) 
child  <- image_scale(child, "500")
mother <- image_scale(mother, "500")

# append them together in a stacked image
people <- image_append(c(child, mother), stack = TRUE)

# add an effect
people <- image_noise(people)

# add a border 
people <- image_border(people, rcb("pale_Gray"), "15x15")
the_graph <- image_border(the_graph, rcb("pale_Gray"), "15x15")

# scale the heights to match 
people    <- image_scale(people, "x500")
the_graph <- image_scale(the_graph, "x500")

# append to the graph image 
final_img <- image_append(c(people, the_graph), stack = FALSE)

# headline box same wiodth as figure 
width  <- image_info(final_img)[["width"]]

# select a height (pixels) by trial and error
height <- 60

# create the box 
text_box <- image_blank(width = width, height = height, color = rcb("pale_Gray"))

# add the headline text to the box 
text_box <- image_annotate(text_box, 
                           text     = "Mortality of Black infants is twice that of non-Black infants", 
                           gravity  = "west", 
                           location = "+10+0", 
                           size     = 40, 
                           color    = rcb("dark_Gray"), 
                           font     = "Georgia")

# join the headline to the image 
final_img <- image_append(c(text_box, final_img), stack = TRUE)

# and write to file
image_write(final_img, 
            path = "figures/0602-dotplot-cdc-infants-2.png", 
            format = "png")
