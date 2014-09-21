CodeBook.md
===========

Code book for Getting and Cleaning Data project
===============================================

Author: David Schonberger
=========================

Created: 9/19/2014
==================

Variables (Columns) in the Tidy Data Set
----------------------------------------

(For more specific details on exact manipulations and transformations employed, please see run_analysis.r. It is pretty heavily commented.)
-------------------------------------------------------------------------------------------------------------------------------------------

###SUBJECTNUMBER
 - An integer 1-30 inclusive corresponding to one of the 30 people who participated in the experiment.
 
 - The files subject_test.txt and subject_train.txt contain subject numbers, one entry per row
of the X_test and X_train data frames, respectively. These subject numbers were read in and appended as a
new variable to the corresponding data frame X_test or X_train.

###ACTIVITY

 - A string corresponding to one of 6 activities each subject engaged in during the experiment.
 
 - The values in the final data set are: 
 
 'walking' 

 'walkingupstairs' 

 'walkingdownstairs'

 'sitting'

 'standing'

 'laying'
 
####Here is how they are obtained:
 
 - The files y_test.txt and y_train.txt contain activity numbers, 1-6, one entry per row
of the X_test and X_train data frames, respectively. These subject numbers were read in and appended as a
new variable to the corresponding data frame X_test and X_train.

- The file activity_labels.txt contains the following mapping from activity numbers to actual activities:
 
1 WALKING

2 WALKING_UPSTAIRS

3 WALKING_DOWNSTAIRS

4 SITTING

5 STANDING

6 LAYING

This mapping was read in to a data frame, the activity names were set to lower case, and the underscores were removed 
from activity 2 and 3.
  
 - This data frame was then merged with each of X_test and X_train by matching activity numbers. 
 
 - Lastly, the column of activity numbers was dropped.
 
###SUMMARYVARNAME

 - A string corresponding a summary statistic (either mean or standard deviation) of one of the 66 features extracted from features.txt.
 
 - Each value is a cleaned up version of the original feature name (from features.txt), with 'VarMean' or 'VarSD' appended to the end.
 The appended string indicates that the variable represents either the mean or standard deviation of all observations of that feature
 for a given subject and activity. 

 - The 132 values in the final data set are:

"1" "tBodyAccMeanXVarMean"

"2" "tBodyAccMeanYVarMean"

"3" "tBodyAccMeanZVarMean"

"4" "tBodyAccStdXVarMean"

"5" "tBodyAccStdYVarMean"

"6" "tBodyAccStdZVarMean"

"7" "tGravityAccMeanXVarMean"

"8" "tGravityAccMeanYVarMean"

"9" "tGravityAccMeanZVarMean"

"10" "tGravityAccStdXVarMean"

"11" "tGravityAccStdYVarMean"

"12" "tGravityAccStdZVarMean"

"13" "tBodyAccJerkMeanXVarMean"

"14" "tBodyAccJerkMeanYVarMean"

"15" "tBodyAccJerkMeanZVarMean"

"16" "tBodyAccJerkStdXVarMean"

"17" "tBodyAccJerkStdYVarMean"

"18" "tBodyAccJerkStdZVarMean"

"19" "tBodyGyroMeanXVarMean"

"20" "tBodyGyroMeanYVarMean"

"21" "tBodyGyroMeanZVarMean"

"22" "tBodyGyroStdXVarMean"

"23" "tBodyGyroStdYVarMean"

"24" "tBodyGyroStdZVarMean"

"25" "tBodyGyroJerkMeanXVarMean"

"26" "tBodyGyroJerkMeanYVarMean"

"27" "tBodyGyroJerkMeanZVarMean"

"28" "tBodyGyroJerkStdXVarMean"

"29" "tBodyGyroJerkStdYVarMean"

"30" "tBodyGyroJerkStdZVarMean"

"31" "tBodyAccMagMeanVarMean"

"32" "tBodyAccMagStdVarMean"

"33" "tGravityAccMagMeanVarMean"

"34" "tGravityAccMagStdVarMean"

"35" "tBodyAccJerkMagMeanVarMean"

"36" "tBodyAccJerkMagStdVarMean"

"37" "tBodyGyroMagMeanVarMean"

"38" "tBodyGyroMagStdVarMean"

"39" "tBodyGyroJerkMagMeanVarMean"

"40" "tBodyGyroJerkMagStdVarMean"

"41" "fBodyAccMeanXVarMean"

"42" "fBodyAccMeanYVarMean"

"43" "fBodyAccMeanZVarMean"

"44" "fBodyAccStdXVarMean"

"45" "fBodyAccStdYVarMean"

"46" "fBodyAccStdZVarMean"

"47" "fBodyAccJerkMeanXVarMean"

"48" "fBodyAccJerkMeanYVarMean"

"49" "fBodyAccJerkMeanZVarMean"

"50" "fBodyAccJerkStdXVarMean"

"51" "fBodyAccJerkStdYVarMean"

"52" "fBodyAccJerkStdZVarMean"

"53" "fBodyGyroMeanXVarMean"

"54" "fBodyGyroMeanYVarMean"

"55" "fBodyGyroMeanZVarMean"

"56" "fBodyGyroStdXVarMean"

"57" "fBodyGyroStdYVarMean"

"58" "fBodyGyroStdZVarMean"

"59" "fBodyAccMagMeanVarMean"

"60" "fBodyAccMagStdVarMean"

"61" "fBodyAccJerkMagMeanVarMean"

"62" "fBodyAccJerkMagStdVarMean"

"63" "fBodyGyroMagMeanVarMean"

"64" "fBodyGyroMagStdVarMean"

"65" "fBodyGyroJerkMagMeanVarMean"

"66" "fBodyGyroJerkMagStdVarMean"

"67" "tBodyAccMeanXVarSD"

"68" "tBodyAccMeanYVarSD"

"69" "tBodyAccMeanZVarSD"

"70" "tBodyAccStdXVarSD"

"71" "tBodyAccStdYVarSD"

"72" "tBodyAccStdZVarSD"

"73" "tGravityAccMeanXVarSD"

"74" "tGravityAccMeanYVarSD"

"75" "tGravityAccMeanZVarSD"

"76" "tGravityAccStdXVarSD"

"77" "tGravityAccStdYVarSD"

"78" "tGravityAccStdZVarSD"

"79" "tBodyAccJerkMeanXVarSD"

"80" "tBodyAccJerkMeanYVarSD"

"81" "tBodyAccJerkMeanZVarSD"

"82" "tBodyAccJerkStdXVarSD"

"83" "tBodyAccJerkStdYVarSD"

"84" "tBodyAccJerkStdZVarSD"

"85" "tBodyGyroMeanXVarSD"

"86" "tBodyGyroMeanYVarSD"

"87" "tBodyGyroMeanZVarSD"

"88" "tBodyGyroStdXVarSD"

"89" "tBodyGyroStdYVarSD"

"90" "tBodyGyroStdZVarSD"

"91" "tBodyGyroJerkMeanXVarSD"

"92" "tBodyGyroJerkMeanYVarSD"

"93" "tBodyGyroJerkMeanZVarSD"

"94" "tBodyGyroJerkStdXVarSD"

"95" "tBodyGyroJerkStdYVarSD"

"96" "tBodyGyroJerkStdZVarSD"

"97" "tBodyAccMagMeanVarSD"

"98" "tBodyAccMagStdVarSD"

"99" "tGravityAccMagMeanVarSD"

"100" "tGravityAccMagStdVarSD"

"101" "tBodyAccJerkMagMeanVarSD"

"102" "tBodyAccJerkMagStdVarSD"

"103" "tBodyGyroMagMeanVarSD"

"104" "tBodyGyroMagStdVarSD"

"105" "tBodyGyroJerkMagMeanVarSD"

"106" "tBodyGyroJerkMagStdVarSD"

"107" "fBodyAccMeanXVarSD"

"108" "fBodyAccMeanYVarSD"

"109" "fBodyAccMeanZVarSD"

"110" "fBodyAccStdXVarSD"

"111" "fBodyAccStdYVarSD"

"112" "fBodyAccStdZVarSD"

"113" "fBodyAccJerkMeanXVarSD"

"114" "fBodyAccJerkMeanYVarSD"

"115" "fBodyAccJerkMeanZVarSD"

"116" "fBodyAccJerkStdXVarSD"

"117" "fBodyAccJerkStdYVarSD"

"118" "fBodyAccJerkStdZVarSD"

"119" "fBodyGyroMeanXVarSD"

"120" "fBodyGyroMeanYVarSD"

"121" "fBodyGyroMeanZVarSD"

"122" "fBodyGyroStdXVarSD"

"123" "fBodyGyroStdYVarSD"

"124" "fBodyGyroStdZVarSD"

"125" "fBodyAccMagMeanVarSD"

"126" "fBodyAccMagStdVarSD"

"127" "fBodyAccJerkMagMeanVarSD"

"128" "fBodyAccJerkMagStdVarSD"

"129" "fBodyGyroMagMeanVarSD"

"130" "fBodyGyroMagStdVarSD"

"131" "fBodyGyroJerkMagMeanVarSD"

"132" "fBodyGyroJerkMagStdVarSD"



####Here is how they are obtained:

- All 561 feature names were read into a data frame from features.txt.

- Several of the names contained a typo: the phrase 'BodyBody' appears in some feature names and
these cases the extra occurrence of 'Body' was removed.

- The feature names were set as the variable names for the 561 columns of each of the
X_test and X_train data frames.

- The data for the 66 feature names containing '-mean()' and '-std()' was extracted. This decision was
based on the project instructions that said to extract only measurements on the mean and standard deviation
of observed quantities.

- These variable names were further cleaned up by removing hyphens, changing 'mean' to 'Mean' and 'std' to 'Std'
and by removing the parentheses.

- When the final tidy data set was created, the phrase 'VarMean' and 'VarSD' was appended to each of the 66 distinct
cleaned feature names to produce the 132 values above.
 
###SUMMARYVARVALUE

- A numeric (floating point) value representing the mean or standard deviation of the variable SUMMARYVARNAME
in the same row. 

- Since these are means and standard deviations, there is no specific set of values, so there are not enumerated here.

####Here is how they are obtained:

- The raw data was read into data frames X_test and X_train from the files X_test.txt and X_train.txt, resp.

- The other needed data related to subject numbers, activity numbers, and activities was read in, cleaned up,
and appended/merged to the above data frames. 

- The columns for the 66 desired features were extracted.

- The 66 features were melted into a column and then dcast was used twice: 

Once to produce a data frame of *means* of each of the features 

Once to produce a data frame of *standard deviations* of each of the features. 

- This left the final values that appear in the tidy data set. They were merely reshaped
my merging the these last two data frames into one 'short and wide' untidy data frame which 
was then melted into a final tidy 'long and tall' data set.