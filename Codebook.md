---
title: "GetCleanDataProject1"
author: "Trevor McCalmont"
date: "Wednesday, March 18, 2015"
output: html_document
---

# Getting and Cleaning Data Course Project

## Data Collection

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Attribute Information

For each variable of the original, untidy data set, the following is provided:

-Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# run_analysis.R

## Part 1 - Merge the Test and Train data sets to create one data set

Read in the 8 tables with the untidy data.
Training set:   xTrain.txt, yTrain.txt, subjectTrain.txt
Testing set:    xTest.txt, yTest.txt, subjectTest.txt
Labels:         activityLabels.txt, features.txt

Merge the training and testing data sets and add the appropriate labels from the activityLabels and features tables.

## Part 2 - Extract only the measurements on the mean and standard deviation

We only want the mean and standard deviation measurements from the untidy data set, so using the grep function we can extract these column names.

## Part 3 - Use descriptive activity names to name the activities in the data set

We can merge the activities from activityLabels.txt to give more descriptive names to the activities

## Part 4 - Change the original column names to descriptive variable names

Using the gsub function we can improve the descriptions of the column names. Any variable that starts with a t is a measurement of the Time Domain, any variable that starts with an f is a measurement of the Frequency Domain, Acc is shorthand for Acceleration, Mag is shorthand for Magnitude, and std is shorthand for Standard Deviation. We also removed unnecessarily parentheses for clarity.

## Part 5 - Create new tidy data set with the average of each variable for each activity and subject

Lastly we take the average of each variable for each activity and subject from our tidy data set.
