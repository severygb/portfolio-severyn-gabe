library(tidyverse)

df2 <- state.x77

df2 <- cbind(rownames(df2), data.frame(df2, row.names=NULL))

glimpse(df2)

df2 <- df2 %>%
  rename("State" = "rownames(df2)") %>%
  mutate(State = factor(State)) %>%
  glimpse()

df2 <- df2 %>%
  mutate(State = fct_reorder(State, Area)) %>%
  glimpse()

saveRDS(df2, file = "data/0501-factor-state.rds")