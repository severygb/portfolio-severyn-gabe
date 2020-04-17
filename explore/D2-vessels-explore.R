library(tidyverse)
library(pdftools)
library(cdata)
library(tidyr)
library(graphclassmate)

#start with the relevant page extracted from the whole report, to simplify it greatly
txt <- pdf_text("data-raw/US-flag-vessels.pdf")

str(txt)

str_trim(str_sub(txt, 1, 751)) #using '\r\n' for new lines

table <- str_split(txt, "\r\n", simplify = TRUE) %>% 
  glimpse()


# column names ------------------------------------------------------
header_start  <- str_which(table, "Age1")
header_end    <- str_which(table, "2000, Total vessels") - 1

# subset the header
head <- table[1, header_start : header_end] %>% 
  glimpse()

#replace all spaces with delimiters
head <- str_replace_all(head, "\\s{1,}", ";") %>% 
  glimpse()

head <- str_replace_all(head, "Age1", "Age")
head <- str_replace_all(head, "Dry;cargo", "Dry cargo")
head <- str_replace_all(head, "Dry;barge",   "Dry barge")
head <- str_replace_all(head, "Liquid;barge", "Liquid barge")

head <- strsplit(head, ";")
head

# data table ----------------------------------------------------

# identify the first and last strings we want to keep. headers not included
table_start  <- str_which(table, "2000, Total vessels")
table_end    <- str_which(table, "2014, Total vessels") - 1

# subset the table 
table <- table[1, table_start : table_end] %>% 
  glimpse()

#replace all spaces with delimiters
table <- str_replace_all(table, "\\s{1,}", ";") %>% 
  glimpse()
table

#add some spaces back when labels are multiple words
table <- str_replace_all(table, "2000,;Total;vessels", "2000 Total vessels")

#make into tibble. Each row becomes one obervation
table <- tibble::enframe(table, name = NULL, value= "row")

table <- table %>% 
  slice(-2) %>%
  separate(col = "row", 
           into = c("blah","Age", "Dry Cargo", "Tanker", "Towboat", "Passenger", "Crewboat", "Dry Barge", "Liquid Barge", "Total"), 
           sep = ";")
table <- select(table, -c("blah", "Total")) #get rid of empty and total columns

# start with coordinatized table -----------------------------------

#extract totals
totals_2000 <- table[1,2:ncol(table)] %>%
  str_replace_all(",", "") %>%
  as.numeric()

vessels_2000 <- table[2:nrow(table),] #only left with percentage table data

#convert type to factor
#type_levels <- c("Dry Cargo", "Tanker", "Towboat", "Passenger", "Crewboat", "Dry Barge", "Liquid Barge")

vessels_2000 <- pivot_longer(vessels_2000, cols = 2:ncol(vessels_2000), names_to = "type", values_to = "n")

vessels_2000 <- vessels_2000 %>%
  mutate(type = factor(type))

vessels_2000 <- vessels_2000 %>%
  mutate(n = as.numeric(n)) %>%
  mutate(n = n/100*totals_2000[unclass(vessels_2000$type)]) %>% #this line is magic
  mutate(Age = factor(Age, levels = c("<6", "6–10", "11–15", "16–20","21–25",">25"))) %>%
  mutate(type = fct_reorder(type, n)) %>%
  glimpse()


p <- ggplot(vessels_2000, aes(x = n, y = Age)) +
  geom_point() +
  facet_wrap(vars(type), as.table = FALSE) +
  theme_graphclass() +
  scale_x_log10() +
  labs(x = "Number of boats", y = "Age of vessel", subtitle = "U.S. flag vessels in 2000")
p

p2 <- ggplot(vessels_2000, aes(x = n, y = type)) +
  geom_point() +
  facet_wrap(vars(Age), as.table = FALSE) +
  theme_graphclass() +
  scale_x_log10() +
  labs(x = "Number of boats", y = "Age of vessel", subtitle = "U.S. flag vessels in 2000")
p2