
## ======================================================================
## Read data for processing
## ----------------------------------------------------------------------
## - training set
train_x<-(read.table("getdata/UCI HAR Dataset/train/x_train.txt",sep=""))
## - training labels
train_y<-(read.table("getdata/UCI HAR Dataset/train/y_train.txt",sep=""))
## - training subjects
train_s<-(read.table("getdata/UCI HAR Dataset/train/subject_train.txt",sep=""))
## ----------------------------------------------------------------------
## - test set
test_x<-(read.table("getdata/UCI HAR Dataset/test/x_test.txt",sep=""))
## - test labels
test_y<-(read.table("getdata/UCI HAR Dataset/test/y_test.txt",sep=""))
## - test subjects
test_s<-(read.table("getdata/UCI HAR Dataset/test/subject_test.txt",sep=""))
## ----------------------------------------------------------------------
## - features (list of varaibles in train and test datasets)
features<-(read.table("getdata/UCI HAR Dataset/features.txt",sep=""))
## - activity labels
activity_labels<-(read.table("getdata/UCI HAR Dataset/activity_labels.txt",sep=""))
## ======================================================================


## ======================================================================
## Data Cleaning
## ----------------------------------------------------------------------
## - features - set to lower case and add to new column in features
features[,2]<- tolower(features[,2])
features[,3]<- features[,2]
## character 1 : x, y, z coordinate or m for magnitude 
features[,3] <- ifelse(grepl("-x",features[,2]),"x_",
                       ifelse(grepl("-y",features[,2]),"y_",
                              ifelse(grepl("-z",features[,2]),"z_",
                                     ifelse(grepl("mag-",features[,2]),"m_",""))))
## character 3-6 : time or freq(uency) 
features[,3] <- paste0(features[,3], 
                  ifelse(grepl("^f",features[,2]),"freq_",
                    ifelse(grepl("^t",features[,2]),"time_", "")))
## character 8-11 : acce(lerator) or gyro(scope)
features[,3] <- paste0(features[,3], 
                       ifelse(grepl("acc",features[,2]),"acce_",
                              ifelse(grepl("gyro",features[,2]),"gyro_", "")))
## character 13-16 : body or grav(ity)
features[,3] <- paste0(features[,3], 
                       ifelse(grepl("body",features[,2]),"body_",
                              ifelse(grepl("gravity",features[,2]),"grav_", "")))
## character 18-21 : mean or sdev (standard deviation)
features[,3] <- paste0(features[,3], 
                       ifelse(grepl("mean\\(\\)",features[,2]),"mean_",
                              ifelse(grepl("std\\(\\)",features[,2]),"sdev_", "")))
## character 23-26 : jerk or not (blank)
features[,3] <- paste0(features[,3], 
                       ifelse(grepl("jerk",features[,2]),"jerk", ""))
## ======================================================================



## ======================================================================
## Name Changing
## ----------------------------------------------------------------------
## - training set - add features to column names
names(train_x)<-as.character(features[,3])
## - training labels - change column name to activity_id 
names(train_y)<-c("activity_id")
## - training subjects - change column name to subject
names(train_s)<-c("subject")
## ----------------------------------------------------------------------
## - test set - add features to column names
names(test_x)<-as.character(features[,3])
## - training labels - change column name to activity_id 
names(test_y)<-c("activity_id")
## - training subjects - change column name to subject
names(test_s)<-c("subject")
## ----------------------------------------------------------------------
## - activity labels - activity_id and activity (description)
names(activity_labels)<-c("activity_id","activity")
## ======================================================================

## ======================================================================
## Data manipulation
## ----------------------------------------------------------------------
## Each triple of Train and test sets bound together by column
train<-cbind(train_s, train_y,train_x)
test<-cbind(test_s, test_y,test_x)
## ----------------------------------------------------------------------
## Bound sets then bound together in row to create master data
train_test<-rbind(train, test)
## columns with mean or std in them (along with subject and activity_id) 
## are used
train_test_1<-train_test[,c(TRUE, TRUE,grepl("_mean_|_sdev_",features[,3]))]
## ----------------------------------------------------------------------
## activity lables are merged into the resulting data set
train_test_2<-merge(activity_labels,train_test_1,  by.x="activity_id", by.y="activity_id")
## ======================================================================


## ======================================================================
## Aggregation of data
ldf<-length(names(train_test_2))
## ----------------------------------------------------------------------
## means calculated by subject and activity (renamed as MEAN_...)
mean_df<-aggregate(train_test_2[,4:ldf],train_test_2[,1:3],mean)
names(mean_df)<-c("a_id","activity","subject",paste0("MEAN_",names(mean_df[,4:ldf])))
## ======================================================================

## ======================================================================
## Write file
write.csv(mean_df,"Project_mean.txt")
##write.csv(train_test_2,"FullData.txt")
## ======================================================================
