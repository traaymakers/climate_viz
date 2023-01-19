# Load the base package
library(base)

# Set the working directory to the specified folder
setwd("X:/6.Temp/Temp_Tom/temps")

# Read the csv file
data <- read.csv("table1.csv")

# Set the path to the directory containing the csv file
dir_path <- "X:/6.Temp/Temp_Tom/temps"

# Extract the GenomeScan # and Collection numbers values
genome_scan_numbers <- data$GenomeScan #
collection_numbers <- data$Collection.numbers

# Create the directories using the GenomeScan # and Collection numbers values
for (i in 1:length(genome_scan_numbers)) {
  dir_name <- paste(genome_scan_numbers[i], collection_numbers[i], sep = "_")
  dir.create(file.path(dir_path, dir_name))
}

# 
# library(base)
# 
# # Set the working directory to the specified folder
# setwd("X:/6.Temp/Temp_Tom/RAPT")
# 
# # Read the csv file
# data <- read.csv("table1.csv")
# 
# # Set the path to the directory containing the csv file
# dir_path <- "X:/6.Temp/Temp_Tom/RAPT"
# 
# # Extract the GenomeScan # and Collection numbers values
# genome_scan_numbers <- data$No
# # collection_numbers <- data$Collection.numbers
# 
# # Create the directories using the GenomeScan # and Collection numbers values
# # for (i in 1:length(genome_scan_numbers)) {
# #   dir_name <- paste(genome_scan_numbers[i], collection_numbers[i], sep = "_")
# #   dir.create(file.path(dir_path, dir_name))
# # Create the directories using the No values
# for (i in 1:length(genome_scan_numbers)) {
#   dir_name <- genome_scan_numbers[i]
#   dir.create(file.path(dir_path, dir_name))
#   
# }

