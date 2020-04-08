# reshape World Health Organization tuberculosis data   
# Gabe Severyn
# 04/06/2020

# load packages
library("tidyverse")
library("graphclassmate")
library("cdata")
library("wrapr")
library("rio")

# using rio to read and write. Only run once.
# who_url <- "https://extranet.who.int/tme/generateCSV.asp?ds=notifications"
# who     <- rio::import(who_url, format = "csv")
# rio::export(who, "data-raw/TB-notifications.csv", )

# check out the CSV file 
who <- read.csv("data-raw/TB-notifications.csv") %>% 
  as_tibble() %>% 
  print()

#look at the years included in the data
who %>% select(year) %>% 
  unique() %>% 
  t() %>% 
  cat()

who <-  who %>% 
  select(country, 
         year, 
         matches("014|1524|2534|3544|4554|5564|65", ignore.case = TRUE))

glimpse(who)

#we have 59 colums with age and gender built in. We want to separate these
names(who)

#take data from these columns
these_names <- names(who)[3:61]

#converts that data to a key column and a numerical column
who_tall <- unpivot_to_blocks(
  data                  = who,
  nameForNewKeyColumn   = "code",
  nameForNewValueColumn = "N",
  columnsToTakeFrom     = these_names
)

#now we have only 4 variables
glimpse(who_tall)

#needs cleaning, this deletes all rows with NA values
who_tall <- who_tall %>% 
  drop_na() %>% 
  glimpse()


#to separate the code variable into more usefull categories, must do some name manipulation
unique(who_tall$code)

who_tall <- who_tall %>% 
  mutate(code = stringr::str_replace(code, "newrel", "new_rel"))

unique(who_tall$code) #now they all start with 'new_'

#change all unknown sex to 'u'
who_tall <- who_tall %>% 
  mutate(code = stringr::str_replace(code, "sexunk", "u"))

#split code into 3 variables
who_tall <- who_tall %>% 
  separate(code, c("new_or_old", "type_of_case", "sex_age"), sep = "_")

glimpse(who_tall)

#don't care about type_of_case or new_or_old. get rid of them
who_tall <- who_tall %>% 
  select(country, year, sex_age, N) %>% 
  glimpse()

#separate sex_age after first character. 1st char is sex, following numbers are age range
who_tall <- who_tall %>% 
  separate(sex_age, c("sex", "age_group"), sep = 1) %>% 
  glimpse()

unique(who_tall$sex)

grouping_variables <- c("country", "year", "sex")
who_sum <- seplyr::group_summarise(who_tall, 
                                   grouping_variables,
                                   N = sum(N)) %>%
  as.data.frame() %>% 
  glimpse()

# plot each country in a panel
p <- ggplot(data = who_sum, aes(x = year, y = N/1e+6, col = sex, group = sex)) +
  geom_line(size = 1) +
  facet_wrap(~reorder(country, N), ncol = 8, as.table = FALSE) +
  labs(x = "", 
       y = "", 
       title   = "Annual cases of tuberculosis (millions)", 
       caption = "Source: 2019 World Health Organization") +
  scale_x_continuous(breaks = c(1980, 2000)) +
  theme_graphclass()
p

who2 <- who_sum %>% 
  dplyr::filter(country %in% c("India", "China", "South Africa", "Indonesia", "Bangladesh", "Canada", "United States of America", "Mexico", "Russian Federation")) %>% 
  dplyr::filter(sex != "u")

# edit the existing graph 
p <- p %+% 
  who2 +
  facet_wrap(~reorder(country, N), ncol = 3, as.table = FALSE) +
  scale_x_continuous(breaks = seq(1995, 2015, by = 5), limits = c(1995, 2017))

p
