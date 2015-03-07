# convert CSV to Citeproc JSON

library(jsonlite)
library(lubridate)

# convert iso8601 dates into Citeproc date-parts
date_parts <- function(x) {
  date <- ymd(x[2])
  c("date-parts" = list(list(c(year(date), month(date), day(date)))))
}

packages <- read.csv("github_repos.csv", encoding = "UTF8", sep = ",", stringsAsFactors=FALSE)
names(packages)[names(packages)=="url"] <- "URL"
packages$issued <- apply(packages, 1, date_parts)
packages$type <- "dataset"
packages <- subset(packages, select = c(URL, issued, title, type))
packages_json <- toJSON(packages, pretty=TRUE)
write(packages_json, file = "github_repos.json")
