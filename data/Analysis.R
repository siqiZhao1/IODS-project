students2014 <- read.table('http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt', sep = ',', header = TRUE)
dim(students2014)
str(students2014)
# This data files includes 166 rows (observations) and 7 columns(variables), which means there are 7 kinds of index for 166 students.The variables includes gender, age, attuitude, deep, dtra, surf, and points.

library(ggplot2)
p1 <- ggplot(students2014, aes(x=attitude, y=points, col=gender))
p2 <- p1 + geom_point()
p2
p3 <- p2+geom_smooth(method = 'lm')
p4 <- p3+ggtitle('attitude of students versus exam points')
p4

pairs(students2014[-1])

library(GGally)
library(ggplot2)

p <- ggpairs(students2014, mapping=aes(col=gender, alpha=0.3),lowe=list(combo=wrap('facethist', bins=20)))
p
# There is an extremely significant positive relationship between attitude of students and points.For male,age is negative related with points.


my_model1 <- lm (points ~ attitude + stra + surf, data = students2014)
summary(my_model1)

my_model2 <- lm (points ~ attitude + stra, data = students2014)
summary(my_model2)
# In the first regression model, points as the target varable together with attitude, stra and surf as explantory variables, the model can be used because the P value is less than 0.001(extremely significant) even though there is no significantly relationships between stra, surf and points.
#Model2 can explain the 20.74% changes of points.
par(mfrow=c(2,2))
plot(my_model2, which=c(1,2,5))

# The data is mostly Gaussian distribution, according to the linear qq plots. The model is sensible based on these three plots.
