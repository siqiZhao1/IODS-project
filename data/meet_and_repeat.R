library(dplyr) 
library(corrplot)
library(GGally)
library(FactoMineR)
library(factoextra)
library(ggplot2)
library(tidyr)
library(MASS)
library(readr)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  =" ", header = T)

summary(BPRS)
str(BPRS)
summary(RATS)
str(RATS)


BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3, 4))) 


names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)

write.csv(BPRSL, file = "data/BPRSL.csv")
write.csv(RATSL, file = "data/RATSL.csv")
