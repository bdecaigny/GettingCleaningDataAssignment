#run_analysis.R
run_analysis <- function() {
library(plyr)
#list of files to load
# test/subject_test.txt
test_pop <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# test/X_test.txt
test_xt <- read.table("./UCI HAR Dataset/test/X_test.txt")
# test/y_test.txt
test_yt <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_pop <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_xt <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_yt <- read.table("./UCI HAR Dataset/train/y_train.txt")

#getting the names of the features
feat <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactor = FALSE)
featnames <- feat[,"V2"]
#getting only the mean() and std() ones out
right <- grepl("mean()|std()",featnames)
rightnames <- featnames[right]

#renaming columns
colnames(train_yt) <- "activity"
colnames(train_pop) <- "subject"
colnames(test_yt) <- "activity"
colnames(test_pop) <- "subject"
#adding them to the tables
test_xt$subject <- test_pop$subject
test_xt$activity <- test_yt$activity
train_xt$subject <- train_pop$subject
train_xt$activity <- train_yt$activity

# was in doubt to add a column to indicat whether they were originally 'test' or
# 'train' subject, but as the Readme explicitly says:
#       "The obtained dataset has been randomly partitioned into two sets, where
#         70% of the volunteers [..]"
#I figured it had no actual additional value, thus left it out.
# #add a column to indicate who is test & who is train, before merging everything
# static_test <- rep("test",times = length(test_xt[,1]))
# static_train <- rep("train",times = length(train_xt[,1]))
# # and also add them to the tables
# test_xt$group <- static_test
# train_xt$group <- static_train

#creating one dataset
total <- rbind(test_xt,train_xt)

#drop columns without mean() or std() in
for (k in 1:length(right)) {
        if (!right[k]) {
                cal <- paste("V",as.character(k), sep="")
                total <- total[-match(cal,names(total))]
        }
}

#correct the names list
rightnames <- append(rightnames, c("subject","activity"))
colnames(total) <- rightnames

#replacing the activity names
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactor = FALSE)
colnames(activities) <- c("activity","activity_type")
labeled <- arrange(join(total, activities), activity)
#since it is only an number, remove activity
labeled <- labeled[-match("activity",names(labeled))]
#reorder, since it looks a lot nicer with subject ref & activity type in the first columns
reordered <- labeled[,c(80,81,1:79)]

#maybe not strictly necessary, but cleaning up some of the large dataframes wouldn't hurt
remove(labeled)
remove(total)
remove(test_xt); remove(test_yt)
remove(train_xt); remove(train_yt)
remove(test_pop); remove(train_pop)
remove(feat); remove(featnames)
remove(right); remove(rightnames)

#aggregating is only a small step
tidy <- aggregate(. ~ subject + activity_type, data = reordered, FUN = mean)

#and finally, write it out...
write.table(tidy, file="tidy_data.txt",row.names=FALSE)
# tidy
}