### data-import.R --- import raw csv data and combine them into a dataframe
### Authors: Daniel Hennigar, Lauren McNeilly, and Matthew Smith
### Raincoast Conservation Foundation

library(stringr)
library(dplyr)
library(janitor)

files <- paste("./data/", list.files("./data"), sep = "")
transects <- data.frame()

## add csv files to the dataframe
for (path in files) {
    csv <- read.csv(path) %>%
        mutate(site = path %>%
                   str_remove("./data/") %>%
                   str_remove(".csv"))
    transects <- bind_rows(csv, transects)
}

## clean up the resulting dataframe
transects <- transects %>%
    select(-c(Transect, Carex, hd_calc)) %>%
    clean_names()

saveRDS(transects, "./data/combined_transects.RDS")
