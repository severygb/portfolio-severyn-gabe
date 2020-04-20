# Gabe Severyn
# 4/20/2020

# load packages
library("tidyverse")
library("wrapr")
library("midfielddata")
library(graphclassmate)
library(seplyr)

glimpse(midfielddegrees)

glimpse(midfieldstudents)

#limit to these majors
(engr_major <- wrapr::build_frame(
    "major",      "cip4" |
    "Civil",      "1408" |
    "Electrical", "1410" | 
    "Mechanical", "1419" |
    "Industrial", "1435" 
))
#filter students in any of these majors. String acts as logical expression
(major_string <- str_c(engr_major$cip4, collapse = "|"))
grad_engr <- midfieldstudents %>% 
  filter(str_starts(cip6, major_string))  %>% 
  glimpse()

grad_engr <- grad_engr %>%
  filter(race %in% c("Asian","Black","Hispanic","White")) %>%
  mutate(cip4 = str_sub(cip6, start = 1L, end = 4L)) %>% 
  unite(col = "race_sex", c("race", "sex"), sep = " ", remove = FALSE) %>%
  glimpse()

grad_engr <- left_join(x = grad_engr, y = engr_major, by = "cip4") %>%
  glimpse()

grad_engr <- grad_engr %>%
  select(major, race_sex) %>%
  glimpse()

grad_summary <- grad_engr %>% 
  count(major, race_sex) %>% 
  mutate(major = fct_reorder(major, n)) %>% 
  mutate(race_sex = fct_reorder(race_sex, n)) %>%
  glimpse()

#get each major total
(major_totals <- grad_summary %>%
    group_summarize("major", major_total = sum(n)))

#normalize from count to percent of major
(grad_summary <- grad_summary %>%
  mutate(per = n/major_totals$major_total[unclass(grad_summary$major)]) %>%
  glimpse())

#check the percentage worked out right
(grad_summary %>%
    group_summarize("major", check = sum(per)))
#yep!...

ggplot(grad_summary, aes(x = per*100, y = race_sex)) +
  geom_point() + 
  facet_wrap(vars(major), ncol = 1, as.table = FALSE) +
  labs(x = "Percentage of graduates in the major", y = "", 
       title = "Graduate demographics by engineering major",
       caption = "Source: midfielddata package") +
  theme_graphclass()
