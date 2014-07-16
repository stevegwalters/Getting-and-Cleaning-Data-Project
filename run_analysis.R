library(plyr)

message("reading activity")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("./data/UCI HAR Dataset/features.txt", quote="\"")

message("reading test data")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", quote="\"")
x_test <- read.table("./data/UCI\ HAR\ Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", quote="\"")
message("reading train data")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", quote="\"")
x_train <- read.table("./data/UCI HAR Dataset//train/X_train.txt", quote="\"")
y_train <- read.table("./data/UCI HAR Dataset//train/y_train.txt", quote="\"")
message("combining data sets")
subject_data <- rbind(subject_test, subject_train)
x_data <- rbind(x_test, x_train)
y_data <- rbind(y_test, y_train)
message("creating column names for new dataset")
colnames(subject_data) <- "id"
colnames(y_data) <- "activity"
colnames(x_data) <- features$V2

message("basic statistics")
x_data <- x_data[,grepl("mean\\(\\)", features$V2) | grepl("std\\(\\)", features$V2)]
data <- cbind(subject_data, y_data, x_data)
message("renaming columns")
new_names <- gsub("\\(\\)", "", names(data))
new_names <- gsub("^t", "time", new_names)
new_names <- gsub("^f", "frequency", new_names)
new_names <- gsub("\\-std", "Std", new_names)
new_names <- gsub("\\-mean", "Mean", new_names)
new_names <- gsub("\\-", "", new_names)
colnames(data) <- new_names
data$activity <- factor(data$activity, labels=tolower(activity_labels$V2))

# Calculate averages across columns based on subject and activity
newData <- ddply(data, .(id, activity), numcolwise(mean))
write.table(newData, file="./output.txt")
