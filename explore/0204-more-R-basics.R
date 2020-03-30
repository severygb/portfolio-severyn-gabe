library(tidyverse)

x1 <- seq(from = 0, to = 10, by = 0.5)
y1 <- sin(x1)

df <- tibble(x1, y1)

ggplot(df, aes(x = x1, y = y1)) +
  geom_point() +
  geom_line()