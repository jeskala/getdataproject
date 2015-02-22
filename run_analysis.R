setwd("c:/coursera/CleanData")
library("dplyr")

# get test data
test_sub <- read.table("./data/test/subject_test.txt", quote="\"")
test_data <- read.table("./data/test/X_test.txt", quote="\"")
test_lbls <- read.table("./data/test/y_test.txt", quote="\"")

# get train data
train_sub <- read.table("./data/train/subject_train.txt", quote="\"")
train_data <- read.table("./data/train/X_train.txt", quote="\"")
train_lbls <- read.table("./data/train/y_train.txt", quote="\"")

# get activity and feature descriptions
act_lbls <- read.table("./data/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)
features <- read.table("./data/features.txt", quote="\"", stringsAsFactors=FALSE)

# Name the columns in the y test and train data
colnames(test_lbls) <- "actNo"
colnames(train_lbls) <- "actNo"

# Name the columns in the subject test and train data
colnames(test_sub) <- "subject"
colnames(train_sub) <- "subject"

# Name the columns in the activity  and features description data
colnames(act_lbls) <- c("actNo", "activity")
colnames(features) <- c("featNo", "featDesc")

# Select the colums we want based on -mean and -std in the 
# feature description
feat_sel <- features[grep("-mean|-std",features$featDesc),]

# exclude columns with -meanFreq
feat_sel <- feat_sel[grep("-meanFreq",feat_sel$featDesc,invert=TRUE),]

# Reformat the feature descriptions to remove "-" and "()"
feat_sel$featDesc <- sub("-mean()", "Mean", feat_sel$featDesc,fixed=TRUE)
feat_sel$featDesc <- sub("-std()", "Std", feat_sel$featDesc,fixed=TRUE)
feat_sel$featDesc <- sub("-", "", feat_sel$featDesc,fixed=TRUE)

# make a vector of column numbers to select
col_sel <- feat_sel$featNo

# subset the test and train data by selected columns
test_sel <- test_data[,col_sel]
train_sel <- train_data[,col_sel]

# Name the columns based on the featre description
colnames(test_sel) <- feat_sel$featDesc
colnames(train_sel) <- feat_sel$featDesc

# combine x results with subject and activity numbers
test_bind <- cbind(test_sub, test_lbls, test_sel)
train_bind <- cbind(train_sub, train_lbls, train_sel)

# combine test and train data
all_data <- rbind(test_bind, train_bind)

# merge the activity descriptions onto the combined data
all_data <- merge(all_data,act_lbls)

# group the data by subject and activity description
all_group <- group_by(all_data, subject, activity)

# SUmmarize the data by group, calculate the mean of all
#  selected data columns and drop the activity number column
all_summ <- summarise_each(all_group,funs(mean), -actNo)

# write out text file for class evaluation upload
write.table(all_summ, file="./data/tidy_file.txt", row.name=FALSE)
