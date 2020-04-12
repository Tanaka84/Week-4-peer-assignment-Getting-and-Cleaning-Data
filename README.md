Getting and Cleaning Data Course Project

This repository is Gustavo La Fontaine's project for Getting and Cleaning Data peer graded asssignment. It has the outcomes of the analysis as well as the instructions to use the script to reproduce the results.

Dataset

Human Activity Recognition Using Smartphones Data Set by Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)

Source

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files

    CodeBook.md is a codebook describing what the dataset contains, how the dataset was transformed into variables, describes the variables, and describes in detail how the data is cleaned up to fulfill the course requirements.

    run_analysis.R is an R script that loads the required packages, downloads the data, unzips it, turns it into variables and then follows the 5 steps as described in the course project’s definition:
        Merges the training and the test sets to create one data set.
        Extracts only the measurements on the mean and standard deviation for each measurement.
        Uses descriptive activity names to name the activities in the data set
        Appropriately labels the data set with descriptive variable names.
        From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    tdatamean.txt is the exported final data created by the run_analysis.R script

