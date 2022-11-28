#Niina Niinimäki
#28.11.2022
#IODS course Assignment 4: Data wrangling for next weeks data

#Read in the “Human development” and “Gender inequality” data sets.
library(readr)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


#Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

#Look at the meta files and rename the variables with (shorter) descriptive names.
#metafiles: https://github.com/KimmoVehkalahti/Helsinki-Open-Data-Science/blob/master/datasets/human_meta.txt

library(tidyverse)
hd <- hd %>% rename("HDI" = "Human Development Index (HDI)",
                    "Life.Exp" = "Life Expectancy at Birth",
                    "Edu.Exp" = "Expected Years of Education",
                    "Edu.Mean" = "Mean Years of Education",
                    "GNI" = "Gross National Income (GNI) per Capita",
                    "GNI_minus_HDI" = "GNI per Capita Rank Minus HDI Rank")
  

gii <- gii %>% rename("GII" = "Gender Inequality Index (GII)",
                      "Mat.Mor" = "Maternal Mortality Ratio",
                      "Ado.Birth" = "Adolescent Birth Rate",
                      "Parli.F" = "Percent Representation in Parliament",
                      "Edu2.F" = "Population with Secondary Education (Female)",
                      "Edu2.M" = "Population with Secondary Education (Male)",
                      "Labo.F" = "Labour Force Participation Rate (Female)",
                      "Labo.M" = "Labour Force Participation Rate (Male)")

#Mutate the “Gender inequality” data and create two new variables.

#The first new variable is the ratio of Female and Male populations with secondary education in each country.(i.e. edu2F / edu2M).
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)

#The second new variable should be the ratio of labor force participation of females and males in each country (i.e. labF / labM).
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)

glimpse(gii)

#Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join).
human <- inner_join(hd, gii, by = "Country")

#The joined data should have 195 observations and 19 variables.
dim(human)

#Call the new joined data "human" and save it in your data folder.

library(readr)
write_csv(human, "Z:/iods/IODS-project/data/human.csv")
