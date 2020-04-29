library(rvest)

url <- "http://www.motorsportmemorial.org/query.php?db=ct&q=nationality&n=United%20States"

html_page <- read_html(url)
drivers <- html_nodes(html_page, ".tablelist td:nth-child(2) , .name a")

html_text(drivers[1:50], trim = T)
