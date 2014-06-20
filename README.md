==================================================================
## Header
==================================================================
Repo: 	GetCleanDataProject

Creator:Lee Williams (LeeW1ll)

Title: Project work for the getting and cleanding data course

Version: 1.0

Date: 20/06/2014

------------------------------------------------------------------
## Purpose
------------------------------------------------------------------
The project text states the follwoing as the purpose.

"The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected." ... 

"You should create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
"  
==================================================================
## Repository Files
==================================================================
1. README.md		Details of repository, files and data used

2. run_analysis.R	R Code for creating, tidying and aggregating data

==================================================================
## Data
==================================================================
------------------------------------------------------------------
### Data Description
------------------------------------------------------------------
Data is split into training and test data set.  They have the same columns, though the data itself varies.
There are no clear headings for the data columns.  For the main data set, column names are held in the features data.
Though the names in here are hard to read and not structured well.

The subject and activity data is held in separate data and needs binding to the main data to allow identification of the results.

------------------------------------------------------------------
### Data Files Used
------------------------------------------------------------------
train/x_train.txt:- Training data results

train/y_train.txt:- Training data activity index values (numeric 1 to 6)

train/subject_train.txt:- Training data subject values (numeric 1 to 30)


test/x_test.txt:- Test data results

test/y_test.txt:- Test data activity index values (numeric 1 to 6)

test/subject_test.txt:- Test data subject values (numeric 1 to 30)

features.txt:- List of all 561 column headings used for the x_test_x.txt and x_train_x.txt data

activity_labels.txt:- Descriptive names for the activities with a numeric link to the y_test.txt and y_train.txt data

------------------------------------------------------------------
### Data and Documentation Links
------------------------------------------------------------------
Data Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 	


==================================================================
## File Details
==================================================================

### run_analysis.R

### a)	Read data for processing
Initially the training and test data along with the features and activity labels is read into data frames.

### b)	Data Cleaning
The features data is then standardised to be readable and consistent.
All characters are made lower case and the following structure is added to a new column in the features data frame

	## character 1 : x, y, z coordinate or m for magnitude 
	## character 3-6 : time or freq(uency) 
	## character 8-11 : acce(lerator) or gyro(scope)
	## character 13-16 : body or grav(ity)
	## character 18-21 : mean or sdev (standard deviation)
	## character 23-26 : jerk or not (blank)

### c)	Name Changing
The names of the training and test data are then changed to readable values.  The revised features data is used to
give good column names to the training and test data results

### d)	Data manipulation
The training data (data, subjects and activities) is then bound together.  As is the test data.
The resulting two data sets are then bound together to create a combined data set.
From this only columns that are used as identifiers (activity and subject columns) and those data result
columns that are the result of a mean or standard deviation calculation are extracted to a final data frame, 
'train_test_2'.  This is the first data frame that is required by the project.

### e)	Aggregation of data
The data in this data set is then aggregated buy subject and activity to give a mean value for each of the data items.
Names have the prefix 'MEAN_' added to them so follow the structure

	## character 1-4: MEAN, to indicate a mean calcuation
	## character 6 : x, y, z coordinate or m for magnitude 
	## character 8-11 : time or freq(uency) 
	## character 13-16 : acce(lerator) or gyro(scope)
	## character 18-21 : body or grav(ity)
	## character 23-26 : mean or sdev (standard deviation)
	## character 28-31 : jerk or not (blank)

### f)	Write file
The data frame in (e) is then written to a text file, 'Project_mean.txt'.

==================================================================
