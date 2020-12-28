library(dplyr) # dplyr is a new package which proves a set of tools for efficiently manpulating datasets in R
file_url_loc = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#download file
download.file(file_url_loc, './ucidata.zip')
unzip("ucidata.zip")

#assign variables to the data
#measurements of the activities col = 561, will be col names for test and training data
features_labels <- read.table("./features.txt", col.names = c("Count", "Features"))
#add col names to activity labels, e.g. walking, laying, standing
activity_names <- read.table("./activity_labels.txt", col.names = c("Code_Num", "Activity name"))

#reading from test data
subject_test <- read.table("./test/subject_test.txt", col.names = "subject") #subject who performed the test
x_test <- read.table("./test/X_test.txt", col.names = features_labels$Features)
y_test <- read.table("./test/y_test.txt", col.names = "test_labels")

#reading from training data
subject_train <- read.table("./train/subject_train.txt", col.names = "subject") #30 subject who performed the test
x_train <- read.table("./train/X_train.txt", col.names = features_labels$Features)
y_train <- read.table("./train/y_train.txt", col.names = "test_labels") #activities 1-6 

#1) Merges the training and the test sets to create one data set.
subject_merge <- rbind(subject_test, subject_train)
x_merge <- rbind(x_test, x_train)
y_merge <- rbind(y_test, y_train)

Total_Merge <- cbind(subject_merge,y_merge,x_merge)
#2) Extracts only the measurements on the mean and standard deviation for each measurement. 

# Method 1 - Alternative method 
#extract_data = replicate(10299, 0)
#col_names_extract = c("mean", "std", "volunteer") # input a list of column names 
#for (i in 1:length(col_names_extract)){
#col_name = col_names_extract[i]
#df_current = select(Total_Merge, contains(col_name))
#extract_data = cbind(extract_data, df_current)
#}
#extract_data = extract_data[, -1]

# Method 2: grep 
col_names_all = colnames(Total_Merge)
df_mean = Total_Merge[, grep("mean", col_names_all)]
df_std = Total_Merge[, grep("std", col_names_all)]
df_subject = Total_Merge[, grep("subject", col_names_all)]
df_labels = Total_Merge[, grep("test_labels", col_names_all)]
extract_data = cbind(df_subject, df_labels, df_mean, df_std)

#Uses descriptive activity names to name the activities in the data set
extract_data$df_labels <- activity_names[extract_data$df_labels, 2]

#Appropriately labels the data set with descriptive variable names. 
names(extract_data) <- gsub('Acc', "Acceleration", names(extract_data))
names(extract_data) <- gsub('Gyro', "AngularSpeed", names(extract_data))
names(extract_data) <- gsub('Mag', "Magnitude", names(extract_data))
names(extract_data) <- gsub('std', "StandardDeviation", names(extract_data))
names(extract_data) <- gsub('Freq', "Frequency", names(extract_data))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
product_data <- extract_data %>%
group_by(df_subject, df_labels) %>%
summarise_all(funs(mean))
write.table(product_data, "Tidy_Data.txt", row.names=FALSE)




















