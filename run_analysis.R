
## Open required libraries - download en unzip dataset

library(reshape2)

dataset <- "getdata_dataset.zip"

if(!file.exists(dataset))
{
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, dataset, method="curl")
  
}
if(!file.exists("UCI HAR Dataset")){ 
  unzip(dataset)
}


# Load colum and activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Select only the features mean and std winhin the data set as a filter
featuresFilter <- grep(".*mean.*|.*std.*", features[,2])
featuresFilter.names <- features[featuresFilter,2]

## Load the train en test dataset and set collum names 

train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresFilter]
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivity, train)


test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresFilter]
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivity, test)


# Merge the train and the test data to create one data set.
combinedData <- rbind(train, test)
colnames(combinedData) <- c("subject", "activity",featuresFilter.names)
combinedData$activity <- factor(combinedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
combinedData$subject <- as.factor(combinedData$subject)

# Appropriately labels the data set with descriptive variable names.
combinedData.melted <- melt(combinedData, id = c("subject", "activity"))
combinedData.mean <- dcast(combinedData.melted, subject + activity ~ variable, mean)

write.table(combinedData.mean, "tidyset.txt")
