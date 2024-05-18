GETTING AND CLEANING DATA : COURSERA    

The purpose of this project is to show our ability to collect, work with and clean a data set, in order to prepare a tidy data set for a later analysis.

The data used in this project have been collected from the accelerometer and gyroscope of the smartphone (Samsung Galaxy S II).

The repository contains the following files :

README.md : provides an overview of the data set and how it was created
CodeBook.md : describes the contents of the data set (data, names of variables, transformation over data set)
run_analysis.R : the R script enables to perform transformation over data
tidy_data.txt : is the data output (the file containing final data set) 

Informations over data set :

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Creating the data set

R script using R version 4.3.2 (2023-10-31 ucrt) on Windows 8.1 64-bit edition.
This script requires the dplyr package.

The R script run_analysis.R can be used to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

Download and unzip source data if it doesn't exist.
Read data.
Merge the training and the test sets to create one data set.
Extract only the measurements on the mean and standard deviation for each measurement.
Use descriptive activity names to name the activities in the data set.
Appropriately label the data set with descriptive variable names.
Create a second, independent tidy set with the average of each variable for each activity and each subject.
Write the data set to the tidy_data.txt file.
The tidy_data.txt in this repository was created by running the run_analysis.