library(Rfastp)

# set the working directory to the directory containing the fastq.gz files
setwd("X:/6.Temp/Temp_Tom/Xylella/Illumina/103165-011-012_PD 7383")

# for concatenating all fastq files in a folder into one file
fileR <- list.files(pattern = "*.fastq.gz")

# get the working directory name
wd <- basename(getwd())

# use the working directory name to generate the output file name
out_file <- paste0(wd, ".fastq.gz")

# use this to merge all into one
catfastq(out_file, fileR, append = FALSE, paired = FALSE, shuffled = FALSE)



