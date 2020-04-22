library(tidyverse)
library(graphclassmate)

imports <- readRDS(file = "data/D3-imports.rds")

#recode factors for presentation
imports <- imports %>% 
  mutate(drive.wheels = fct_recode(drive.wheels,
      "Front wheel drive"    = "fwd",
      "Rear wheel drive"      = "rwd"
  ))

ggplot(imports, aes(x = stroke, y = bore, color = body.style)) +
  geom_point() +
  facet_wrap(vars(drive.wheels)) +
  labs(y = "Engine bore (inch)", x = "Engine stroke (inch)", 
       title = "Engines in front wheel drive vehicles have a smaller bore") +
  theme_graphclass()

#try change legend to plotting symbols for each level, eliminate legend
#look at bore:stroke to see over/under square
#chose x and y axis to highlight difference between bore size

ggsave(filename = "D3-imports-engines.png",
       path    = "figures",
       width   = 8,
       height  = 5.3,
       units   = "in",
       dpi     = 300)
