#0 You should create one R script called run_analysis.R that does the following. 
#1 Merges the training and the test sets to create one data set.
#read data sets


#common names create common names reference files
col_names <- read.table("UCI HAR Dataset/features.txt",sep="", header=FALSE)
act_labels <- read.table("UCI HAR Dataset/activity_labels.txt",sep="", header=FALSE)


mydf <- read.table("UCI HAR Dataset/test/X_test.txt",sep="", header=FALSE)
subj <- read.table("UCI HAR Dataset/test/subject_test.txt",sep="", header=FALSE)
actv <- read.table("UCI HAR Dataset/test/y_test.txt",sep="", header=FALSE)

#assign names to columns
names(mydf) <- col_names[,2]
names(subj) <- "subject"
names(actv) <- "activity"

#combine
mydf <- cbind(mydf, subj, actv)
test_data <- tbl_df(mydf)

mydf <- read.table("UCI HAR Dataset/train/X_train.txt",sep="", header=FALSE)
subj <- read.table("UCI HAR Dataset/train/subject_train.txt",sep="", header=FALSE)
actv <- read.table("UCI HAR Dataset/train/y_train.txt",sep="", header=FALSE)

#assign names to columns
names(mydf) <- col_names[,2]
names(subj) <- "subject"
names(actv) <- "activity"

mydf <- cbind(mydf, subj, actv)
training_data <- tbl_df(mydf)

#remove unwanted variables
rm("mydf")
rm("subj")
rm("actv")

#merge the data
merged_data <- rbind(training_data, test_data)


#2 Extracts only the measurements on the mean and standard deviation for each measurement. 

#find columns which have mean or std
#search through col_names for mean() or std(), find the columns and subset it from overall list
cols_subset <- grep ("mean\\(\\)|std\\(\\)", col_names[,2], ignore.case=TRUE)

subset_temp <- merged_data[,cols_subset[]]
subset_data <- cbind(subset_temp, merged_data$subject, merged_data$activity)

#modify the names to be consistent
colnames(subset_data)[67] <- "subject"
colnames(subset_data)[68] <- "activity"

#3 Uses descriptive activity names to name the activities in the data set
# add columns
subset_data <- merge(subset_data, act_labels, by.x="activity", by.y="V1", all=FALSE)
#sort
#desc_act_data <- arrange(desc_act_data, activity, subject)
subset_data <- arrange(subset_data, activity, subject)
#assign colname
colnames(subset_data)[69] <- "activity_desc"

#reorder columns
#temp<- desc_act_data[ c("V2", names(desc_act_data)[!grepl("V2", names(desc_act_data))]) ]
#temp<- temp[ c("subject", names(temp)[!grepl("subject", names(temp))]) ]
subset_data<- subset_data[ c("activity_desc", names(subset_data)[!grepl("activity_desc", names(subset_data))]) ]
subset_data<- subset_data[ c("subject", names(subset_data)[!grepl("subject", names(subset_data))]) ]

#4 Appropriately labels the data set with descriptive variable names.
#mutate the column to get names
#grep to replace strings.. 
names(subset_data) <- gsub("mean\\(\\)\\-X", "mean_X-axis", names(subset_data))
names(subset_data) <- gsub("mean\\(\\)\\-Y", "mean_Y-axis", names(subset_data))
names(subset_data) <- gsub("mean\\(\\)\\-Z", "mean_Z-axis", names(subset_data))

names(subset_data) <- gsub("std\\(\\)\\-X", "StdDev_X-axis", names(subset_data))
names(subset_data) <- gsub("std\\(\\)\\-Y", "StdDev_Y-axis", names(subset_data))
names(subset_data) <- gsub("std\\(\\)\\-Z", "StdDev_Z-axis", names(subset_data))

names(subset_data) <- gsub("tBodyAcc\\-", "raw_body_accelerometer_", names(subset_data))
names(subset_data) <- gsub("tGravityAcc\\-", "raw_gravity_accelerometer_", names(subset_data))
names(subset_data) <- gsub("tBodyAccJerk\\-", "calc_linear_accelaration_jerk_", names(subset_data))
names(subset_data) <- gsub("tBodyGyro\\-", "raw_body_gyroscope_", names(subset_data))
names(subset_data) <- gsub("tBodyGyroJerk\\-", "calc_angular_gyroscope_jerk_", names(subset_data))
names(subset_data) <- gsub("tBodyAccMag\\-", "calc_euclidean-norm_mag_body_acceleration_", names(subset_data))

names(subset_data) <- gsub("tGravityAccMag\\-", "calc_euclidean-norm_mag_gravity_acceleration_", names(subset_data))
names(subset_data) <- gsub("tBodyAccJerkMag\\-", "calc_euclidean-norm_mag_body_acceleration_jerk_", names(subset_data))
names(subset_data) <- gsub("tBodyGyroMag\\-", "calc_euclidean-norm_mag_body_gyroscope_", names(subset_data))
names(subset_data) <- gsub("tBodyGyroJerkMag\\-", "calc_euclidean-norm_mag_body_gyroscope_jerk", names(subset_data))

names(subset_data) <- gsub("fBodyAcc\\-", "calc_fft_body_acceleration_", names(subset_data))
names(subset_data) <- gsub("fBodyAccJerk\\-", "calc_fft_body_acceleration_jerk_", names(subset_data))
names(subset_data) <- gsub("fBodyGyro\\-", "calc_fft_body_gyroscope_", names(subset_data))
names(subset_data) <- gsub("fBodyAccMag\\-", "calc_fft_mag_body_acceleration_", names(subset_data))
names(subset_data) <- gsub("fBodyBodyAccJerkMag\\-", "calc_fft_mag_body_body_acceleration_jerk", names(subset_data))

names(subset_data) <- gsub("fBodyBodyGyroMag\\-", "calc_fft_mag_body_gyroscope_", names(subset_data))
names(subset_data) <- gsub("fBodyBodyGyroJerkMag\\-", "calc_fft_mag_body_body_gyroscope_jerk_", names(subset_data))


#5 From the data set in step 4, creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject.
# group by each activity and subject
tidy_data <- subset_data %>% group_by(subject, activity_desc) %>% summarise_each(funs(mean))

#write to an output file
write.table(tidy_data, file = "output.txt",row.names=FALSE)
