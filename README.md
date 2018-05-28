# data_science_course3
Peer-Graded Assignment Course 3 Data Science Specialization

The script follows intructions given with just a light change: instead of extracting subset and preparing then data, first data is cleaned and after that the subset is processed.

  1 - Check if raw data is present in working directory:

    if (!file.exists("./UCI HAR Dataset/")){
        print("Please, place original dataset folder UCI HAR Dataset in your working directory and try again");
        break}
  
  2 - Load dplyr package, needed for data process:

    library(dplyr)

  3 - Read data from different files and loads it into workspace:
  
    x_train = read.table("./UCI HAR Dataset/train/X_train.txt")
    y_train = read.table("./UCI HAR Dataset/train/Y_train.txt")
    subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")

    x_test = read.table("./UCI HAR Dataset/test/X_test.txt")
    y_test = read.table("./UCI HAR Dataset/test/Y_test.txt")
    subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  4 - Name activities and subjects in their objects:
  
    names(y_train) = "activity"
    names(y_test) = "activity"
    names(subject_train) = "subject"
    names(subject_test) = "subject"
  
  5 - In order to provide descriptive names to columns, script reads names from features.txt and it applies them to x data:
  
    features_names = read.table("./UCI HAR Dataset/features.txt")
    names(x_train) = features_names$V2
    names(x_test) = features_names$V2
  
  6 - Create train and test datasets using cbind adding subject and activity columns and then an unique dataset combining
      both by using rbind:
      
    test = cbind(subject_test, y_test, x_test )
    train = cbind(subject_train, y_train, x_train)

    alldata = rbind(test, train)
    
  7 - Remove special characters from names and provides specification of time and frequency:
  
    names(alldata) = gsub("\\-|\\,|\\(|\\)|\\.", "" , names(alldata))
    names(alldata) = gsub("^t", "time", names(alldata))
    names(alldata) = gsub("^f", "freq", names(alldata))
    
  8 - Replaces activity id with names:
  
    alldata$activity = as.character(alldata$activity)
    l = c("1","2","3","4","5","6")
    v = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
    for (i in 1:6){alldata$activity = gsub(l[i], v[i], alldata$activity)}
    
  9 - We have a complete dataset with valid and descriptive columns name. Now is when we are going to extract information
      based in instructions. First, we use grep() for getting only columns with specified expressions (plus subject and
      activity columns):
  
    k = grep("mean|std|activity|subject", names(alldata))
    subset = alldata[,k]
  
  10 - Group data by subject and activity:
  
    subsetgrouped = group_by_at(subset, vars(subject, activity))
      
  11 - Finally, we use summarise_at() function for getting the mean value for every variable on pairs subject-activity:
  
    subsetAvg = summarise_at(subsetgrouped,
                             vars(timeBodyAccmeanX:freqBodyBodyGyroJerkMagmeanFreq), mean)

    print(subsetAvg)
  
  
