datacleansing-getdata-008
=========================

Getting and Cleaning Data Course  -GetData 008
The following represents the pseudo-logic I used to address the questions asked in the assignment
0 You should create one R script called run_analysis.R that does the following. 
1 Merges the training and the test sets to create one data set.
read data sets


common names create common names reference files

assign names to columns

combine
assign names to columns

remove unwanted variables
merge the data
 

2 Extracts only the measurements on the mean and standard deviation for each measurement. 

find columns which have mean or std
search through col_names for mean() or std(), find the columns and subset it from overall list

modify the names to be consistent

3 Uses descriptive activity names to name the activities in the data set
 add columns
sort
assign colname

reorder columns

4 Appropriately labels the data set with descriptive variable names.
mutate the column to get names
grep to replace strings.. 


5 From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject.
 group by each activity and subject
write to an output file
