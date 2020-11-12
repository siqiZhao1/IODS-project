alc<- read.table('http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/alc.txt', sep=',', header = TRUE)
colnames(alc)
dim(alc)
str(alc)

m1 <- glm(high_use ~ failures, data = alc, family = "binomial")
m2<-glm(high_use ~ absences, data = alc, family = "binomial")
m3<-glm(high_use ~ traveltime, data = alc, family = "binomial")
m4<-glm(high_use ~ activities, data = alc, family = "binomial")
summary(m1)
summary(m2)
summary(m3)
summary(m4)

library(ggplot2)
library(tidyr)
library(dplyr)
gather(alc) %>% glimpse
gather(alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()
g1 <- ggplot(alc, aes(x = high_use, y = failures, col = sex))
g1 + geom_boxplot() + ylab("failures")
g2 <- ggplot(alc, aes(x = high_use, y = absences, col = sex))
g2 + geom_boxplot() + ggtitle("Student absences by alcohol consumption and sex")

m5 <- glm(high_use ~ failures+absences+traveltime, data = alc, family = "binomial")
summary(m5)
coef(m5)
OR <- coef(m5) %>% exp
CI <- confint(m5) %>% exp
cbind(OR, CI)

probabilities <- predict(m5, type = "response")
alc <- mutate(alc, probability = probabilities)
alc <- mutate(alc, prediction = probability > 0.5)
select(alc, failures, absences, traveltime, high_use, probability, prediction) %>% tail(10)
table(high_use = alc$high_use, prediction = alc$prediction)

g <- ggplot(alc, aes(x = probability, y = high_use, col = prediction))
g + geom_point()
table(high_use = alc$high_use, prediction = alc$prediction) %>% prop.table %>% addmargins

loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
library(boot)
cv <- cv.glm(data = alc, cost = loss_func, glmfit = m5, K = 10)
cv$delta[1]

m6 <- glm(high_use ~ failures+absences+traveltime+higher+sex, data = alc, family = "binomial")
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
cv <- cv.glm(data = alc, cost = loss_func, glmfit = m6, K = 10)
cv$delta[1]

m7 <- glm(high_use ~ failures+absences+traveltime+sex, data = alc, family = "binomial")
loss_func <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}

cv <- cv.glm(data = alc, cost = loss_func, glmfit = m7, K = 10)
cv$delta[1]

summary(m7)
coef(m7)