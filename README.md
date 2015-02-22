# getdataproject
Coursera Getting and Cleaning Data Course Project

The run_analysis.R script gets the data from 30 voulunteers in the Samsung smartphone activity study that is stored in several different files and combines them together into a single tidy data file.

The volunteers were assigned to either a test or train group. The data for each group are stored in seperate subdirectories within the data directory. The X_test.txt and X_train.txt files contain multiple readings for each sunject over the 6 activities that were measured. The y_test.txt and y_train.txt files contains the activity number associated with the readings data files. The subject_test.txt and the subject_train.txt files contain the subject numbers associated with the readings data files. The activity_labels.txt file contains the descriptions of the six activities that were measured in the study. The features.txt file contains the column headings for the data in the readings file.The detail fields for these files are stored in the codebook.

##The script does takes the following steps to create the consolidated tidy data file from these multiple files:

-The data files and the files with the field and activity descriptions are are downloaded into the working environment with the following names:
test_sub - test group subject numbers for the data
test_data - test group readings data
test_act - test group activity numbers for the data 
train_sub - train group subject numbers for the data
train_data - train group readings data
train_act - train group activity numbers for the data 
act_lbls - descriptive labels for the activity number
features - column names for features measured in the readings data 

-Column names are assigned to the test_sub, train_sub, act_lblx and features file.

-In our tidy file we only want a subset of the columns in the readings data that contain mean and std data. The a sub-set of the features data is created to identify the columns we want by selecting all colums that contain "-mean" and "-std" then that is further refined be excluding the columns that contain "_meanFreq". The column names in the selected features columns are refined to remove the "()" and "-" symbols while modifying the mean and std to Mean and Std to match the format of the rest of the column name. 

-The column numbers of the columns in features that were selected are then used to select the corresponding columns in the test and train readings data.

-The feture description field of the selected features is then used to labal the columns in the test and train readings data files.

-The subject and activity numbers for the test and train data is them added to the corresponding test and train readings data files.

-The test and train files are then combined into a single file.

-The activity descritio file is merged with the combined data file based on activity number to add activity descriptions to the readings data.

-The data is then grouped by subject and activity description.

-The data is summaized by grroupe to produce one row in the data for each activity for each subject. The columns of readings data are averaged for each group in the summarized data and the activity number column is dropped from the output data.

-The final step takes the tidy data created and writes it out to a text file for uploading back to Coursera.




