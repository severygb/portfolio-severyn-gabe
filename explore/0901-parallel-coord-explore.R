# Gabe Severyn
# 5/11/2020

# load packages
library("tidyverse")
library("graphclassmate")
library("GGally")

library("gclus")
data(bank, package = "gclus")

bank <- as_tibble(bank) %>% 
  glimpse()

#most basic version
ggparcoord(bank, columns = 2:7)

#colors again
my_color <- c(rcb("dark_BG"),  rcb("dark_Br"))
my_fill  <- c(rcb("light_BG"), rcb("light_Br"))
my_title <- "Comparing Swiss banknote dimensions (mm)"

#need a factor to condition by it
bank <- bank %>%
  mutate(Status = factor(Status, labels = c("genuine", "counterfeit"))) %>% 
  drop_na() %>% 
  glimpse()

#many possible arguments for y-axis scale
# std           subtract mean and divide by standard deviation
# robust        subtract median and divide by median absolute deviation
# uniminmax     minimum of the variable is zero, and the maximum is one
# globalminmax  no scaling
# center        uniminmax then center each variable at scaleSummary
# centerObs     uniminmax then center each variable at centerObsID

library("scagnostics")
ggparcoord(data = bank, columns = 2:7, groupColumn  = "Status",
           scale        = "robust", 
           # scaleSummary = "median", # use with  scale == “center”
           # centerObsID  = 1,        # use with scale == “centerObs”
           missing      = "exclude", 
           order        = "Skewed", # scagnostic measures 
           alphaLines   = 0.4, 
           mapping      = NULL, 
           title        = my_title) +
  labs(x = "", y = "")

#use scagnostics library to order the variables on the x axis, changes the graph story. Lots of possibilities
      # Outlying 
      # Skewed 
      # Clumpy 
      # Sparse 
      # Striated 
      # Convex 
      # Skinny 
      # Stringy 
      # Monotonic
#choose one by looking at the distribution of the variables, code below
bank2 <- bank %>% 
  gather(type, value, Length:Diagonal)

ggplot(bank2, aes(value, color = Status)) +
  geom_density() +
  facet_wrap(vars(type), scales = "free_x", as.table = FALSE)