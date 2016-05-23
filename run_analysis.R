###########################################
##Getting and cleaning data: Course Project
###########################################

# ***********************************
# 1. Merge the training and test sets
# ***********************************

# --------------
# Load meta data
# --------------

features<-read.csv("./UCI HAR Dataset/features.txt", sep=" ", header=FALSE, col.names=c("feature_id","feature_name"), stringsAsFactors = FALSE)
activity_labels<-read.csv("./UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE, col.names=c("activity_id","activity_name"), stringsAsFactors = FALSE)

# -----------------
# load training set
# -----------------

subject_train<-read.csv("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("subject_id"), stringsAsFactors = FALSE)

## 2. Use descriptive activity names to name activities in the data set:
## decode y_train using activity_labels and simplify into just the activity names
y_train<-read.csv("./UCI HAR Dataset/train/y_train.txt", col.names=c("activity_id"), stringsAsFactors = FALSE, header=FALSE)
train_activity<-merge(y_train,activity_labels,by.x = "activity_id",by.y = "activity_id")
train_activity<-train_activity[,2]

## x_train data has 561 columns (one for each feature measured), fixed width 16 characters each
x_train<-read.fwf("./UCI HAR Dataset/train/X_train.txt",widths=rep(c(16),561),header=FALSE,col.names=features[,2],colClasses=rep(c("numeric"),561), buffersize = 500)

## merge with subject_train to identify which subject was measured for each row 
## merge with train_activity to identify which activity was measured
all_train<-cbind(subject_train,activity=train_activity,x_train)

# ------------------
# Load test data set 
# ------------------

subject_test<-read.csv("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("subject_id"), stringsAsFactors = FALSE)

## 2. Use descriptive activity names to name activities in the data set:
## decode y_test using activity_labels and simplify into just the activity names
y_test<-read.csv("./UCI HAR Dataset/test/y_test.txt", col.names=c("activity_id"), stringsAsFactors = FALSE, header=FALSE)
test_activity<-merge(y_test,activity_labels,by.x = "activity_id",by.y = "activity_id")
test_activity<-test_activity[,2]

## x_test data has 561 columns (one for each feature measured), fixed width 16 characters each
x_test<-read.fwf("./UCI HAR Dataset/test/X_test.txt",widths=rep(c(16),561),header=FALSE,col.names=features[,2],colClasses=rep(c("numeric"),561), buffersize = 500)

## merge with subject_test to identify which subject was measured for each row 
## merge with test_activity to identify which activity was measured
all_test<-cbind(subject_test,activity=test_activity,x_test)

# ----------------------------------
# Combine the training and test sets
# ----------------------------------

combined_set<-rbind(all_train,all_test)

###############################################################################
# 3. Extract only measurements on mean and standard deviation for each measurement
###############################################################################

clean_set<-combined_set[,grepl("[Mm]ean|std|subject_id|activity",names(combined_set))&!grepl("meanFreq",names(combined_set))]

##################################################################
# 4. Appropriately label the data set with descriptive variable names
##################################################################

clean_names<-tolower(names(clean_set))
clean_names<-sub("^t","time",clean_names)
clean_names<-sub("^f","frequency", clean_names)
clean_names<-sub("subject_id","subjectid", clean_names)
clean_names<-gsub("\\.","",clean_names)
clean_names<-sub("acc","accelleration",clean_names)
clean_names<-sub("mag","magnitude",clean_names)
clean_names<-sub("std","standarddeviation",clean_names)
clean_names<-sub("gyro","gyroscope", clean_names)
clean_names<-sub("tbody","timebody",clean_names)

names(clean_set)<-clean_names

write.csv(clean_set,"tidy_fitness_data.txt")

############################################################################################################
# Create a second independent tidy data set with average of each variable for each activity and each subject
############################################################################################################

clean_set_2<-aggregate(clean_set[, 3:75], list(subject=clean_set$subject,activity=clean_set$activity), mean, use.names=TRUE)

##remove the standard deviation variables from the set (these can not be averaged)
clean_set_2<-clean_set_2[,!grepl("standarddeviation",names(clean_set_2))]

write.csv(clean_set_2,"tidy_fitness_data_averages_per_subject_activity.txt")
