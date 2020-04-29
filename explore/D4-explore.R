library(rvest)
library(tidyverse)

url <- "http://www.motorsportmemorial.org/query.php?db=ct&q=nationality&n=United%20States"

html_page <- read_html(url)
#node identifier curtesy of the Selector Gadget web tool
drivers_xml <- html_nodes(html_page, ".tablelist td:nth-child(2) , .name a")

#done with first 48 entries for testing. should be 12 complete entries
drivers_text <- html_text(drivers[1:48], trim = T)

(drivers_matrix <- matrix(drivers_text, nrow = length(drivers_text)/4, ncol = 4, byrow = T))

drivers <- as_tibble(drivers_matrix)

drivers %<>%
  rename("name" = "V1") %>%
  rename("date" = "V2") %>%
  rename("role" = "V3") %>%
  rename("circuit" = "V4") %>%
  glimpse()
#now it's in a form I can manage easily.

## To do:
#remove descriptions from columns
#change date into class Date
#change role and circuit into factors
