The CodeBook is designed for run_analysis.R, this R script is designed to clean and prepare the data in order to derive the output of this exercise. 

1. Download and unzip the dataset
  -file_url_loc = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

2. Read in the data and assign variable to the data
  -features_labels: measurements of the activities col = 561, will be col names for test and training data
  -activity_names: add col names to activity labels, e.g. walking, laying, standing
  -subject_test, x_test, y_test: reading from test data. Subject_test indicates the subject that performed the test
  -subject_train, x_train, y_train: read in the test data
  
3. Merge the test and training data set
  -x_merge, y_merge merges the test with the training data and then Total_Merge merges the subject with the x and y merge.
  
4. Extract mean and std for measurement
  -I designed 2 methods to perform this, and I put both method in the code, and used method 2 to perform this task. 
  -Use grep to isolate the column names that contains mean, std, and subject, and test_labels.
  -The first method used a loop to perform this task. 
  
5. Uses descriptive activity names to name the activities in the data set, and appropriately labels the data set with descriptive variable names. 
  -Replace the activity code with the actual name of the activities
  -Change the label of short desicrition to long named description
  
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  -Output the final product file, TidyData, which consists of 30 subject who performed 6 activities, with a nrow = 180. 




















  