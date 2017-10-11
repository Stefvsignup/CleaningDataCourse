#Overview

###Source of the original data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Full Description at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Process
The script run_analysis.R performs the following process to clean up the data and create tiny data sets:

* Read in data sets and apply columing naming using features.txt
* Merge training and test data set together
* Join in activity types (using activity_label.txt)
* Clean up column names and provide more readible names overall
* Create merged file as as merged_data_subset.txt.
* The average of each measurement for each activity and each subject is merged to a second data set. The result is saved as data_subset_agg.txt.

###Variables

* features - table contents of features.txt
* activity_label - table contents of activity_label.txt
* subject_train - table contents of train/subject_train.txt
* x_train - table contents of train/X_train.txt
* y_train - table contents of train/y_train.txt
* subject_test - table contents of train/subject_test.txt
* x_test - table contents of test/X_test.txt
* y_test - table contents of test/y_test.txt
* test_merged - column merge together all test tables
* train_merged - column merge together all trained tables
* merged_data - merge together test and trained data sets
* merged_data_subset - merged data set without unneeded columns
* col_names - the column names for the merged data subset
* data_subset_agg - an aggregate which calculates the mean of each measure per subject id & activity type

###Output file description

#####merged_data_subset.txt
merged_data_subset.txt is a 10299x88 data frame.

The first column contains subject IDs.
The next 86 columns are measurements.
The last column contains activityType

##### data_subset_agg.txt
data_subset_agg.txt is a 180x88 data frame.

The first column contains activity types.
The second column contains the subject id.
The averages for each of the 88 attributes are in columns 3-88.