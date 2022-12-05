#Niina Niinimäki
#5.12.2022
#IODS course Assignment 5: Data wrangling of the human dataset continues

#Load the ‘human’ data into R.
library(readr)
human <- read_csv("Z:/iods/IODS-project/data/human.csv")

#Explore the structure and the dimensions of the data and describe the dataset briefly, assuming the reader has no previous knowledge of it (this is now close to the reality, since you have named the variables yourself). (0-1 point)
#Structure of the dataframe
str(human)
#Dimension of the dataframe
dim(human)
#names of the variables
names(human)

#Mutate the data: transform the Gross National Income (GNI) variable to numeric (using string manipulation).
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

#Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)

library(dplyr)
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

#Remove all rows with missing values (1 point).

# print out a completeness indicator of the 'human' data, FALSE=value missing somewhere in the row
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human,complete.cases(human)) 

dim(human_)


#Remove the observations which relate to regions instead of countries. (1 point)# look at the last 10 observations of human
tail(human_, n=10)

# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

#Define the row names of the data by the country names.
rownames(human_) <- human_$Country

#remove the Country variable
human_ <- select(human, -Country)

#The data should now have 155 observations and 8 variables.
dim(human_)

#Save the human data in your data folder including the row names. You can overwrite your old ‘human’ data. (1 point)

library(readr)
write_csv(human_, "Z:/iods/IODS-project/data/human2.csv")