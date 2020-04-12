##Check if dplyr is available and install it if it isn't##
if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
##Load plyr##
library(plyr)
##load dplyr##
library(dplyr)
##Download File##
zurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zurl, "dataset.zip")
##Uzip the Zip file##
unzip("dataset.zip")
##create a table with the features.txt file with rows n and feature##
id <- read.table("UCI HAR Dataset/features.txt", col.names=c("n", "feature"), header = FALSE)
##create a table with the activities.txt file##
act <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("No", "Activity"), header = FALSE)
##creating data frames for training data##
str <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
trx <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
try <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
str$Origin <- c("training")
##creating data frames for test data##
ste <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
tex <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
tey <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
ste$Origin <- c("test")
##Merging and naming training and test data#
subdata <- rbind(str, ste)
names(subdata)<-c("subject", "Origin")
xdata <- rbind(trx, tex)
names(xdata)<-id[,-1]
ydata <- rbind(try, tey)
names(ydata) <- c("Activity")
#Melt the data##
datafinal <- cbind(subdata, ydata, xdata)
##erase repeated columns##
datafinal <- datafinal[,!duplicated(colnames(datafinal))]
##Assigning descriptors to activities##
datafinal$Activity <- as.factor(datafinal$Activity)
datafinal$Activity <- revalue(datafinal$Activity, c("1" = "WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4" = "SITTING", "5"="STANDING", "6"="LAYING"))
##Extracts only the measurements on the mean and standard deviation for each measurement##      
tdata <- datafinal %>% select(subject,Origin,Activity,contains("mean"), contains("std"))
##Appropriately labels the data set with descriptive variable names##  
names(tdata) <- gsub("^t", "Time ", names(tdata))
names(tdata) <- gsub("Freq", " Frequency ", names(tdata))
names(tdata) <- gsub("BodyBody", " Body ", names(tdata))
names(tdata) <- gsub("tBody", "Time Body ", names(tdata))
names(tdata) <- gsub("BodyBody", " Body ", names(tdata))
names(tdata) <- gsub("^f", "Frequency ", names(tdata))
names(tdata) <- gsub("Acc", " Accelerometer", names(tdata))
names(tdata) <- gsub("-mean()", " Mean", names(tdata), ignore.case = TRUE)
names(tdata) <- gsub("-std()", " Standard Deviation", names(tdata))
names(tdata) <- gsub("Gyro", " Gyroscope", names(tdata))
names(tdata) <- gsub("Mag", " Magnitude ", names(tdata))
names(tdata) <- gsub("angle", " Angle ", names(tdata))
names(tdata) <- gsub("Mean", " Mean ", names(tdata))
names(tdata) <- gsub("gravity", " Gravity ", names(tdata))
names(tdata) <- gsub("Jerk", " Jerk ", names(tdata), ignore.case = TRUE)
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.##
tdatamean <- tdata %>% group_by(subject, Activity, Origin) %>% summarise_all(list(mean=mean))
write.table(tdatamean, "tdatamean2.txt", row.names = FALSE)
