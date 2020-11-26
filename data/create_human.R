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


write.csv(human, file = 'human')


library(stringr)
str(human$GNI)
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric


keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))

str(human_)

write.csv(human_, file = 'human_')


