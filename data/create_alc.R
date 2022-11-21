# Niina Niinimäki
# 21.11.2022
# IODS course Assignment 3
# Data source: https://archive.ics.uci.edu/ml/datasets/Student+Performance

# Read student-mat.csv and student-por.csv into R from the data folder.

math <- read.csv("Z:/iods/IODS-project/data/student-mat.csv", sep=";")

por <- read.csv("Z:/iods/IODS-project/data/student-por.csv", sep=";")

# Explore the dimensions of the data
dim(math)
dim(por)

# Explore the structure of the data
str(math)
str(por)

# Join the two data sets using all other variables than "failures", "paid", "absences", "G1", "G2", "G3" as (student) identifiers.
# Keep only the students present in both data sets.
# Explore the structure and dimensions of the joined data.

# access the dplyr package
library(dplyr)

# the columns that vary in the two data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols)

# look at the column names of the joined data set
colnames(math_por)

# glimpse at the joined data set

glimpse(math_por)

#Get rid of the duplicate records in the joined data set.

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# print out the columns not used for joining (those that varied in the two data sets)
free_cols

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data

glimpse(alc)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse at the joined and modified data to make sure everything is in order
glimpse(alc)


# Save the joined and modified data set to the ‘data’ folder

library(readr)
write_csv(alc, "Z:/iods/IODS-project/data/alc.csv")

