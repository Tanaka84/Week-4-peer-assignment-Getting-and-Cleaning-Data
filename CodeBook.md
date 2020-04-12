The run_analysis.r file is a script that:

1. **Setup**

	1.1 Checks if the plyr package is installedm if it's not installed it runs install.packages("plyr") 

	1.2 Checks if the dplyr package is installed if it's not installed it runs install.packages("dplyr") 

	1.3 Loads both packages

2. **Download data**

	2.1 Checks if a file name dataset.zip exists in the Working Directory

	2.2 If it doesn't, it proceeds to download the: Human Activity Recognition Using Smartphones Data Set by Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2) from the URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

	2.3 Then, it unzips the data in the working directory creating a new folder called UCI HAR Dataset containing the following:
		
		2.3.1 Files: 
			activity_labels.txt: the code for the activities with columns, the first containing the numeric code and the second containing the nominal data
 
			features.txt: a list of the names of all the measurements
 
			features_info.txt: a description of the list in the previous file. 

			README.txt: Contains a description of what's included in the dataset as well as the source.

		2.3.2 A folder called train containing 3 files: 	
		
			subject_train.txt: numeric ID of the subject
 			
			X_train.txt: The measurements for the training subjects
		
			Y_train.txt: The activities coded as stablished in the activity_labels.txt 

			and a folder called Intertial Signals (which wont be used for the analysis) 
		
		2.3.3 A folder called test containing 3 files: subject_test.txt, X_test.txt, Y_test.txt and a folder with the same content as previously explained in 2.3.2 except that this is for the subjects of the test data.

3. **Assign Data to variables**
	3.1  Creates the following data frames by the read.table function:
	
		3.1.1 id <- from features.txt  561 obs, 2 var
		3.1.2 act <- from activy_labels.txt 6 obs, 2 var  
		3.1.3 str <- from subject_train.txt 7352 obs, 2 var
		3.1.4 trx <- from x_train.txt 7352 obs, 561 var
		3.1.5 try <- from y_train.txt 7352 obs, 1 var

	3.2 Adds a column to the str data frame called Origin with the constant "training" to denote that these are subjects that came from the training sample.
	
	3.3  Creates the following data frames by the read.table function:
		
		3.1.3 ste <- from test.txt  2947 obs, 2 var
		3.1.4 tex <- from x_test.txt 2947 obs, 561 var
		3.1.5 tey <- from y_test.txt 2947 obs, 1 var

	3.4 Adds a column to the ste data frame called Origin with the constant "test" to denote that these are subjects that came from the training sample.

4. **Merges the training and test data into a single dataset**

		4.1 subdata <- created with the rbind function, includes ste and str 10299 obs of 2 var
		4.2 xdata <- created with the rbind function, includes tex and trx 10299 obs, 561 vars
		4.3 ydata <- created with the rbind function
		includes tey and trx. 10299 obs, 1 vars
		4.4 datafinal <- created with the rbind function
		includes subdata, xdata, ydata. 10299 obs, 564 vars
			4.5 Cleans datafinal by eliminating repeated column names 
			4.6 Changes the Activity column to a factor and renames the numeric factors as their descriptor as defined in the activity_labels.txt 10299 obs, 480 vars. (Step 3 of the assignment)

5 **Extracts only the measurements on the mean and standard deviation for each measurement**

	5.1 the Dataframe tdata is created using the plyr package by subsetting datafinal, selecting the columns subject, Activity, Origin and filtering column names that contains the strings "mean" and "std"  10299 obs, 89 vars.

6 Appropriately labels the data set with descriptive variable names

	6.1 All starting t in column names are transformed to Time
	6.2 All Freq in column names are transformed to Frequency
	6.3 All BodyBody in column names are transformed to Body
	6.4 All tBody in column names are transformed to Time Body
	6.5 All starting f in column names are transformed to Frequency
    6.6 All Acc in column names are transformed to Accelerometer
	6.7 All mean in column names are transformed to Mean
	6.8 All std in column names are transformed to Standard Deviation
	6.9 All Gyro in column names are transformed to Gyroscope
	6.10 All Mag in column names are trasformed to Magnitude


7 **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
	
	7.1 tdatamean is created by sumarizing tdata taking the means of each variable for each activity and each subject, after grouped by subject and activity. 180 obs, 89 var.
	7.2 Export tdatamean data to tdatamean.txt
	
		

