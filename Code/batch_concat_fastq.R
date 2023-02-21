library(Rfastp)

# set the working directory to the directory containing the subdirectories
setwd("X:/6.Temp/Temp_Tom/Xylella/Illumina")

# get a list of all subdirectories
subdirs <- dir(recursive = FALSE, full.names = TRUE)

# remove non-directories
subdirs <- subdirs[file.info(subdirs)$isdir]

# loop through each subdirectory and concatenate the fastq files
for (i in 1:length(subdirs)) {
  
  # set the working directory to the current subdirectory
  setwd(subdirs[i])
  
  # get a list of all fastq files in the current subdirectory
  fileR <- list.files(pattern = "*.fastq.gz")
  
  # get the subdirectory name
  wd <- basename(subdirs[i])
  
  # use the subdirectory name to generate the output file name
  out_file <- paste0(wd, ".fastq.gz")
  
  # concatenate the fastq files
  catfastq(out_file, fileR, append = FALSE, paired = FALSE, shuffled = FALSE)
  
  # change back to the parent directory
  setwd("..")
}
