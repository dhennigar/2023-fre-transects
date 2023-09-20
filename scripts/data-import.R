### data-import.R --- import raw csv data and combine them into a dataframe
### Authors: Daniel Hennigar, Lauren McNeilly, and Matthew Smith
### Raincoast Conservation Foundation

library(stringr)
library(dplyr)
library(janitor)

## Transect data import and cleaning

transect_files <- paste("./data/transects/", list.files("./data/transects"), sep = "")
transects <- data.frame()

## add csv files to the dataframe
for (path in transect_files) {
    csv <- read.csv(path) %>%
        mutate(site = path %>%
                   str_remove("./data/transects/") %>%
                   str_remove(".csv"))
    transects <- bind_rows(csv, transects)
}

## clean up the resulting dataframe
transects <- transects %>%
    select(-any_of(c("Transect", "Carex", "hd_calc"))) %>%
    clean_names()

saveRDS(transects, "./data/combined_transects.RDS")


## Floristic data import and cleaning

flora_raw <- read.csv("./data/species_lists/floristic_lists.csv")

flora <- flora_raw %>%
    clean_names() %>%
    select(c(site_name, species, low_marsh_only))

saveRDS(flora, "./data/floristic_surveys.RDS")


## Soil data import and cleaning

soil_raw <- read.csv("./data/soil_cores/soil_cores.csv")

soil <- soil_raw # clean up goes here

saveRDS(soil, "./data/soil_cores.RDS")

