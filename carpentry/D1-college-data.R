library(readr)
library(tidyverse)
library(seplyr)

#scrape web data
url <- "https://dasl.datadescription.com/download/data/3249"

#brings it in as a tibble
college_raw  <- read_delim(url,
                           col_names = TRUE,
                           delim = "\t")

college <- select(college_raw, c("Public", "Earn", "ACT","need_fraction")) %>% glimpse()

#eliminate rows with NA's
college <- na.omit(college)

#create above/below average ACT data
college <- college %>%
  mutate("ACT_rank" = ifelse(college$ACT > mean(college$ACT), "High ACT", "Low ACT")) %>%
  glimpse()

#create high/low need data
college <- college %>%
  mutate("need_rank" = ifelse(college$need_fraction > mean(college$need_fraction), "High Need", "Low Need")) %>%
  glimpse()

#turn Public into a category
college <- college %>%
  mutate("school_type" = ifelse(college$Public, "Public School", "Private School")) %>%
  glimpse()

#turn 4 combinations into 4 levels & reorder
college <- college %>% 
  mutate(category = str_c(ACT_rank, need_rank, sep = " & ")) %>% 
  mutate(category = fct_reorder(category, Earn)) #default ranking is medianf

saveRDS(college, file = "data/D1-college-data.rds")


# additional data analysis
group_summarize(college, "category", cat_median = median(Earn))
