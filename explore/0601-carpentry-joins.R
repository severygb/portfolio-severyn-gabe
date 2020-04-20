# Gabe Severyn
# 4/20/2020

# load packages
library("tidyverse")
library("wrapr")
library("midfielddata")
library(graphclassmate)

glimpse(midfielddegrees)

glimpse(midfieldstudents)

#sample of cip6 degree codes
midfielddegrees %>% 
  select(cip6)  %>% 
  arrange(cip6) %>% 
  distinct()    %>% 
  sample_n(10) 

#engineering codes start with 14
grad_engr <- midfielddegrees %>% 
  filter(str_starts(cip6, "14"))

grad_engr %>% 
  select(cip6)  %>% 
  arrange(cip6) %>% 
  distinct()  

#pick out the majors by their starting patterns
(engr_major <- wrapr::build_frame(
    "major",      "cip4" |
    "Civil",      "1408" |
    "Computer",   "1409" | 
    "Electrical", "1410" | 
    "Mechanical", "1419" |
    "Industrial", "1435" 
))

#filter students in any of these majors. String acts as logical expression
(major_string <- str_c(engr_major$cip4, collapse = "|"))
grad <- grad_engr %>% 
  filter(str_starts(cip6, major_string))  %>% 
  glimpse()

grad %>% 
  select(cip6)  %>% 
  arrange(cip6) %>% 
  distinct() 
#now we only have students in these five majors


#prepare data to be joined together, by only keeping relevant columns
grad <- grad %>%
  select(id, institution, cip6) 

demographics <- midfieldstudents %>% 
  select(id, sex, race) 

#left join attaches y to x by row-wise matching 'by'
grad <- left_join(x = grad, y = demographics, by = "id") %>% 
  glimpse()

#add cip4 column to attach majors to grads
grad <- grad %>%
  mutate(cip4 = str_sub(cip6, start = 1L, end = 4L)) %>% 
  glimpse()

#left join by the 4-digit major code
grad <- left_join(x = grad, y = engr_major, by = "cip4") %>%
  glimpse()

# two data sets are now joined, can move on to other carpentry work -------------
grad <- grad %>% 
  select(institution, major, sex, race) %>% 
  glimpse()

grad <- grad %>% 
  dplyr::rename("inst" = "institution") %>% 
  mutate(inst = str_remove_all(inst, "itution")) %>%
  unite(col = "race_sex", c("race", "sex"), sep = " ", remove = FALSE) %>%
  glimpse()

#turn individual data into summary data by institution, major and race_sex
grad1 <- grad %>% 
  count(inst, major, race_sex) %>% 
  mutate(inst = fct_reorder(inst, n)) %>% 
  mutate(major = fct_reorder(major, n)) %>% 
  mutate(race_sex = fct_reorder(race_sex, n)) %>% 
  glimpse()

ggplot(data = grad1, mapping = aes(x = n, y = race_sex)) +
  geom_point() + 
  facet_grid(rows = vars(inst), cols = vars(major), as.table = FALSE)
# ^ that graph is horrible, but useful to see what we have to work with.

#not all combinations have data points, so we drop institution and try again
grad2 <- grad %>% 
  count(major, race, sex) %>% 
  mutate(major = fct_reorder(major, n)) %>% 
  mutate(race = fct_reorder(race, n)) %>% 
  mutate(sex = fct_reorder(sex, n)) %>% 
  glimpse()

ggplot(data = grad2, mapping = aes(x = n, y = race)) +
  geom_point() + 
  facet_grid(rows = vars(sex), cols = vars(major), as.table = FALSE)

#with more formatting this time
ggplot(data = grad2, mapping = aes(x = n, y = race)) +
  geom_point(size = 2) + 
  facet_grid(rows = vars(sex), cols = vars(major), as.table = FALSE) + 
  scale_x_continuous(trans = "log2") +
  labs(x = "Number of graduates (log2 scale)", y = "", caption = "Source: midfielddata R package", title = "Comparing graduates of five engineering programs") +
  theme_graphclass() 
