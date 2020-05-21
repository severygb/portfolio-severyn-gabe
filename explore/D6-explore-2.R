#Gabe Severyn
#week 10 2020
# I'm so close!

library("tidyverse")
library("GGally")
library("graphclassmate")

url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.csv"
Fires_data <- read.csv(file = url, header = T, sep = ",") %>%
  glimpse()

#About the data set and variables: https://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.names
# 1. X - x-axis spatial coordinate within the Montesinho park map: 1 to 9
# 2. Y - y-axis spatial coordinate within the Montesinho park map: 2 to 9
# 3. month - month of the year: "jan" to "dec" 
# 4. day - day of the week: "mon" to "sun"
# 5. FFMC - Fine Fuel Moisture Code index from the FWI system
# 6. DMC - Duff Moisture Code index from the FWI system
# 7. DC - Drought Code index from the FWI system
# 8. ISI - Initial Spread Index index from the FWI system
# 9. temp - temperature in Celsius degrees: 2.2 to 33.30
# 10. RH - relative humidity in %: 15.0 to 100
# 11. wind - wind speed in km/h: 0.40 to 9.40 
# 12. rain - outside rain in mm/m2 : 0.0 to 6.4 
# 13. area - the burned area of the forest (in ha): 0.00 to 1090.84 
# (this output variable is very skewed towards 0.0, thus it may make sense to model with the logarithm transform). 

#try a scatterplot matrix first
# ggscatmat(Fires_data, columns = 5:13) +
#   geom_point()  +
#   theme(legend.position = "right",
#         panel.spacing = unit(1, "mm"),
#         axis.text.x = element_text(angle = 90, hjust = 1))

# area_transformed <- Fires_data %>%
#   mutate(area = log10(area)) %>%
#   filter(area > 0)


area_transformed <- Fires_data %>%
  mutate(area = log10(area*10000))

# ggscatmat(area_transformed, columns = 5:13) +
#   geom_point()  +
#   theme(legend.position = "right",
#         panel.spacing = unit(1, "mm"),
#         axis.text.x = element_text(angle = 90, hjust = 1))

# comment out the PNG function to see the figure in the plot pane
# png(file = "figures/D6-fires-coplot-2.png", width = 6, height = 6, units = "in", res = 300)


# using coplot I could not figure out how to get the median line in each panel
my_panel <- function(x, y, subscripts, ...) {
  panel.smooth(x = x, y = y, span = 0.8, iter = 5, col.smooth = "blue")
  points(x = x, y = y, ...)
}
coplot(ISI ~ area | temp, 
       data = df, 
       pch = 16, 
       subscripts = TRUE, 
       panel = my_panel, 
       xlab = c(expression(paste("Burned area, log(", m^2, ")")), 
                "Temperature (C)"), 
       ylab = "Initial spread index (ISI)",
       ylim = c(0, 25)
)
# title(main = "Fires in Portugal")
# dev.off()








## ---------------------------------------------------
# Trying to create a coplot in ggplot
# successful, achieved everything I wanted except
# we lost the panel showing the conditioning variable 
# instead, the conditioning variable range is shown in the panel header




df <- area_transformed #area manually changed to log scale
df_nolog <- Fires_data #let ggplot take care of the log scale



# this function borrowed from 
# https://jfukuyama.github.io/teaching/stat670/notes/lecture-11.html 
# to set up ggplot to create coplot 
make_coplot_df <- function(data_frame, faceting_variable, number_bins = 6) {
  
  ## co.intervals gets the limits used for the conditioning intervals
  intervals = co.intervals(data_frame[[faceting_variable]], number = number_bins)
  
  ## indices is a list, with the ith element containing the indices of the
  ## observations falling into the ith interval
  indices = apply(intervals, 1, function(x)
    which(data_frame[[faceting_variable]] <= x[2] & data_frame[[faceting_variable]] >= x[1]))
  
  ## interval_descriptions is formatted like indices, but has interval
  ## names instead of indices of the samples falling in the index
  interval_descriptions = apply(intervals, 1, function(x) {
    num_in_interval = sum(data_frame[[faceting_variable]] <= x[2] & data_frame[[faceting_variable]] >= x[1])
    interval_description = sprintf("%.0f to %.0f C", x[1], x[2])
    return(rep(interval_description, num_in_interval))
  })
  
  ## df_expanded has all the points we need for each interval, and the
  ## 'interval' column tells us which part of the coplot the point should
  ## be plotted in
  df_expanded = data_frame[unlist(indices),]
  df_expanded$interval = factor(unlist(interval_descriptions),
                                levels = unique(unlist(interval_descriptions)), ordered = TRUE)
  return(df_expanded)
} 


n_facet = 5
df_expanded <- make_coplot_df(df, "temp", n_facet) %>%  # CHANGED TO EXPLORE LOG SCALE!
  filter_all(all_vars(!is.infinite(.)))

glimpse(df_expanded)

df2 <- df_expanded %>%
  group_by(interval) %>%
  summarise_at(vars(area), list(~median(.), ~min(.), ~max(.))) %>%
  glimpse()

#makes tall orientation
ggplot(df_expanded, aes(x = area, y = ISI)) +
  geom_smooth(se = FALSE, span = 0.75, size = 0.8, color = rcb("dark_BG")) +
  geom_vline(data = df2, aes(xintercept = median), linetype = "dashed") +
  geom_point(size = 2, alpha = 0.4, color = rcb("dark_BG")) +
  facet_wrap(vars(interval), ncol = 1, as.table = FALSE) +
  coord_fixed(ratio = 1/((n_facet + 2) * 1.6)) +
  theme_graphclass() + 
  labs(x = expression(paste("Burned area, log(", m^2, ")")), 
      y = "Initial spread index (ISI)", 
      title = "Fires in Portugal")

#switch to wide orientation
ggplot(df_expanded, aes(x = ISI, y = area)) +
  geom_hline(data = df2, aes(yintercept = median), linetype = "dashed", size = 0.6) +
  geom_hline(data = df2, aes(yintercept = min), linetype = "twodash", colour = rcb("dark_Br"), size = 0.6) +
  geom_hline(data = df2, aes(yintercept = max), linetype = "twodash", color = rcb("dark_Br"), size = 0.6) +
  geom_point(size = 2, alpha = 0.4, color = rcb("dark_BG")) +
  facet_wrap(vars(interval), ncol = 5, as.table = FALSE) +
  coord_fixed(ratio = 8) +
  theme_graphclass() + 
  labs(y = expression(paste('Burned area, log'[10]*'(m'^2*')')), 
       x = "Initial spread index (ISI)", 
       title = "Initial Spread Index does not predict fire damage")

ggsave("D6-fires-coplot-ggplot.png",
      path    = "figures",
      width   = 8,
      height  = 3,
      units   = "in",
      dpi     = 300
      )
