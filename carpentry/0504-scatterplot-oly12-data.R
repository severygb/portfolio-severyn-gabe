library("tidyverse")
data(oly12, package = "VGAMdata")

levels(oly12$Sport)


#recode some levels, and drop ones with no people
oly12 <- oly12 %>% 
  mutate(Sport = fct_recode(Sport,
                            "BMX" = "Cycling - BMX",
                            "BMX" = "Cycling - BMX, Cycling - Track",
                            "Mountain Bike" = "Cycling - Mountain Bike",
                            "Mountain Bike" = "Cycling - Mountain Bike, Cycling - Road",
                            "Mountain Bike" = "Cycling - Mountain Bike, Cycling - Road, Cycling - Track",
                            "Mountain Bike" = "Cycling - Mountain Bike, Cycling - Track", 
                            "Road Cycling"  = "Cycling - Road", 
                            "Road Cycling"  = "Cycling - Road, Cycling - Track",  
                            "Pentathlon"    = "Modern Pentathlon"
  )) %>% 
  droplevels()

# sports to drop because of limited participation 
drop_these <- oly12 %>% 
  count(Sport) %>% 
  filter(n < 50) %>% 
  select(Sport) %>% 
  droplevels()

drop_these_sports <- as.character(drop_these$Sport)

# select and filter
df <- oly12 %>% 
  as_tibble() %>% 
  select(Name, Country, Age, Height, Weight, Sex, Sport, Event) %>% 
  filter(!Sport %in% drop_these_sports) %>% 
  filter(Weight < 200) %>% 
  filter(complete.cases(.)) %>% 
  distinct() %>% 
  droplevels()

#order sports by w + 40*h
df <- df %>% 
  mutate(Sex   = fct_reorder(Sex,   Weight + 40*Height)) %>% 
  mutate(Sport = fct_reorder(Sport, Weight + 40*Height))

saveRDS(df, "data/0504-scatterplot-oly12-data.rds")
