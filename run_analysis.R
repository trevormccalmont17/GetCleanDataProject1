# You should create one R script called run_analysis.R that does the following:

# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for
# each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy
# data set with the average of each variable for each activity and each subject.

# Unzip project folder

unzip("getdata-projectfiles-UCI HAR Dataset.zip")

# Read in the data

xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt", colClasses = c("character"))

# 1. Merge the Test and Train data sets to create one data set

dataTrain <- cbind(subjectTrain, yTrain, xTrain)
dataTest <- cbind(subjectTest, yTest, xTest)
dataFull <- rbind(dataTrain, dataTest)

# Add labels to columns of the full data set

columnLabels <- features[,2]
columnLabels <- c("ActivityID", "Subject", columnLabels)
names(dataFull) <- columnLabels

# 2. Extract only the measurements on the mean and standard deviation

# Use grep to find columns with "mean" or "std" in the name
# Create a subset of the full train and test data set using only the "mean" or "std" columns

meanStdDevNames <- grep("-(mean|std)\\(\\)", features[,2])
dataFull <- dataFull[meanStdDevNames]

# 3. Use descriptive activity names to name the activities in the data set
# Merge the activity labels and their corresponding IDs with the full data set
# Rearrange the columns so Activity and ActivityID are adjacent

names(activityLabels) = c("ActivityID", "Activity")
dataFull <- merge(dataFull, activityLabels, by = "ActivityID", all = TRUE)
dataFull <- dataFull[c(1,67,2:66)]

# 4. Change the original column names to descriptive variable names

columnLabels <- columnLabels[meanStdDevNames]
columnLabels <- gsub("\\(|\\)", "", columnLabels)
columnLabels <- gsub("Acc", "Acceleration", columnLabels)
columnLabels <- gsub("Mag", "Magnitude", columnLabels)
columnLabels <- gsub("std", "StdDev", columnLabels)
columnLabels <- gsub("^t", "Time", columnLabels)
columnLabels <- gsub("^f", "Freq", columnLabels)
columnLabels[length(columnLabels)+1] <- "Activity"
columnLabels <- columnLabels[c(1,67,2:66)]
names(dataFull) <- columnLabels

# 5. Create new tidy data set with the average of each variable for each activity and subject

tidyFull <- aggregate(dataFull[4:67], list(dataFull$Subject, dataFull$Activity), mean)
names(tidyFull)[1:2] = c("Subject", "Activity")
write.table(tidyFull, "tidyData.txt", row.names=FALSE)