#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(data.table)
setwd("~/R/CleaningDataCourse")

#Read in all data
features<- read.table("./features.txt",header=FALSE)
activity_label<- data.table(read.table("./activity_labels.txt",header=FALSE))
subject_train<-read.table("./train/subject_train.txt", header=FALSE)
x_train<- read.table("./train/X_train.txt", header=FALSE)
y_train<- read.table("./train/y_train.txt", header=FALSE)
subject_test<-read.table("./test/subject_test.txt", header=FALSE)
x_test<- read.table("./test/X_test.txt", header=FALSE)
y_test<- read.table("./test/y_test.txt", header=FALSE)

#Rename some of the columns for clarity
colnames(activity_label)<-c("activityId","activityType")
colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"
colnames(x_train) <- features[,2]
colnames(x_test) <- features[,2]
colnames(y_train) <- "activityId"
colnames(y_test) <- "activityId"

#Combine data sets together
test_merged <- cbind(y_test,subject_test,x_test)
train_merged <- cbind(y_train,subject_train,x_train)
merged_data<-rbind(test_merged,train_merged)

#Extract columns needed
merged_data_subset <- data.table(merged_data[,grepl("mean|std|subjectId|activityId",ignore.case = TRUE,names(merged_data))])

#clean memory
rm("merged_data","subject_test","subject_train","x_test","x_train","y_test","y_train","test_merged","train_merged")

#Join in activity types
setkey(merged_data_subset,activityId)
setkey(activity_label,activityId)
merged_data_subset <- merged_data_subset[activity_label, nomatch=0]

#Remove no longer needed activityId column
merged_data_subset[,activityId:=NULL]

#Clean up column names
col_names<-names(merged_data_subset)

#Remove special charachters
col_names <- gsub("\\(|\\)", "", col_names, perl  = TRUE)

col_names <- make.names(col_names)
col_names <- gsub("BodyBody", "Body", col_names)
col_names <- gsub("mean", "Mean", col_names)
col_names <- gsub("std", "Std", col_names)
col_names <- gsub("Freq", "Frequency", col_names)
col_names <- gsub("Mag", "Magnitude", col_names)
col_names <- gsub("Acc", "Acceleration", col_names)
col_names <- gsub("^t", "Time", col_names)
col_names <- gsub("^f", "Frequency", col_names)

data_subset_agg<-merged_data_subset[,lapply(.SD, mean),by=.(activityType,subjectId)]
write.table(data_subset_agg,file="data_subset_agg.txt")