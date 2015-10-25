#### Date: 10/24/2015
library(dplyr)
library(tidyr)
setwd("D:\\Box\\JohnHopkins\\Cleaning Data\\Wk3")

## Download and unzip data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "Project_Data"
download.file(url, file)
unzip(file)

## Train data
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE)

## Test data
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE)

## 4 Add column labels

## Add column names to subject
colnames(subject_train) <- c("subject")
colnames(subject_test) <- c("subject")

## Add column names to x
X_labels <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
X_labels <- X_labels[, 2]
colnames(X_train) <- X_labels
colnames(X_test) <- X_labels

## Add labels to y
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
activity_labels <- activity_labels[, 2]
colnames(y_train) <- c("activity")
colnames(y_test) <- c("activity")


## 1 & 2 Merge train and test data with only Mean & SD variables
Train_data <- cbind(subject_train, y_train, X_train[,grep("mean\\(|std\\(", names(X_train))])
Test_data <- cbind(subject_test, y_test, X_test[,grep("mean\\(|std\\(", names(X_test))])
df <- data.frame(rbind(Train_data, Test_data))


## 3 Label Activities 
df$activity <- as.factor(df$activity)
levels(df$activity) <- activity_labels

## 5 Create tidy data set with mean for Activities
## Make Subject variables factors
df$subject <- as.factor(df$subject)

## Gather data frame
df_gather <- gather(df, variables, values, 3:ncol(df))

## Summarize data frame
summary <- df_gather %>% group_by(subject, activity, variables) %>% summarize(avg=mean(values))
write.table(summary, "summary.txt", row.names=FALSE, sep=",")
