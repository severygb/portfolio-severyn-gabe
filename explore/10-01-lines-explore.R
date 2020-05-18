# Gabe Severyn
#05/18/2020

library(tidyverse)

grouping_variables <- c("race", "path", "sex")

df <- nontraditional  %>% 
  seplyr::group_summarize(grouping_variables, 
                          enrolled = mean(enrolled)) %>%
  mutate(abbrev = str_sub(race, start = 1L, end = 1L)) %>%
  mutate(Key = str_c(abbrev, " : ", race))
df

#summarize data: years enrolled for each demographic by path type
df <- cdata::pivot_to_rowrecs(df,
                              columnToTakeKeysFrom   = "path",
                              columnToTakeValuesFrom = "enrolled",
                              rowKeyColumns          = c("race", "sex")) 
knitr::kable(df)


#use a 45-degree abline to show equality between the two groups
#put horizontal and vertical reference lines at 4 year marks
ggplot(data = df, mapping = aes(x = Traditional, y = Nontraditional, color = sex, label = abbrev, fill = Key)) +
  geom_abline(slope = 1, intercept = 0, color = rcb("light_Gray")) +
  geom_text(size = 3) +
  geom_point(alpha = 0) +
  coord_fixed(ratio = 1) +
  scale_fill_discrete(guide = guide_legend(title.hjust = 0.4, 
                                           override.aes = list(alpha = 0))) +
  theme(legend.key = element_blank())

# tasks:
# replace data markers with letter to represent race