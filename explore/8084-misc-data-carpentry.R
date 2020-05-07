# Gabe Severyn
# 05/07/2020

# load packages
library("tidyverse")
library("nycflights13")
library("wrapr")


#use dplyr::near(x, y) to compare floating point numbers x and y
dplyr::near(sqrt(2) ^ 2,  2)

#filter == for many things, without horrible compound logical statements
filter(flights, month %in% c(11, 12))


#qchar_frame builds character dataframes w/o quotes, just simpler
band1 <- wrapr::qchar_frame(
  name, surname |
    John, Lennon|
    Paul, McCartney|
    George, Harrison|
    Ringo, Starr
)
band1


band2 <- wrapr::qchar_frame(
  name, surname |
    Mic, Jagger|
    Keith, Richards|
    Charlie, Watts|
    Ronnie, Wood
)
band2

#check both data frames have the same variables
all_equal(names(band1), names(band2))

#bind by rows- appends rows with in two df's with the same columns
bind_rows(band1, band2)

#adds a new variable 'band' while binding, easily tells which df a row came from
bind_rows(.id = "band", "Beatles" = band1, "Stones" = band2) 

# cut() - divides a continuous variable into segments (bins), useful for turning to factors
data(state)
df <- data.frame(state.x77)

# state names are in the row names
df <- df %>% 
  rownames_to_column("State") %>% 
  glimpse() 

#cuts Income into bins with at values in 'breaks =' and names them. Defaults to named factors 
df <- df %>% 
  mutate(Income_bins = cut(
    Income,  
    include.lowest = TRUE, 
    breaks = quantile(Income, probs = c(0, 0.25, 0.5, 0.75, 1)), 
    labels = c("Lower 25%", 
               "Lower middle, 25-50%", 
               "Upper middle, 50-75%", 
               "State median income in the upper 25%")
  )) %>% 
  glimpse()

df <- df %>% 
  mutate(Literacy = 100 - Illiteracy)
ggplot(data = df, mapping = aes(x = Literacy, y = Life.Exp)) +
  geom_point() +
  facet_wrap(vars(Income_bins), ncol = 1, as.table = FALSE)
#shows each factor as a facet, previously a continuous variable

# missing values --------------------------------------------------------

data(biopics, package = "fivethirtyeight")

biopics <- biopics %>%
  select(country, year_release, box_office, number_of_subjects, type_of_subject, subject_race, person_of_color, subject_sex) %>%
  mutate(subject_race = str_replace(subject_race, "^Hispanic", "Hispanic")) %>% 
  mutate(subject_race = str_replace(subject_race, "^African", "African")) %>%     
  mutate(subject_race = str_replace(subject_race, "^Middle", "Mid Eastern")) %>%  
  mutate(subject_race = ifelse(subject_race %in% c("White", "Asian", "African", "Hispanic", "Mid Eastern", "Multi racial", NA), subject_race, "Other")) %>%
  mutate(country          = factor(country),
         type_of_subject = factor(type_of_subject),
         subject_race    = factor(subject_race),
         subject_sex     = factor(subject_sex),
         person_of_color = as.integer(person_of_color)) %>%
  as.data.frame()

colnames(biopics) <- c("country", "year", "earnings", "sub_num", "subj_type", "subj_race", "non_white", "subj_sex")

library("VIM")
#creates graph to show which things are missing and how often.
aggr(biopics, 
     # color: observed, missing, imputed
     col = c(rcb("pale_BG"), rcb("mid_BG")), 
     numbers  = TRUE, 
     bars     = TRUE, 
     sortVars = TRUE, 
     prop     = TRUE, 
     combine  = TRUE
)
# variables are horizontal, freq of missing variable is on top. Each combination of missing variables is vertical. Freq of missing combination is on right.

# width of the bars represents the relative frequency of the levels
# height represents the relative proportion of missing to observed
x <- biopics %>% 
  select("subj_race", "earnings")
spineMiss(x, 
          col = c(rcb("pale_BG"), rcb("mid_BG")))