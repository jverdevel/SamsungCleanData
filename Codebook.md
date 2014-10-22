---
title: "Code Book for Samsung Tidy Data"
output: html_document
---
##Raw data description##
The original data used in this experiment can be obtained at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data was aditionally compiled at this address for the Coursera 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The original data contains signal data for the Samsung Galaxy Cellphone extracted from its accelerometer and gyroscope, analyzing the signals from the device when test subjects between 19 and 48 years old were performing certain activities. This data was then transformed into different signal measures.A full description of the data is avaiblable on the original file. 

##Transformations performed##
1. The feature names were extracted from "features.txt"
2. The signal data for the training dataset was extracted from "train/X_train.txt"
3. The signal data for the testing dataset was extracted from "train/y_train.txt"
4. Both datasets were combined into one data matrix. Since the column order is the same in both datasts, the testing datasets was simply bound after the training dataset's rows.  
5. From the original feature names, the ones that have "mean()" or "std()" on name, were selected since the target columns are the ones containing mean or standard deviation information. 
6. The columns from the merged dataset corresponding to the selected column names were selected(the order in "features.txt" is the same as the columns in the data files, as indicated in the original data codebook)
7. The activity data from "train/Y_train.txt" was extracted for the training dataset into a vector.
8. The activity data from "test/Y_test.txt" was extracted for the testing dataset into a vector.
9. The activity vectors were merged, binding the testing vector after the training dataset, to keep the order consistant with the merged signal data matrix, resulting in a merged activity vector. 
10. The activity names from "activity_labels.txt" were extracted.
11. The numbers in the activity vector were replaced with the correspondending labels extracted from the previous label file.
12. The training subjects from "train/subject_train.txt" were extracted into a vector.
13. The testing subjects from "test/subject_test.txt" were extracted into a vector.
14. The vectors were merged, binding the testing vector after the training vector, consistently with the previous datasets, resulting in merged training subject vector. 
15. The data matrix was transformed into a numeric dataframe with all columns numeric. 
16. The feature names vector was cleaned, using the following transformations (resulting in a clean names vector): 
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
17. The clean names vector was put into the dataframe as column names. 
18. The descriptive activity names merged vector was added as a new character column to the dataframe, with name "activity"
19. The merged subjects vector was added as a new numeric column to the dataframe, with name "subject"
20. Using plyr, a summary dataset was created, using the subject and activity as the keys and the sum of the rest of the columns as the other columns, resulting in a different summarized dataset with a row for each combination of subject and activity, and the average value for all the values for each different column that have a corresponding subject and activity. 
21. The dataset is saved into "TinyResults.txt" with the standard write.table function


##Variables in resulting dataset##
The resulting dataset contains 180 rows and 68 columns. Each row represents the means of all the observations on the original Samsung Tidy Data for each unique pair of subject performing the tests and each activity they were performing. Test and training data were merged, and considered the same for the creation of this dataset. 
All columns, except Activity and Subject, are signal data normalized between [-1,1]. Activity and Subjects stand for different IDs on the activity performed and the subject performing it, and therefore, have no units. All the signal column names are composed by self-explanatory particles, and should be human-readable without the codebook. For reference, the exact information contained on each column follows: 

* *time-body-accelerometer-mean-x-axis*: mean of the means of the accelerometer body acceleration time domain signal for the X axis.                            
* *time-body-accelerometer-mean-y-axis*: mean of the means of the accelerometer body acceleration time domain signal for the Y axis.                              
* *time-body-accelerometer-mean-z-axis*: mean of the means of the accelerometer body acceleration time domain signal for the Z axis.                              
* *time-body-accelerometer-standard-deviation-x-axis*: mean of the standard deviations of the accelerometer body acceleration time domain signal for the X axis.                 
* *time-body-accelerometer-standard-deviation-y-axis*: mean of the standard deviations of the accelerometer body acceleration time domain signal for the Y axis.               
* *time-body-accelerometer-standard-deviation-z-axis*: mean of the standard deviations of the accelerometer body acceleration time domain signal for the Z axis.               
* *time-gravity-accelerometer-mean-x-axis*: mean of the means of the accelerometer gravity acceleration time domain signal for the X axis.                        
* *time-gravity-accelerometer-mean-y-axis*: mean of the means of the accelerometer gravity acceleration time domain signal for the Y axis.                         
* *time-gravity-accelerometer-mean-z-axis*: mean of the means of the accelerometer gravity acceleration time domain signal for the Z axis.                         
* *time-gravity-accelerometer-standard-deviation-x-axis*: mean of the standard deviations of the accelerometer gravity acceleration time domain signal for the X axis.          
* *time-gravity-accelerometer-standard-deviation-y-axis*: mean of the standard deviations of the accelerometer gravity acceleration time domain signal for the Y axis.              
* *time-gravity-accelerometer-standard-deviation-z-axis*: mean of the standard deviations of the accelerometer gravity acceleration time domain signal for the Z axis.               
* *time-body-accelerometer-jerk-mean-x-axis*: mean of the means of the accelerometer body acceleration jerk time domain signal for the X axis.                        
* *time-body-accelerometer-jerk-mean-y-axis*: mean of the means of the accelerometer body acceleration jerk time domain signal for the Y axis.                         
* *time-body-accelerometer-jerk-mean-z-axis*: mean of the means of the accelerometer body acceleration jerk time domain signal for the Z axis.                          
* *time-body-accelerometer-jerk-standard-deviation-x-axis*: mean of the standard deviations of the accelerometer body acceleration jerk time domain signal for the X axis.        
* *time-body-accelerometer-jerk-standard-deviation-y-axis*: mean of the standard deviations of the accelerometer body acceleration jerk time domain signal for the Y axis.        
* *time-body-accelerometer-jerk-standard-deviation-z-axis*: mean of the standard deviations of the accelerometer body acceleration jerk time domain signal for the Z axis.        
* *time-body-gyroscope-mean-x-axis*: mean of the means of the gyroscope body acceleration time domain signal for the X axis.                               
* *time-body-gyroscope-mean-y-axis*: mean of the means of the gyroscope body acceleration time domain signal for the Y axis.                                
* *time-body-gyroscope-mean-z-axis*: mean of the means of the gyroscope body acceleration time domain signal for the Z axis.                                
* *time-body-gyroscope-standard-deviation-x-axis*: mean of the standard deviations of the gyroscope body acceleration time domain signal for the X axis.                  
* *time-body-gyroscope-standard-deviation-y-axis*: mean of the standard deviations of the gyroscope body acceleration time domain signal for the Y axis.                  
* *time-body-gyroscope-standard-deviation-z-axis*: mean of the standard deviations of the gyroscope body acceleration time domain signal for the Z axis.                  
* *time-body-gyroscope-jerk-mean-x-axis*: mean of the means of the gyroscope body acceleration time domain jerk signal for the X axis.                          
* *time-body-gyroscope-jerk-mean-y-axis*: mean of the means of the gyroscope body acceleration time domain jerk signal for the Y axis.                           
* *time-body-gyroscope-jerk-mean-z-axis*: mean of the means of the gyroscope body acceleration time domain jerk signal for the Z axis.                           
* *time-body-gyroscope-jerk-standard-deviation-x-axis*: mean of the standard deviations of the gyroscope body acceleration time domain jerk signal for the X axis.            
* *time-body-gyroscope-jerk-standard-deviation-y-axis*: mean of the standard deviations of the gyroscope body acceleration time domain jerk signal for the Y axis.            
* *time-body-gyroscope-jerk-standard-deviation-z-axis*: mean of the standard deviations of the gyroscope body acceleration time domain jerk signal for the Z axis.            
* *time-body-accelerometer-magnitude-mean*: mean of the means of the magnitudes of the accelerometer body acceleration time domain signal.                          
* *time-body-accelerometer-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the accelerometer body acceleration time domain signal.             
* *time-gravity-accelerometer-magnitude-mean*: mean of the means of the magnitudes of the accelerometer gravity acceleration time domain signal.                        
* *time-gravity-accelerometer-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the accelerometer gravity acceleration time domain signal.       
* *time-body-accelerometer-jerk-magnitude-mean*: mean of the means of the magnitudes of the accelerometer body acceleration time domain jerk signal.                    
* *time-body-accelerometer-jerk-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the accelerometer body acceleration time domain jerk signal.      
* *time-body-gyroscope-magnitude-mean*: mean of the means of the magnitudes of the gyroscope body acceleration time domain signal.                            
* *time-body-gyroscope-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the gyroscope body acceleration time domain signal.             
* *time-body-gyroscope-jerk-magnitude-mean*: mean of the means of the magnitudes of the gyroscope body acceleration time domain jerk signal                       
* *time-body-gyroscope-jerk-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the gyroscope body acceleration time domain jerk signal          
* *frequency-body-accelerometer-mean-x-axis*: mean of the means of the accelerometer body acceleration frequency domain signal for the X axis.                       
* *frequency-body-accelerometer-mean-y-axis*: mean of the means of the accelerometer body acceleration frequency domain signal for the Y axis.                        
* *frequency-body-accelerometer-mean-z-axis*: mean of the means of the accelerometer body acceleration frequency domain signal for the Z axis.                       
* *frequency-body-accelerometer-standard-deviation-x-axis*: mean of the standard deviations of the accelerometer body acceleration frequency domain signal for the X axis.        
* *frequency-body-accelerometer-standard-deviation-y-axis*: mean of the standard deviations of the accelerometer body acceleration frequency domain signal for the Y axis.             
* *frequency-body-accelerometer-standard-deviation-z-axis*: mean of the standard deviations of the accelerometer body acceleration frequency domain signal for the Z axis.             
* *frequency-body-accelerometer-jerk-mean-x-axis*: mean of the means of the accelerometer body acceleration frequency domain jerk signal for the X axis.                       
* *frequency-body-accelerometer-jerk-mean-y-axis*: mean of the means of the accelerometer body acceleration frequency domain jerk signal for the Y axis.                   
* *frequency-body-accelerometer-jerk-mean-z-axis*: mean of the means of the accelerometer body acceleration frequency domain jerk signal for the Z axis.                 
* *frequency-body-accelerometer-jerk-standard-deviation-x-axis*: mean of the standard deviations of the accelerometer body acceleration frequency domain jerk signal for the X axis.     
* *frequency-body-accelerometer-jerk-standard-deviation-y-axis*: mean of the standard deviations of the accelerometer body acceleration frequency domain jerk signal for the Y axis.       
* *frequency-body-accelerometer-jerk-standard-deviation-z-axis*: mean of the standard deviations of the accelerometer body acceleration frequency domain jerk signal for the Z axis.        
* *frequency-body-gyroscope-mean-x-axis*: mean of the means of the gyroscope body acceleration frequency domain signal for the X axis.                          
* *frequency-body-gyroscope-mean-y-axis*: mean of the means of the gyroscope body acceleration frequency domain signal for the Y axis.                          
* *frequency-body-gyroscope-mean-z-axis*: mean of the means of the gyroscope body acceleration frequency domain signal for the Z axis.                          
* *frequency-body-gyroscope-standard-deviation-x-axis*: mean of the standard deviations of the gyroscope body acceleration frequency domain signal for the X axis            
* *frequency-body-gyroscope-standard-deviation-y-axis*: mean of the standard deviations of the gyroscope body acceleration frequency domain signal for the Y axis             
* *frequency-body-gyroscope-standard-deviation-z-axis*: mean of the standard deviations of the gyroscope body acceleration frequency domain signal for the Z axis             
* *frequency-body-accelerometer-magnitude-mean*: mean of the means of the magnitudes of the accelerometer body acceleration frequency domain signal.                    
* *frequency-body-accelerometer-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the accelerometer body acceleration frequency domain signal.      
* *frequency-body-accelerometer-jerk-magnitude-mean*: mean of the means of the magnitudes of the accelerometer body acceleration frequency domain jerk signal.               
* *frequency-body-accelerometer-jerk-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the accelerometer body acceleration frequency domain jerk signal.   
* *frequency-body-gyroscope-magnitude-mean*: mean of the means of the magnitudes of the gyroscope body acceleration frequency domain signal.                       
* *frequency-body-gyroscope-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the gyroscope body acceleration frequency domain signal.            
* *frequency-body-gyroscope-jerk-magnitude-mean*: mean of the means of the magnitudes of the gyroscope body acceleration frequency domain jerk signal.                        
* *frequency-body-gyroscope-jerk-magnitude-standard-deviation*: mean of the standard deviations of the magnitudes of the gyroscope body acceleration frequency domain jerk signal.  
* *activity*: id of the activity performed by the subject.
* *subject*: id of the subject.