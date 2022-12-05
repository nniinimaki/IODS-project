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

#The original data is from: http://hdr.undp.org/en/content/human-development-index-hdi
#variables are:
#"HDI Rank" = Human Development Index Rank
#"Country" = Country name
#"HDI" = Human Development Index
#"GNI" = Gross National Income per capita
#"GNI_minus_HDI" = GNI per capita rank minus HDI rank
#"GII" = Gender Inequality Index
#"GII Rank = Gender Inequality Index Rank
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling
#"Edu.Mean" = Mean years of schooling
#"Mat.Mor" = Maternal mortality ratio
#"Ado.Birth" = Adolescent birth rate
#"Parli.F" = Percetange of female representatives in parliament
#"Edu2.F" = Proportion of females with at least secondary education
#"Edu2.M" = Proportion of males with at least secondary education
#"Labo.F" = Proportion of females in the labour force
#"Labo.M" " Proportion of males in the labour force

#in addition to these, the data contains two variables derived from the original variables
#"Edu2.FM" = Edu2.F / Edu2.M
#"Labo.FM" = Labo2.F / Labo2.M


#Mutate the data: transform the Gross National Income (GNI) variable to numeric (using string manipulation).
library(stringr)

# remove the commas from GNI and print out a numeric version of it
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

#Exclude unneeded variables: keep only the columns matching the following variable names:  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)
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
human <- filter(human,complete.cases(human)) 

dim(human)

#Remove the observations which relate to regions instead of countries. (1 point)

#look at the last 10 observations of human
tail(human, n=10)

# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]

#Define the row names of the data by the country names.
rownames(human) <- human$Country

#remove the Country variable
human <- select(human, -Country)

#The data should now have 155 observations and 8 variables.
dim(human)

#Save the human data in your data folder including the row names. You can overwrite your old ‘human’ data. (1 point)
library(readr)
write_csv(human, "Z:/iods/IODS-project/data/human2.csv")
