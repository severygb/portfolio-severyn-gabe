#Division Info: http://ppihc.org/divisions-classes-fans/
#data source:http://ppihc.org/wp-content/uploads/2019-Overall-Results.pdf


results <- read_csv(file = "data-raw/2019-Overall-Results.csv",
                    col_names = TRUE,
                    skip = 6,
                    skip_empty_rows = TRUE)

#gets rid of junk data
results <- na.omit(results) #left w/ 85 observations

#Only keep entries with valid, complete course times
results <- filter(results, grepl("\\d\\d:\\d\\d\\.\\d\\d\\d", results$`Total Time`, fixed = FALSE)) #48

glimpse(results)
head(results)
summary(results)
tail(results)
unique(results$`Division/Class`)
summary(as_factor(results$`Division/Class`))