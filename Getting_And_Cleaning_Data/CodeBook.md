## This file explains the variables and transformations in the run_analysis.R program

The different variables are labeled as per the following files:

*1- y as 'activity' : levels as per activity_labels.txt.*
*2- subject as 'subject'.*
*3- x variables named as per "features.txt".*

I subsetted the x variables using grep with "mean(" and "sd(", combined them with subject and y vectors and then merged training and test data sets. This gave me a 10299 x 66 dataframe.

Using the gather function from tidyr I stacked the variables & values for each subject and activity. Then using the group_by and summarize commands from dplyr package I created a dataset with average variable value for each of the 30 subjects and each of the 6 activities.

