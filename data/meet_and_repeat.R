#Niina Niinimäki
#9.12.2022
#IODS-course, Assignment 6

#Load the data sets (BPRS and RATS) into R (in wide form)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t", header=TRUE)

#Take a look at the data sets: check their variable names
names(BPRS)
names(RATS)

#view the data contents and structures
str(BPRS)
str(RATS)

#create some brief summaries of the variables (0-1 p)
summary(BPRS)
summary(RATS)

#It doesn't make sense to look at the summaries of the wide data.
#For example the variables "Treatment" and "Subject" in BRRS are categorial variables referring to treatment 1 or 2 and the test subjects (1-20 in each group), so there is no point in taking means/medians/min/max etc. from them.
#The variables "week0" - "week8" refers to bprs values in each week and means/medians/min/max are calculated from all observations regardless of treatment group.
#Same applies to RATS data: "Group" and "ID" are categorial, "WD1" - "WD64" refers to weight in measurement days 1 - 64.
#So no point examining the data further in wide form.

#Convert the categorical variables (treatment and subject in BPRS and ID and Group in RATS) of both data sets to factors. (1 point)
library(dplyr)
library(tidyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. (1 point)
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3,4))) %>%
  arrange(Time)

#Check the variable names:
names(BPRSL)
names(RATSL)

#view the data contents and structures:
str(BPRSL)
str(RATSL)

#create some brief summaries of the variables. (2 points)
summary(BPRSL)
summary(RATSL)

#Now both datasets are in long form. There are 5 columns and 360 rows in BPRSL and 5 columns and 176 rows in RATSL
#Categorical variables are now presented correctly as categorial in summary.
#The variables "week0" - "week8" in BPRS are now modified into two variables: "Week" and "bprs".
#Variables "WD1"-"WD64" in RATS are now modified into two variables "Time" and "Weight".
#Now it is possible to examine the variation of variables "bprs" and "Weight" over time.
#The variables "weeks" in BPRSL and "WD" in RATSL could be removed because they are character variables and not needed anymore. I'm going to leave them, though, because there's no harm in having them in the dataset.

#I'm saving the datasets in my data-folder.
library(readr)
write_csv(BPRSL, "Z:/iods/IODS-project/data/BPRSL.csv")
write_csv(RATSL, "Z:/iods/IODS-project/data/RATSL.csv")


