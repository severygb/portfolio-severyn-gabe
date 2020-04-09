library(tidyverse)
library(readxl)

#GRIDLIFE TrackBattle 2019 season data

## this code chunk run once, creates csv files for each round.
# path <- "data-raw/2019-GRIDLIFE-Track-Battle.xlsx"
# 
# #credit for this function: https://readxl.tidyverse.org/articles/articles/readxl-workflows.html, then I changed the csv destination
# read_then_csv <- function(sheet, path) {
#   pathbase <- tools::file_path_sans_ext(basename(path))
#   df <- read_excel(path = path, sheet = sheet)
#   write.csv(df, paste0("data-raw/", pathbase, "-", sheet, ".csv"),
#             quote = FALSE, row.names = FALSE)
#   df
# }
# 
# sheets <- excel_sheets(path)
# TRACKBATTLE <- lapply(excel_sheets(path), read_then_csv, path = path)
# names(TRACKBATTLE) <- sheets

#have to clean the events up separately, because some differ
R1 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R1.csv") %>%
  glimpse()

R1 <- R1 %>%
  select(c("Pos", "Class","Best.Time.of.Event")) %>%
  na.omit() %>%
  rename(Time = Best.Time.of.Event) %>%
  mutate(Event = "R1 Mid Ohio") %>%
  mutate(Drivetrain = "NA") %>%
  glimpse()

R2 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R2.csv") %>%
  glimpse()

R2 <- R2 %>%
  select(c("Pos", "Class","Best.Time.of.Event")) %>%
  na.omit() %>%
  mutate(Event = "R2 Summit Point") %>%
  rename(Time = Best.Time.of.Event) %>%
  separate(col = Class, into = c("Class","Drivetrain"), sep = " - ", extra = "drop") %>%
  glimpse()

R3 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R3.csv") %>%
  glimpse()

R3 <- R3 %>%
  select(c("Pos", "Class","Best.Time.of.Event")) %>%
  na.omit() %>%
  mutate(Event = "R3 Midwest") %>%
  rename(Time = Best.Time.of.Event) %>%
  separate(col = Class, into = c("Class","Drivetrain"), sep = " - ", extra = "drop") %>%
  glimpse()

R4 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R4.csv") %>%
  glimpse()

R4 <- R4 %>%
  select(c("Pos", "Class.w..DT","Full.Time")) %>%
  na.omit() %>%
  mutate(Event = "R4 Autobahn") %>%
  rename(Time = Full.Time) %>%
  rename(Class = Class.w..DT) %>%
  separate(col = Class, into = c("Class","Drivetrain"), sep = " - ", extra = "drop") %>%
  glimpse()

R5 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R5.csv") %>%
  glimpse()

R5 <- R5 %>%
  select(c("Pos", "Class","Best.Time.of.Event")) %>%
  na.omit() %>%
  mutate(Event = "R5 PPIR") %>%
  rename(Time = Best.Time.of.Event) %>%
  separate(col = Class, into = c("Class","Drivetrain"), sep = " - ", extra = "drop") %>%
  glimpse()

R6 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R6.csv") %>%
  glimpse()

R6 <- R6 %>%
  select(c("Pos", "Class","Best.Time.of.Event")) %>%
  na.omit() %>%
  mutate(Event = "R6 South") %>%
  rename(Time = Best.Time.of.Event) %>%
  mutate(Drivetrain = "NA") %>%
  glimpse()


R7 <- read.csv("data-raw/2019-GRIDLIFE-Track-Battle-R7.csv") %>%
  glimpse()

R7 <- R7 %>%
  select(c("Pos", "Class","Best.Time.of.Event")) %>%
  na.omit() %>%
  mutate(Event = "R7 Road America") %>%
  rename(Time = Best.Time.of.Event) %>%
  separate(col = Class, into = c("Class","Drivetrain"), sep = " - ", extra = "drop") %>%
  glimpse()

season_data <- rbind(R1,R2,R3,R4,R5,R6,R7)

#still need to turn time into numerical seconds, not a factor...
saveRDS(season_data, file = "data/2019-GRIDLIFE-TRACKBATTLE.rds")
