---
title: "SamsungTidyData"
output: html_document
---
Notice that the script depends on the plyr library. Please install it and all dependencies before using it.

1. Extract the feature names from "features.txt" into a data frame.
2. Only the feature names are interesting, so make a vector with those (removing the first column from the file, which is just a sequential number list). Since they are ordered, we will use that later for giving descriptive names to the features. With this, we have a feature name lookup vector.
3. Read the training dataset from "train/X_train.txt". Since it's big, use scan rather than the read. functions (which are a lot more memory consuming)
4. Read the test dataset from "test/X_test.txt" (with the same function)
5. Since both datasets have the same column order, merge them by rows with rbind (we'll assume from now on that the training dataset precedes the test dataset). We are working still with matrixes and not dataframes to save memory. **The datasets are now merged, and step 1 is done**
6. From the feature names vector, select the ones that contain "mean()" or "std()". Create a new name vector with only those ones, and subset the matrix so it only has those columns **The columns are now extracted, and step 2 is done**
7. The activities come in separate files. Read the training activities from "train/Y_train.txt" file with scan. 
8. Read the test activities from "test/Y_test.txt" file with scan.
9. Merge then in a single vector with c(), making sure to put train before test as we did for the main dataset. 
10. Since the numbers are not descriptive, read the activity names from "activity_labels.txt"
11. As before, only take the second column, since the first one is a non-interesting sequential number list. With that, we have an activity label lookup vector. 
12. In the merged activity vector, replace the number with the corresponding label in the lookup vector. **The activity vector is now descriptive and Step 3 is done**
13. The subject data comes in another file. Extract the train subjects from "train/subject_train.txt"
14. Extract the test subjects from "test/subject_test.txt"
15. Merge these two vectors into the one for the merged dataset, putting the train data before the test data. 
16. We'll now merge all these vectors and matrixes into a single dataset
17. Transform the matrix with the signal data into a Data Frame with all columns numeric (which we will call Merged Dataset from now on)
18. We prepare clean names for this dataset, doing the following replacements with regular expressions on the feature names vector we made before. Our target is names with little to none abbreviations, all in lowercase and using '-' as separator between words for clarity (for example, a target column name is : "frequency-body-gyroscope-mean-x-axis" )
    * Replace fBodyBody with fBody as is seems to be a mistake in the original data
    * Replace the leading t with "time-"
    * Replace the leading f with "frequency-"
    * Replace "Acc" with "accelerometer-"
    * Replace "Gyro" with "gyroscope-"
    * Replace "Gravity" with "gravity-"
    * Replace "Body" with "body-"
    * Replace "Jerk" with "jerk-"
    * Replace "Mag" with "magnitude-"
    * Replace "-mean()" with "mean"
    * Replace "-std()" with "standard deviation"
    * Replace "-X" with "-x-axis"
    * Replace "-Y" with "-y-axis"
    * Replace "-Z" with "-z-axis"
19. Set those clean names into the Merged Dataset as column names. 
20. Add the descriptive activity names subject vector (which has the same length as the row number of the Merged Dataset) as a column with name "activity"
21. Add the merged subjects vector as another column with name "subject" (since it has the same length as the row number of the Merged Dataset). We have now a dataset with all data for each subject and activity. **Step 4 is now complete**
22. Use plyr library to summarize this dataset into a second different tidy dataset, using the activity and subject columns as the variables, and average of all other numerical columns (using numcolwise) as the resulting columns. This produces a table with the average of all measurements we selected divided by subject and activity name. The dataset has all subjects performing all activities. (which was a precondition of the assigment)
23. This dataset is tidy because: 
    * Each variable is on a different column
    * Each observation (in this case, means of different values for each subject and activity) is on a different row
    * There is only one kind of data, and so one table. 
24. Therefore, we save the resulting dataset into file "TidyResults.txt"**Step 5 is now complete** 