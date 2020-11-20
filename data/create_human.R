hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)
colnames(hd)
colnames(gii)
colnames(hd)[1] <- "HR"
colnames(hd)[2] <- "C"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "LEB"
colnames(hd)[5] <- "EYE"
colnames(hd)[6] <- "MYE"
colnames(hd)[7] <- "GNIC"
colnames(hd)[8] <- "GNIC-HR"
colnames(gii)[1] <- "GR"
colnames(gii)[2] <- "C"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MMR"
colnames(gii)[5] <- "ABR"
colnames(gii)[6] <- "PRP"
colnames(gii)[7] <- "PSEF"
colnames(gii)[8] <- "PSEM"
colnames(gii)[9] <- "LFPRF"
colnames(gii)[10] <- "LFPRM"
library(dplyr)
gii <- mutate(gii, edu2F_edu2M = PSEF / PSEM)
gii <- mutate(gii,  labF_labM = LFPRF / LFPRM)
join_by <- c("C")
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))

colnames(human)
glimpse(human)

write.csv(human, file = 'human')
