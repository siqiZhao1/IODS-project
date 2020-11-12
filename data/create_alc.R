name: siqizhao
file description: logistic regression exercises
reference : https://archive.ics.uci.edu/ml/datasets/Student+Performance


math <- read.csv('Z:/Documents/Custom Office Templates/IODS-project/data/student-mat.csv', header = TRUE, sep = ';')
str(math)
dim(math)
por <- read.csv('Z:/Documents/Custom Office Templates/IODS-project/data/student-por.csv', header = TRUE, sep = ';' )
str(por)
dim(por)

library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))
str(math_por)
dim(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the new combined data
glimpse(alc)

write.csv(alc, file = 'alc')
read.csv('alc', header = TRUE, sep = ';')

