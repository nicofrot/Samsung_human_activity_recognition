#1
#Create a test Dataset
testData<-read.table("test/X_test.txt")
testActivityLabel<-read.table("test/y_test.txt")
testSubjects<-read.table("test/subject_test.txt")
features<-read.table("features.txt")
names(testData)<-features[,2]

testSet<-cbind(testSubjects,testActivityLabel,testData)

#Create a train Dataset
trainData<-read.table("train/X_train.txt")
trainActivityLabel<-read.table("train/y_train.txt")
trainSubjects<-read.table("train/subject_train.txt")
names(trainData)<-features[,2]

trainSet<-cbind(trainSubjects,trainActivityLabel,trainData)

#Merge to get a full dataset
fullSet<-rbind(testSet,trainSet)
names(fullSet)[1]<-'SUBJECT'
names(fullSet)[2]<-'ACTIVITY'

# 2 - Keep only the Mean() and Std() columns
fullSet<-fullSet[,grepl("ACTIVITY",names(fullSet))|grepl("SUBJECT",names(fullSet))|(grepl("mean",names(fullSet))|grepl("std",names(fullSet)))& !grepl("meanFreq",names(fullSet))]

# 3 - Clarify activities' names

activities<-read.table("activity_labels.txt")

for (i in 1:10299) {
        if (fullSet[i,2]==1){fullSet[i,2]="WALKING"}
        else if (fullSet[i,2]==2) {fullSet[i,2]="WALKING_UPSTAIRS"}
        else if (fullSet[i,2]==3) {fullSet[i,2]="WALKING_DOWNSTAIRS"}
        else if (fullSet[i,2]==4) {fullSet[i,2]="SITTING"}
        else if (fullSet[i,2]==5) {fullSet[i,2]="STANDING"}
        else if (fullSet[i,2]==6) {fullSet[i,2]="LAYING"}
}

# 4 - descriptive columns' names (already done in 1)

# 5 - Compute average per Activity and Subject:

fullSet5<-fullSet
fullSet5<-aggregate( .~SUBJECT+ACTIVITY, fullSet5, mean )

