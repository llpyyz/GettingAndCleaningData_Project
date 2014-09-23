README.md for Getting and Cleaning Data Project
===============================================

Author : David Schonberger
==========================

Date created: 9/19/2014
=======================

R Script to create tidy data set from raw data: run_analysis.r
--------------------------------------------------------------

How R script run_analysis.r works:
----------------------------------

###Note: I must apologize for a mistake I made on this assignment. s you will see, I produced a tidy data set with **more** information than was requested. The assignment called for finding just the average (mean) of all features involving either the mean or standard deviation of some measured variable; 66 features by my count. My tidy data set actually provides both the mean **and** the standard deviation of those 66 features. And so my process includes several extra steps beyond what was required.

###Assumes raw data downloaded from [this site](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

###Assumes data unzipped to working directory, and .r script is also in this directory.

####Unzipping creates the directory 'UCI HAR Dataset' and the following files and sub-folders useful for this project:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

###This script does the following, as per the course website. 
####See .r script for more extensive comments on specific steps taken.

##1. Merge training and test data sets

* Read in train and test sets; these are the two primary data frames initially

* Read in feature names

* Read in and append subject numbers to test and train data frames

* Read in and append activity numbers to test and train data frames

* Read in data that maps activity numbers to activities names

* Merge activity number/name data with test and train data frames

* Clean up/rename variable names as appropriate

* This process results in an untidy data set of 10299 observations of 563 variables
 

##2. Extract only measurements dealing with mean and standard deviation

* Use grep to identify the 66 features that contain either '-mean()' or '-std()' in their name; extract this data

* This results in an untidy data set of 10299 observations of 68 variables


##3. Create appropriate names for activities in data set

* Done in Step 1 above


##4. Label the data set with appropriate, descriptive names

* Initiated in Step 1 above

* Further cleaning of extracted feature names:

 - remove hyphens
 
 - remove parentheses
 
 - convert lower case 'mean' and 'std' to 'Mean' and 'Std', for readability


##5. Create a tidy data with the mean of each variable for each activity and each subject

* Follows guidelines in Hadley Wickham's paper, "Tidy Data" (http://vita.had.co.nz/papers/tidy-data.pdf):

 - Melt (rotate) the 66 features into a single column, using *subjectnumber* and *activity* as id variables.

 - Apply dcast to get data frame of means of each feature; append "VarMean" to each feature name. Resulting data frame: 180 obs of 68 vars

 - Apply dcast to get data frame of standard deviations of each feature; append "VarSD"  to each feature name.  Resulting data frame: 180 obs of 68 vars
 
 - Merge resulting 180-by-68 data frames into an untidy 'short and wide' data frame.

 - Melt 132 renamed features into one column
 
 - Rename generic *variable* and *value* columns to more descriptive names, *summaryvarname* and *summaryvarvalue*
 
 - We now have a 'long and tall' tidy final data frame with 30 * 6 * 132 = 23760 rows
 
 - Write tidy data to file name "means_stddevs_HARData_tidy.txt" in working directory
 
 - Each row of tidy set is an obs of 4 variables; see CodeBook.md for more details on these variables:
 
 1) *subjectnumber*
 
 2) *activity*
 
 3) *summaryvarname*  
 
 4) *summaryvarvalue*
