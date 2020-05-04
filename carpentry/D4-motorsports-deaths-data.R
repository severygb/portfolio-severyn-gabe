library(rvest)
library(tidyverse)
library(lubridate)

url <- "http://www.motorsportmemorial.org/query.php?db=ct&q=nationality&n=United%20States"

html_page <- read_html(url)
#node identifier curtesy of the Selector Gadget web tool
deaths_xml <- html_nodes(html_page, ".tablelist td:nth-child(2) , .name a")

#done with first 48 entries for testing. should be 12 complete entries
deaths_text <- html_text(deaths_xml, trim = T)

deaths_matrix <- matrix(deaths_text, nrow = length(deaths_text)/4, ncol = 4, byrow = T)

deaths <- as_tibble(deaths_matrix)

deaths %<>%
  rename("name" = "V1") %>%
  rename("date" = "V2") %>%
  rename("role" = "V3") %>%
  rename("circuit" = "V4") %>%
  glimpse()

#does things to factors
deaths %<>%
  mutate(role = substr(role, 7, nchar(role))) %>%
  mutate(circuit = substr(circuit, 10, nchar(circuit))) %>%
  mutate(role = factor(role)) %>%
  mutate(circuit = factor(circuit)) %>%
  mutate(date = substr(date, 13, nchar(date))) %>%
  glimpse()

summary(deaths$role)
nlevels(deaths$circuit)

#do things to dates
typeof(deaths$date[1])

deaths %<>%
  mutate(date = dmy(date)) %>%
  mutate(year = year(date)) %>%
  na.omit() %>%
  glimpse()

min(deaths$year)
max(deaths$year)

saveRDS(deaths, file = "data/D4-motorsports-deaths-individual.rds")

#data is tidy and workable now ------------------------------------

#summarize counts per year. gives a single number per year.
year_deaths <- deaths %>%
  count(year) %>%
  glimpse()

#add zeros for years without deaths
year_deaths <- tidyr::complete(year_deaths, year = 1902:2019, fill = list(n = 0))

#turn back to year to plot nicely
year_deaths %<>% 
  mutate(year = make_date(year = year)) %>%
  glimpse()

saveRDS(year_deaths, file = "data/D4-motorsports-deaths-yearly.rds")
