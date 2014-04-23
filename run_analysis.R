# You should create one R script called run_analysis.R that does the following. 
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(hash)

## Activity Labels:
# h <- hash ( 
# 1 = "WALKING",
# 2 ="WALKING_UPSTAIRS",
# 3 = "WALKING_DOWNSTAIRS",
# 4 = "SITTING",
# 5 = "STANDING",
# 6 = "LAYING")

h <- hash ( keys = 1:6,
    values= c( "WALKING",
    "WALKING_UPSTAIRS",
    "WALKING_DOWNSTAIRS",
    "SITTING",
     "STANDING",
    "LAYING"))
values(h,c(1,3,5,6,2))

library(data.table)
files <- c("./test/X_test.txt",
           "./train/X_train.txt",
           "./test/y_test.txt",           
           "./train/y_train.txt",
           "./test/subject_test.txt",
           "./train/subject_train.txt"
           )

features <- read.table("./features.txt",sep="",stringsAsFactors=F)
##features[grep("-mean()",as.vector(unlist(features[2])),value=F),]
##features[grep("-std()",as.vector(unlist(features[2])),value=F),]


f1  <- read.table(files[1],header=F,sep="")
f2C <- rbind(read.table(files[2],header=F,sep=""),f1)
colnames(f2C) <- as.vector(unlist(features[2]))
f3  <- read.table(files[3],header=F,sep="",col.names="Y")
f4C <- rbind(read.table(files[4],header=F,sep="",col.names="Y"),f3)

f5  <- read.csv(files[5],header=F,col.names="Subject")
f6C  <- rbind(read.csv(files[6],header=F,col.names="Subject"),f5)

fF  <- cbind(f2C,f4C)
fF$ActivityDesc <- as.vector(values(h, fF$Y))
fFi <- cbind(fF,f6C)
Reduced <- fFi[,c(562:564,grep("-mean()",as.vector(unlist(features[2])),value=F),
                  grep("-std()",as.vector(unlist(features[2])),value=F))]

ReducedMeans <- sapply(split(Reduced[,4:82], list(Reduced$ActivityDesc, Reduced$Subject)), colMeans)
write.table(ReducedMeans,"C:/Users/Owner/Desktop/UCIHARDataset/TidyData.csv",row.names=F,sep=",",eol = "\n",col.names = TRUE)











