####################################
#Getting and Cleaning Data - Project
#Author: David Schonberger
#Created: 9/15/2014
#Last Modified: 9/19/2014
####################################

# Human Activity Recognition database built from the recordings of 30 subjects 
#performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
#See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#This script assumes you have downloaded and unzipped the data to your working directory
#which creates the directory 'UCI HAR Dataset' and within it the following files and sub-folders:

#- 'README.txt'
#- 'features_info.txt': Shows information about the variables used on the feature vector.
#- 'features.txt': List of all features.
#- 'activity_labels.txt': Links the class labels with their activity name.
#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels.
#- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
#- 'test/X_test.txt': Test set.
#- 'test/y_test.txt': Test labels.
#- 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

#The following files are available for the train and test data. Their descriptions are equivalent. 

#- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
#- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
#      Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
#- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
#- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

#
#In broad strokes, this script does the following (as requirements given on class web page):
#
#1. Merges training and test data sets
#2. Extracts mean and std dev of each measurement
#3. Creates appropriate names for activities in data set
#4. Labels the data set with appropriate, descriptive names
#5. Creates a tidy data with the mean of each variable for each activity and each subject

#
#More detailed description of steps taken:
#
#1. Read data from X_train.txt and X_test.txt into two dfs, X_train and X_test
#2. Read 561 feature names from features.txt into a df 
#3. Make dats from step 2 these the col names of X_train and X_test
#4. Read data from subject_train.txt and subject_test.txt into dfs
#5. Append data from step 4 to appropriate df X_train/X_test
#6. Read data from y_train.txt and y_test.txt into dfs
#7. Append data from step 6 to appropriate df X_train/X_test
#8. Read data from activity_labels.txt into a df
#9. Merge this data with X_train and X_test.
#10. Remove columns of activity numbers from X_train and X_test
#11. Combine X_train and X_test into mergedDataAll, a big df of 10299 obs of 563 vars (subject #, activity name, and 561 features)
#12. Use grep to identify names of 66 features that include the phrase '-mean()' or '-std()'
#13. Extract subset of mergedDataAll for these 66 features
#14. Clean up names of features to change '-mean()' to 'Mean' and '-std()' to 'Std'
#15. Melt (rotate) the 66 features into a single column, using subjectnumber and activity as id variables.
#16. Apply dcast twice dfs with the mean and standard deviation of each feature for each combination of subjectnumber and activity. 
#17. For dfs in step 16, append either "VarMean" or "VarStd" to end of each feature name.
#18. Merge the two dfs from 17 into a single 'short and wide' data frame with 134 columns
#19. Melt (rotate) the 132 renamed feature column into a single column, yielding a 'long and tall' data set with four variables.
#20. Rename the generic 'variable' and 'value' columns and write the tidy data set out to file "means_stddevs_HARData_tidy.txt".

library(reshape2)
basePath <- "./UCI HAR Dataset"

############################################
############################################
#Step 1 - Merges training and test data sets
############################################
############################################

##############################################
#Step 1a - Read in and prep training data set:
##############################################

#Read in X_train.txt
fname <- "/train/X_train.txt"
X_train <- read.table(paste0(basePath, fname), sep = "")

#Read in feature names, rename X_train vars with the feature names
#Note: several features mistakenly contain the phrase 'BodyBody' and
#these are cleaned up to remove the extra 'Body'
fname <- "/features.txt"
featureData <- read.table(paste0(basePath, fname), sep = "")
featureNames <- as.character(featureData[,2])
featureNames <- sub("BodyBody", "Body", featureNames)
names(X_train) <- featureNames

#Read in numbers for subjects assigned to training set, rename
fname <- "/train/subject_train.txt"
subject_train <- read.table(paste0(basePath, fname), sep = "")
names(subject_train) <- "subjectnumber"

#Append subject number to training set
X_train$subjectnumber <- subject_train$subjectnumber

#Read in activity numbers for training set, rename
fname <- "/train/y_train.txt"
activityNumber_train <- read.table(paste0(basePath, fname), sep = "")
names(activityNumber_train) <- "activitynumber"

#Append activity number to training set
X_train$activitynumber <- activityNumber_train$activitynumber

#Read in activity labels
fname <- "/activity_labels.txt"
activityLabels <- read.table(paste0(basePath, fname), sep = "")
names(activityLabels) <- c("activitynumber","activity")
activityLabels$activity <- tolower(activityLabels$activity)
activityLabels$activity <- sub("_", "", activityLabels$activity) #remove underscores

#Merge activity labels with training set
mergedDataTrain <- merge(X_train, activityLabels, by.x = "activitynumber", by.y = "activitynumber")
mergedDataTrain <- mergedDataTrain[,-1] #drop first col of activity numbers since not needed

#######################################
#Step 1b - Repeat 1a for test data set:
#######################################

#Read in X_train.txt
fname <- "/test/X_test.txt"
X_test <- read.table(paste0(basePath, fname), sep = "")

#Rename X_test vars with the feature names
names(X_test) <- featureNames

#Read in numbers for subjects assigned to test set, rename
fname <- "/test/subject_test.txt"
subject_test <- read.table(paste0(basePath, fname), sep = "")
names(subject_test) <- "subjectnumber"

#Append subject number to test set
X_test$subjectnumber <- subject_test$subjectnumber

#Read in activity numbers for test set, rename
fname <- "/test/y_test.txt"
activityNumber_test <- read.table(paste0(basePath, fname), sep = "")
names(activityNumber_test) <- "activitynumber"

#Append activity number to test set
X_test$activitynumber <- activityNumber_test$activitynumber

#Merge activity labels with test set
mergedDataTest <- merge(X_test, activityLabels, by.x = "activitynumber", by.y = "activitynumber")
mergedDataTest <- mergedDataTest[,-1] #drop first col of activity numbers since not needed

#####################################
#Step 1c - Merge test and train sets:
#####################################

#10299 obs of 563 variables: 561 features plus subject number and activity.
mergedDataAll <- rbind(mergedDataTest, mergedDataTrain)

#################################################################
#################################################################
#Step 2 - Extract only measurements dealing with mean and std dev
#################################################################
#################################################################

#The variables subsetted are those containing '-mean()' or '-std()' 
#in their name, a total of 66 of the original 561 features.
mean_stddevVariableNames <- grep("^.*(-mean|-std)\\(\\)", names(mergedDataAll), value = T) 

#The 66 variables subsetted:

# [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
# [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
# [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
# [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
# [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
#[11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
#[13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
#[15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
#[17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
#[19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
#[21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
# [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
# [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
# [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
# [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
# [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
# [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
# [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
# [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
# [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
# [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
# [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
# [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
# [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
# [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
# [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
# [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
# [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
# [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
# [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
# [61] "fBodyAccJerkMag-mean()"      "fBodyAccJerkMag-std()"  
# [63] "fBodyGyroMag-mean()"         "fBodyGyroMag-std()"     
# [65] "fBodyGyroJerkMag-mean()"     "fBodyGyroJerkMag-std()" 

#Extract 10299 obs of 68 vars, including above vars plus 'subjectnumber' and 'activity': 
bool1 <- names(mergedDataAll) %in% mean_stddevVariableNames
bool2 <- names(mergedDataAll) %in% c("subjectnumber","activity")
mergedData_Mean_StdDev <- mergedDataAll[ , which(bool1 | bool2)]

#Rearrange columns so that subjectnumber and activity are first
mergedData_Mean_StdDev <- mergedData_Mean_StdDev[c(67,68,1:66)]  

##############################################################
##############################################################
#Step 3. Creates appropriate names for activities in data set
##############################################################
##############################################################

#Initiated above in Step 1a and 1b.
#The activity numbers were appended to X_train & X_test.
#Those sets were merged with the data from activity_labels.txt
#which includes both the numbers and descriptive text labels

#Later, when final tidy data set is created, variable names
#for the retained features will be modified to reflect which represent
#the aggregate mean versus std dev. See below for details,

##################################################################
##################################################################
#Step 4 - Labels the data set with appropriate, descriptive names
##################################################################
##################################################################

#Initiated in Step 1a and 1b.
#The 561 feature names in features.txt were read in
#and used to rename the 561 columns in each of
#X_test and X_train dfs.

#Here, these variable names are further cleaned up, specifically:
#1. remove hyphens
#2. remove parentheses
#3. convert lowercase 'mean' and 'std' to 'Mean' and 'Std', for readability
#
#Note: The general recommendation is that variable names be all lower case when
#possible. However, the 66 variable names related to the physical quantities
#measured by the phone contain abbreviations and are arguably easier to read 
#if so-called camel case is used, with the first letter of the first word in lower case, 
#and first letters of subsequent words in upper case. 

#Example: fBodyAcc-mean()-X is converted to fBodyAccMeanX

names(mergedData_Mean_StdDev) <- sub("-m", "M", names(mergedData_Mean_StdDev))
names(mergedData_Mean_StdDev) <- sub("-s", "S", names(mergedData_Mean_StdDev))
names(mergedData_Mean_StdDev) <- sub("-", "", names(mergedData_Mean_StdDev))
names(mergedData_Mean_StdDev) <- sub("\\(\\)", "", names(mergedData_Mean_StdDev))

################################################################################################
################################################################################################
#Step 5 - Creates a tidy data with the mean of each variable for each activity and each subject
################################################################################################
################################################################################################

#Following "Tidy Data", by Hadley Wickham (http://vita.had.co.nz/papers/tidy-data.pdf),
#the final tidy data set will have a 'long and tall' format.

#For instance the tidy data set for the TB data in Tidy Data, p. 10. 
#In that example, using database terminology the primary key for each row is: 
#(country, year, sex, age) 
#and the value is: 
#(cases), the count of TB cases for the given key values in that row.

#For the current phone data set, we do something similar. The steps are:

#1. Melt (rotate) the 66 features into a single column, using subjectnumber
#and activity as id variables.

#2. Apply dcast to get a data frame with the mean of each feature for each 
#combination of subjectnumber and activity. 
#Each feature is renamed with "VarMean" appended to its name.

#3. Apply dcast to get a second data frame with standard deviation of each 
#feature for each combination of subjectnumber and activity. 
#Each feature is renamed with "VarSD" appended to its name.

#4. Merge the two resulting data frames into a single 'short and wide' data frame 
#with 134 columns--2 * 66 = 132 for the renamed features
#plus 2 more, namely subjectnumber and activity.

#5. Finally, use melt to rotate the 132 renamed features into a single column, 
#yielding a 'long and tall' data set with four columns (and many rows).

#For each row of the phone data set, the primary key will be:
#(subjectnumber, activity, summaryvarname) 
#and the value:
#(summaryvarvalue), the mean or std dev of all values of
#that feature for the given subject and activity.

#Thus for each subjectnumber and activity, 6 * 30 = 180 combinations, 
#there will be 2 * 66 = 132 rows of observations, for a total
#of 180 * 132 = 23760 rows in the final tidy set.

#Example: the summaryvarname column in the final tidy data set will contain values such as
#fBodyGyroJerkMagStdVarMean and fBodyGyroJerkMagStdVarSD. 
#Now suppose that for subjectnumber == 1 and activity == "walkingupstairs" applications of
#dcast produce the following summary stats:
#fBodyGyroJerkMagStdVarMean == -0.0187345 
#fBodyGyroJerkMagStdVarSD = 0.2141895.

#Then the headers of the tidy set are: 

#   subjectnumber          activity               summaryvarname   summaryvarvalue

#And in some row we see:

#               1   walkingupstairs   fBodyGyroJerkMagStdVarMean        -0.0187345

#And in some other row we see:

#               1   walkingupstairs   fBodyGyroJerkMagStdVarSD           0.2141895



#melt/rotate 66 feature names into one column
mergedData_Mean_StdDev_Melt <- melt(mergedData_Mean_StdDev, id = c("subjectnumber","activity"), 
measure.vars = names(mergedData_Mean_StdDev)[3:length(names(mergedData_Mean_StdDev))])

#apply dcast to get a df of means: 180 obs of 68 vars
len <- length(names(mergedData_Mean_StdDev))
meanData <- dcast(mergedData_Mean_StdDev_Melt, subjectnumber + activity ~ variable, mean)
names(meanData)[3: len] <- paste0(names(meanData)[3:len], "VarMean")

#apply dcast to get a df of sd's: 180 obs of 68 vars
sdData <- dcast(mergedData_Mean_StdDev_Melt, subjectnumber + activity ~ variable, sd)
names(sdData)[3:len] <- paste0(names(sdData)[3:len], "VarSD")

#merge the two into one 'wide short' untidy df: 180 obs of 134 vars
mergedSummaryData <- merge(meanData, sdData, by = intersect(names(meanData), names(sdData)), all = T) 

#create final tidy 'tall narrow' df by melting the 6 vars into a single column again: 23760 obs of 4 vars
finalData <- melt(mergedSummaryData, id = c("subjectnumber","activity"), 
measure.vars = names(mergedSummaryData)[3:length(names(mergedSummaryData))])

#Rename generic 'variable' and 'value' columns
names(finalData)[3:4] <- c("summaryvarname", "summaryvarvalue")

#Write data to disk
write.table(finalData, "means_stddevs_HAR_Data_tidy.txt", row.names = F)

###################################
#####END run_analysis.r script#####
###################################
