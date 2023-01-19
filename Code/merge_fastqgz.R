library(Rfastp)

# set the working directory to the directory containing the fastq.gz files
setwd("X:/6.Temp/Temp_Tom/103943-025-032_PD 7435")

# list all of the fastq.gz files in the directory separated by R1 and R3
fileR1 <- list.files(pattern = "*R1.fastq.gz")
fileR3 <- list.files(pattern = "*R3.fastq.gz")

# for concatenating all fastq files in a folder into one file
# fileR <- list.files(pattern = "*.fastq.gz")

catfastq("103943-025-032.R1.fastq.gz", fileR1, append = FALSE, paired = FALSE, shuffled = FALSE)
catfastq("103943-025-032.R3.fastq.gz", fileR3, append = FALSE, paired = FALSE, shuffled = FALSE)

# use this to merge all into one
# catfastq("103943-025-043.fastq.gz", fileR, append = FALSE, paired = FALSE, shuffled = FALSE)


# # initialize an empty list to store the sequences
# all_seqs <- list()
# 
# # iterate over the files and read in the sequences using readFastq()
# for (file in files) {
#   seqs <- readFastq(file)
#   all_seqs <- c(all_seqs, seqs)
# }
# 
# 
# pe001_read1 <- system.file("extdata","splited_001_R1.fastq.gz",
#                            package="Rfastp")
# pe002_read1 <- system.file("extdata","splited_002_R1.fastq.gz",
#                            package="Rfastp")
# pe003_read1 <- system.file("extdata","splited_003_R1.fastq.gz",
#                            package="Rfastp")
# pe004_read1 <- system.file("extdata","splited_004_R1.fastq.gz",
#                            package="Rfastp")
# 
# pe001_read2 <- system.file("extdata","splited_001_R2.fastq.gz",
#                            package="Rfastp")
# pe002_read2 <- system.file("extdata","splited_002_R2.fastq.gz",
#                            package="Rfastp")
# pe003_read2 <- system.file("extdata","splited_003_R2.fastq.gz",
#                            package="Rfastp")
# pe004_read2 <- system.file("extdata","splited_004_R2.fastq.gz",
#                            package="Rfastp")
# 
# allR1 <- c(pe001_read1, pe002_read1, pe003_read1, pe004_read1)
# allR2 <- c(pe001_read2, pe002_read2, pe003_read2, pe004_read2)
# 
# allreads <- c(allR1, allR2)
# allreads_shuffled <- c(pe001_read1, pe001_read2, pe002_read1, pe002_read2,
#                        pe003_read1, pe003_read2, pe004_read1, pe004_read2)
# 
# outputPrefix <- tempfile(tmpdir = tempdir())
# # a normal concatenation for single-end libraries.
# 
# catfastq(output = paste0(outputPrefix, "_R1.fastq.gz"), inputFiles = allR1)
# 
# # a normal concatenation for paired-end libraries.
# 
# catfastq(output = paste0(outputPrefix, "merged_paired"),
#          inputFiles = allreads, paired=TRUE)
# 
# # Append to exist files (paired-end)
# 
# catfastq(output=paste0(outputPrefix,"append_paired"), inputFiles=allreads,
#          append=TRUE, paired=TRUE)
# 
# # Input paired-end files are shuffled.
# 
# catfastq(output=paste0(outputPrefix,"_shuffled_paired"),
#          inputFiles=allreads_shuffled, paired=TRUE, shuffled=TRUE)
