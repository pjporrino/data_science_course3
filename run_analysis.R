## Please locate directory "UCI HAR Dataset" in your working directory,
## doing so, the script will be able to access data in ./UCI HAR Dataset/

## Checks if dataset is located in working directory
if (!file.exists("./UCI HAR Dataset/")){
  print("Please, place original dataset folder UCI HAR Dataset in your working directory and try again");
  break}

library(dplyr)

## Reads information and load it in workspace
x_train = read.table("./UCI HAR Dataset/train/X_train.txt")
y_train = read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test = read.table("./UCI HAR Dataset/test/X_test.txt")
y_test = read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")

## Gives descriptive names to activities and subjects
names(y_train) = "activity"
names(y_test) = "activity"
names(subject_train) = "subject"
names(subject_test) = "subject"

## Reads names of variables specified in features.txt and it applies to x data
features_names = read.table("./UCI HAR Dataset/features.txt")
names(x_train) = features_names$V2
names(x_test) = features_names$V2

## Creates test and train datasets
test = cbind(subject_test, y_test, x_test )
train = cbind(subject_train, y_train, x_train)

## Creates an unique dataset containing all observations
alldata = rbind(test, train)

## Removes special characters from names and provides specification of time and frequency
names(alldata) = gsub("\\-|\\,|\\(|\\)|\\.", "" , names(alldata))
names(alldata) = gsub("^t", "time", names(alldata))
names(alldata) = gsub("^f", "freq", names(alldata))

## Replaces activity id with names
alldata$activity = as.character(alldata$activity)
l = c("1","2","3","4","5","6")
v = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
for (i in 1:6){alldata$activity = gsub(l[i], v[i], alldata$activity)}

## Subsets dataset with only columns having mean or std (activity and subject too) and store it in a variable called subset
k = grep("mean|std|activity|subject", names(alldata))
subset = alldata[,k]

## Subset grouped by subject and activity
subsetgrouped = group_by_at(subset, vars(subject, activity))

## Summarises on all variables mean
subsetAvg = summarise_at(subsetgrouped,
                         vars(timeBodyAccmeanX:freqBodyBodyGyroJerkMagmeanFreq), mean)

print(subsetAvg)








