# Niina Niinimäki, 14.11.2022, IODS course Assignment 2

# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the dimensions of the data
dim(lrn14)

# Look at the structure of the data
str(lrn14)

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

# choose the columns to keep
keep_columns <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

# select the 'keep_columns' to create a new dataset
learning2014 <- keep_columns

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# exclude observations where points is zero
learning2014 <- filter(learning2014, points > 0)

# Look at the dimensions and the structure of the learning2014 data
dim(learning2014)

str(learning2014)

#set working directory to IODS-project folder
setwd("Z:/iods/IODS-project")

#access readr library
library(readr)


#save learning2014 as csv-file in the data-folder
write_csv(learning2014, "Z:/iods/IODS-project/data/learning2014.csv")

#read the csv-file that was just saved
read_csv("data/learning2014.csv")

