library(dplyr)

#Read in the files

trainingSet<-read.table("./train/X_train.txt")
trainingLabels<-read.table("./train/Y_train.txt")
testSet<-read.table("./test/X_test.txt")
testLabels<-read.table("./test/Y_test.txt")
Variables<-read.table("./features.txt")
ActivityTypes<-read.table("./activity_labels.txt")


#Merge training set and test set, whose data table names are 
#trainingSet and testSet, respectively. Call the new set allData.


allData<-rbind(trainingSet,testSet)

#Apply appropriate variable names. 
#Note that the set of variable names are the second column of the features.txt file.


colnames(allData)<-Variables$V2


#Make the vector of activities for each observation.
#Then make it into a factor. 
#Replace the numeric factor levels with the descriptive ones.
#Finally, add these activity names to the data set and give the appropriate variable/column name.

allActivities<-rbind(trainingLabels,testLabels)
allActivities<-factor(unlist(allActivities))
levels(allActivities)<-levels(ActivityTypes[,2])
allData<-cbind(allActivities,allData)
colnames(allData)[1]<-"Activity"



#Extract columns which whose values are the mean or standard deviation of the measurement.
#Use names() to match the variable names accordingly.
#Don't forget to include the activity for each row!
#This data includes both mean() and meanFreq(). 
#Many times the weighted average (meanFreq) is a more accurate measure than the mean of unique values.  


Means_Stds_Of_AllData<-cbind(allData[1],allData[grepl("mean|std",names(allData))])

#Time to clean the variable names with another script called VariableNameChange.R.

source("VariableNameChange.R")
TempNames<-names(Means_Stds_Of_AllData)
names(Means_Stds_Of_AllData)<-CleanNames(TempNames)

#Create a new data set whose values are the means of the means 
#and standard deviations in the data set above among each activity. 

Grouped_Means<-group_by(Means_Stds_Of_AllData,Activity)%>%summarize_each(funs(mean))



