# Gabe Severyn
# 4/23/2020

# load packages
library("tidyverse")
library("lubridate")
library("HistData")
library("cdata")

glimpse(airquality)

df <- airquality %>% 
  mutate(Year = 1973L) %>%  #add a year column, from the help page 
  mutate(meas_date = make_date(year = Year, month = Month, day = Day)) %>% #change to Date class
  glimpse()

class(df$meas_date)

ggplot(df, aes(x = meas_date, y = Ozone)) + 
  geom_line() + 
  geom_point() 
#missing data is not connected by line, great for highlighting missing data

#example with time series and decimal dates
co2_ftp  <- "ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt"
co2_file <- "data/noaa_co2.txt"

# update file if more than 4 weeks since last download
if (!file.exists(co2_file) | now() > file.mtime(co2_file) + weeks(4)) {
  download.file(co2_ftp, co2_file)
}

co2 <- read.table(co2_file)
names(co2) <- c("year", "month", "decimal_date", "average",
                "interpolated", "trend", "ndays") 
glimpse(co2)

#change placeholder data to specific NA type
co2 <- co2 %>% 
  mutate(average = if_else(average < -90, NA_real_, average)) %>%
  mutate(ndays = if_else(ndays == -1, NA_integer_, ndays))

#change decimal date to POSIXct then Date
co2 <- co2 %>% 
  mutate(date_meas = date_decimal(decimal_date)) %>% 
  mutate(date_meas = as_date(date_meas)) %>% 
  glimpse()
class(co2$date_meas)

ggplot(co2, aes(x = date_meas, y = interpolated)) +
  geom_line() +
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  facet_wrap(vars(month))

co2 <- co2 %>% 
  mutate(month_abbrev = month.abb[month]) %>% #replace month numbers with abbreviations
  mutate(month_abbrev = factor(month_abbrev, levels = month.abb)) %>% #make it a factor
  glimpse()

ggplot(co2, aes(x = date_meas, y = interpolated)) +
  geom_line() +
  scale_x_date(date_breaks = "10 years", date_labels = "%y") +
  facet_wrap(vars(month_abbrev))

#make a prettier plot, not a more useful one, just a prettier one
ggplot(co2, aes(x = date_meas, y = interpolated, group = month_abbrev, color = month_abbrev)) +
  geom_line() +
  scale_x_date(date_breaks = "5 years", date_labels = "%Y") +
  guides(color = guide_legend(reverse = FALSE)) 

# panels with free y scales. useful to show different variables with their own scale
data(Nightingale, package = "HistData")
head(Nightingale)

these_names <- c("Disease.rate", "Wounds.rate", "Other.rate")
crimea <- unpivot_to_blocks( #reshape date so all rates are in one column
  data                  = Nightingale,
  nameForNewKeyColumn   = "cause",
  nameForNewValueColumn = "rate",
  columnsToTakeFrom     = these_names
) %>% 
  glimpse()

#plotted with same y scale allows for visual comparison. shows disease is much greater than others
ggplot(data = crimea, mapping = aes(x = Date, y = rate)) + 
  geom_line() +
  facet_wrap(vars(cause), ncol = 1) +
  scale_x_date(date_breaks = "4 months", date_labels = "%b %Y")

#plotted with free y scale shows each variable and it's own detail
ggplot(data = crimea, mapping = aes(x = Date, y = rate)) + 
  geom_line() +
  facet_wrap(vars(cause), ncol = 1, scales = "free_y") +
  scale_x_date(date_breaks = "4 months", date_labels = "%b %Y")
