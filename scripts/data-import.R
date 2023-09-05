### data-import.R --- import raw csv data and combine them into a dataframe
### Authors: Daniel Hennigar, Lauren McNeilly, and Matthew Smith
### Raincoast Conservation Foundation

files <- paste("./data/", list.files("./data"), sep = "")

output <- data.frame()

for (path in files) {
    csv <- read.csv(path)
    output <- rbind(csv, output)
}

saveRDS(output, "./data/combined_transects.RDS")
