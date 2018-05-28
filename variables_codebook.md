Variables 
=========

Variables selected are based on an extraction from original features measuring mean and standard deviation values. When original features belong to time signals, t has been replaced by "time" and when features belong to frequency signals, f has been replaced by "frequency". You can read about original features on both files: features_info.txt and features.txt

Signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ', used to denote 3-axial signals in the X, Y and Z directions has been replaced by "XYZ" removing all special characters like "-"

tBodyAccXYZ
tGravityAccXYZ
tBodyAccJerkXYZ
tBodyGyroXYZ
tBodyGyroJerkXYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAccXYZ
fBodyAccJerkXYZ
fBodyGyroXYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Extracted variables from these signals are: 

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
