---
#name: siqizhao
#date: 03.11.2020
# file description: 'data wrangling exercises'
#ref: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
---

lrn14<- read.table('http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt', sep='\t', header = TRUE)
dim(lrn14)
str(lrn14)
#comment: This dataset has 183 rows (the observations) and 60 columns (the variables).

lrn14$Attitude
lrn14$Attitude/10

library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))
str(learning2014)

colnames(learning2014)
colnames(learning2014)[2] <- 'age'
colnames(learning2014)[3] <- 'attitude'
colnames(learning2014)[7] <- 'points'

learning2014 <- filter(learning2014, points > 0)
str(learning2014)
head(learning2014)
write.csv(learning2014,file= 'learning2014')
read.csv('learning2014')