# Gabe Severyn
# 5/11/2020

# load packages
library("tidyverse")
library("graphclassmate")
library("gclus")


data(bank, package = "gclus")
glimpse(bank)

#convert status to a factor
bank %<>%
  mutate(Status = factor(Status, labels = c("genuine", "counterfeit"))) %>% 
  glimpse()

#just some color assignments
my_color <- c(rcb("dark_BG"),  rcb("dark_Br"))
my_fill  <- c(rcb("light_BG"), rcb("light_Br"))
my_title <- "Comparing Swiss banknote dimensions (mm)"

## using ggscatmat(). uses continuous variables only, except for color
library("GGally")
ggscatmat(bank, columns = 2:7)


ggscatmat(bank, columns = 2:7, color = "Status") + #again but formatted well
  geom_point(size = 1, alpha = 0.1, na.rm = TRUE)  +
  scale_x_continuous(breaks = seq(0, 300, 1)) +
  scale_y_continuous(breaks = seq(0, 300, 1)) +
  scale_color_manual(values = my_color) +
  labs(title = my_title) +
  theme(legend.position = "right",
        panel.spacing = unit(1, "mm"),  
        axis.text.x = element_text(angle = 90, hjust = 1))

#using ggpairs(), most general function, handles any quantitative or categorical
library("GGally")
ggpairs(bank, columns = 2:7)

#everything following this is formatting on the same data...
pm <- ggpairs(bank, columns = 2:7,  
              mapping = ggplot2::aes(color = Status, fill = Status), 
              title   = my_title, 
              legend  = 1, 
              upper   = list(continuous = wrap("cor", size = 2.5))) +
  theme(legend.position = "right",
        panel.spacing = unit(1, "mm"),  
        axis.text.x = element_text(angle = 90, hjust = 1))

# loop through each panel to edit colors
for(i in 1:pm$nrow) {
  for(j in 1:pm$ncol){
    pm[i, j] <- pm[i, j] + 
      scale_fill_manual(values  = my_fill) +
      scale_color_manual(values = my_color)
  }}

# index to the panels I want to edit alpha
row_col_index <- wrapr::build_frame(
  "row", "col" |
    1, 1 |
    2, 2 |
    3, 3 |
    4, 4 |
    5, 5 |
    6, 6
)

# add alpha to the density plots on the diagonal
for(i in 1:nrow(row_col_index)) {
  ii <- row_col_index$row[i]
  jj <- row_col_index$col[i]
  
  p <- pm[ii, jj]
  p <- p + geom_density(alpha = 0.6)
  
  pm[ii, jj] <- p
}
pm


## base R, not recommended because syntax is horrible
pairs(~ Length + Left + Right + Bottom + Top + Diagonal, 
      data = bank, 
      pch  = c(21, 21)[bank$Status],
      col  = my_color[bank$Status],
      bg   = my_fill[bank$Status],
      gap  = 0, 
      upper.panel = NULL, 
      cex.labels = 1, 
      las  = 2, 
      main = my_title
)
par(xpd = NA) # clip to device
legend("topright",   
       title  = "Swiss banknotes", 
       legend = levels(bank$Status), 
       col    = my_color, 
       pt.bg  = my_fill, 
       pch    = 21, 
       inset  = c(0.2, 0.2), 
       bty    = "n", # no border on legend 
       cex    = 0.8, 
       y.intersp = 0.75, 
       title.adj = 0.5) 
par(xpd = FALSE) # return to default


#using scatterplotMatrix() in car package. only numeric data
library("car")
#uses very base-R like syntax, but simpler
scatterplotMatrix(~ Length + Left + Right + Bottom + Top + Diagonal | Status, 
                  data = bank, 
                  pch  = c(16, 3), 
                  cex  = 0.75 * c(1, 1), 
                  col  = my_color, 
                  cex.labels = 1, 
                  cex.axis = 1, 
                  cex.main = 1, 
                  main = my_title, 
                  use = "pairwise.complete.obs"
)


## using gpairs() in gpairs package, any data will work. adds some extra formatting for you
library("gpairs")
gpairs(bank[ , 2:7],
       lower.pars = list(scatter = "points"), 
       upper.pars = list(scatter = 'stats'), 
       scatter.pars = list(pch = 16, 
                           size = unit(5, "pt"), 
                           col  = my_color[bank$Status], 
                           frame.fill = NULL, 
                           border.col = "gray50"), 
       stat.pars = list(verbose = FALSE), 
       gap = 0
)
