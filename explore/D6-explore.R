#Gabe Severyn
#week 10 2020
# I'm so close!

library(tidyverse)
library(magrittr)
library("GGally")

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
  mutate(area = log10(area*10000)) #converts hectares to square meters

# ggscatmat(area_transformed, columns = 5:13) +
#   geom_point()  +
#   theme(legend.position = "right",
#         panel.spacing = unit(1, "mm"),
#         axis.text.x = element_text(angle = 90, hjust = 1))


png(file = "figures/D6-fires-coplot.png", width = 6, height = 6, units = "in", res = 300)

par(c("cex.main" = "0.8", "cex.lab" = "0.8", "cex.axis" = "1", "adj" = "0.1"))

coplot(ISI ~ area| temp, 
       data = area_transformed,
       xlab = c("Log(Burned Area), sq. m", "Temperature deg. C"),
       ylab = "Initial Spread Index",
       ylim = c(0, 25),
       panel=function(x,y,...) {
          points(x, y)
          abline(v = median(area_transformed$area), lty = 2, col ="steelblue3") }
       )
title(main = "Fires in Portugal")
dev.off()


        
        
#works a treat        
# coplot(ISI ~ area| temp, 
#        data = area_transformed,
#        xlab = "Log(Burned Area), sq. m",
#        ylab = "Initial Spread Index",
#        ylim = c(0, 25)
# )
# 