Code Book for Coursera Project GetData-008 
Getting and Cleaning Data
Submitted By: Najamuddin Baig (nmbaig@outlook.com)
Fri, Oct 24, 2014


Problem: Transforming raw data obtained from measurements for wearable computing to useful data

Raw Data: two major sets of data, test and trial

approach:
- Reviewed the data using the readme file and descriptions given
- Key point: the variables are described in features and they will be used throughout - hence stored
- Identified that there are 561 variables in test and trial and one useful column in subject and activity
- Combined each with Subject and activity - helps in a clean approach to combining the data [result 563 variables]
- Combined the two , resulting set has 10299(7352+2947) x 563 variables

- problem asks for mean and std deviation only - hence searched column names (obtained from features) for mean and std. Note : need to differentiate from mean frequency etc. Total 66 columns
-  to this subset, added subject and activity since they are used for grouping, net result 68 columns

Desc activity names
- the best way to describe activity was to merge with activity labels and give a qualified name to the activity

label columns
- I approached this by replacing the activity names with the type of variable (accelerometer or gyroscope), type of data (raw or calculated), for calculated it was euclidean of FFT and type of axes

- tidy data
for the data set above, grouped by subject and activity and applied summarize function