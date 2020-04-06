library(tidyverse)
library(cdata)

# 2. information in row names
data("mtcars")

print(mtcars)

#put car name into column
explore <- data.frame(mtcars) %>%
  rownames_to_column("model") %>%
  as_tibble() %>%
  print()

# 3. Pivot and unpivot
stocks <- tibble(
    year   = c( 2015,  2015,  2016,  2016),
    half   = c("1st", "2nd", "1st", "2nd"),
    return = c( 1.88,  0.59,  0.92,  0.17)
    ) %>% 
  print()

stocks_mod <- pivot_to_rowrecs(
  data = stocks,
  columnToTakeKeysFrom = "half",
  columnToTakeValuesFrom = "return",
  rowKeyColumns = "year"
) %>%
  print()

stocks_mod <- unpivot_to_blocks(
  data = stocks_mod,
  nameForNewKeyColumn = "half",
  nameForNewValueColumn = "return",
  columnsToTakeFrom = c('1st', '2nd')
) %>%
  print()

all_equal(stocks, stocks_mod)

# 4. Coordinatize and reshape iris data
flower_wide <- iris

flower_wide <- flower_wide %>%
  mutate("row_id" = 1:150) %>%
  glimpse()

#Transform row-record to row blocks
control_table <- wrapr::build_frame(
  "flower_part",  "measurement", "value"          |
    "Sepal",      "Length",      "Sepal.Length"   |
    "Sepal",      "Width",       "Sepal.Width"    |
    "Petal",      "Length",      "Petal.Length"   |
    "Petal",      "Width",       "Petal.Width"
)

flower_tall <- rowrecs_to_blocks(
  wideTable = flower_wide,
  controlTable = control_table,
  controlTableKeys = c("flower_part", "measurement"),
  columnsToCopy = c("Species", "row_id")
)

flower_wide2 <- blocks_to_rowrecs(
  tallTable = flower_tall,
  controlTable = control_table,
  controlTableKeys = c("flower_part", "measurement"),
  keyColumns = c("Species", "row_id")
)
head(flower_wide2)

all_equal(flower_wide, flower_wide2)