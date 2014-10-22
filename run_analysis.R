#This script uses the plyr package
run_analysis <- function(){
    library(plyr)
    #read the feature names
    features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE)
    #we are only interested in the second column, since the first one is just a number sequence    
    featureNames <- features[[2]]

    #we read both sets. Given their size, read.fwf is too big, so we'll resort to the much more memory-friendly scan
    trainingSet <- matrix(scan("UCI HAR Dataset/train/X_train.txt", n = 7352*561, quiet =  TRUE), 7352, 561, byrow = TRUE)
    testSet <- matrix(scan("UCI HAR Dataset/test/X_test.txt", n=2947*561, quiet = TRUE), 2947, 561, byrow = TRUE) #2947
    
    #Both of there are in the same order, so we can just apprent testSet to trainingSet 
    mergeSet <- rbind(trainingSet, testSet)
    
    #We are going to extract the means and standard deviations for the merged set. We'll keep it in matrix format for as long as possible to save memory and make this faster. 
    
    #Find out what columns we use. We'll use all columns containing mean() or std()
    meanStdColumns <- grepl(x=featureNames, pattern = "mean()",fixed=TRUE) | grepl(x=featureNames, pattern = "std()", fixed=TRUE)

    #Subset the matrix
    mergeSet <- mergeSet[,meanStdColumns]

    #Now we are going to get the activities. 
    trainingActivities <- scan("UCI HAR Dataset/train/Y_train.txt", n=7352, quiet = TRUE)
    testActivities <- scan("UCI HAR Dataset/test/Y_test.txt",n=2947, quiet = TRUE)

    #and merge them in a single vector 
    mergedActivities <- c(trainingActivities, testActivities)
    #We need to clean up these names. We'll read the names file and transform them into the proper names
    
    activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE, as.is=TRUE)
    #We only need the second column. 
    activityNames <- activityLabels[,2]
    
    #we'll now replace the numbers in the activities vectors for the proper names
    cleanMergedActivities <- sapply(mergedActivities, function(x) activityNames[x])

    #finally, we will extract the subjects. We will assume that the same number on the training and testing datasts stand for the same subjects, since it is not specifieds
    trainingSubjects <- scan("UCI HAR Dataset/train/subject_train.txt", n=7352, quiet = TRUE)
    testSubjects <- scan("UCI HAR Dataset/test/subject_test.txt", n=2947, quiet = TRUE)
    mergeSubjects <- c(trainingSubjects, testSubjects)
    
    #we'll now merge the necessary information into one dataset. 
    finalDataFrame <- as.data.frame(mergeSet)
    #now, we add descriptive names to the columns. we'll use the ones from the original dataset as a base, and replace the particles for proper names
    cleanNames <- featureNames[meanStdColumns]
    
    #seems to be a little mistake on the file, labeling some as fBodyBody. we fix that
    cleanNames <- gsub("fBodyBody","fBody",cleanNames)
   
    #if the label starts with t, it's time domain. if it starts with f it's frequency domain
    
    cleanNames <-gsub("^t", "time-", cleanNames)
    cleanNames <-gsub("^f", "frequency-", cleanNames)
    
    #Acc means it comes from the accelerometer, #Gyro means it comes from the gyroscope
    cleanNames <-gsub("Acc", "accelerometer-", cleanNames)
    cleanNames <-gsub("Gyro","gyroscope-", cleanNames)
    
    #Gravity and Body are self-descritive. We just format them
    cleanNames <-gsub("Gravity", "gravity-", cleanNames)
    cleanNames <-gsub("Body", "body-", cleanNames)
    
    #jerk is self descripvite. mag stands for magnitude
    cleanNames <-gsub("Jerk", "jerk-", cleanNames)
    cleanNames <-gsub("Mag", "magnitude-", cleanNames)
    
    #mean and std are also formatted
    cleanNames <-gsub("-mean\\(\\)","mean",cleanNames)
    cleanNames<- gsub("-std\\(\\)", "standard-deviation", cleanNames)
    
    #and finally, the axes
    cleanNames <- gsub("-X","-x-axis", cleanNames)
    cleanNames <- gsub("-Y","-y-axis", cleanNames)
    cleanNames <- gsub("-Z","-z-axis", cleanNames)    
    
    #we use these clean names
    colnames(finalDataFrame)<-cleanNames    
        
    #next, we add a final column with the merged activity names and another one for the subjects
    finalDataFrame$activity <- cleanMergedActivities
    finalDataFrame$subject <- mergeSubjects
    
    #now, we are going to create the result dataset for Step 5
    printableDataset <- ddply(finalDataFrame, .(activity,subject),numcolwise(mean))
        
    #and finally, we write the data on a file
    write.table(printableDataset, file="TidyResults.txt",row.name=FALSE)
}
