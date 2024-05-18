# Libraries
library(dplyr)


# I) Merge train and test datasetsGet to create a single dataset.

### 1/ Get Data : train and test data

# create a path with the file name where are located all train data
data_Path <- "UCI HAR Dataset"

# Get train data
X_train <- read.table(file.path(data_Path, "train", "X_train.txt"), header = F)
y_lab_train <- read.table(file.path(data_Path, "train", "y_train.txt"), header = F)
sub_train <- read.table(file.path(data_Path, "train", "subject_train.txt"), header = F)

# rename sub_train column
sub_train <- sub_train %>% 
  rename(sub_ID = V1)

# Get test data
X_test <- read.table(file.path(data_Path, "test", "X_test.txt"), header = F)
y_lab_test <- read.table(file.path(data_Path, "test", "y_test.txt"), header = F)
sub_test <- read.table(file.path(data_Path, "test", "subject_test.txt"), header = F)

# rename sub_test column
sub_test <- sub_test %>% 
  rename(sub_ID = V1)

# Get features data
features <- read.table(file.path(data_Path, "features.txt"), as.is = T)

# Get activity data
Activity <- read.table(file.path(data_Path, "activity_labels.txt"))
colnames(Activity) <- c("ID", "Activity_Label")

# 1st WAY ######################################################

# Select column names to both train and test data
features <- features[, 2]
features <- t(features) # Matrix Transpose
# length(features)

colnames(X_train) <- features
colnames(X_test) <- features

# row bind x_train and x_test
combine_X <- rbind(X_train, X_test)
# row bind y_train and y_test
combine_Y <- rbind(y_lab_train, y_lab_test) # V1
# row bind sub_test and sub_train
combine_Subj <- rbind(sub_test, sub_train)

# Column bind Y, X and Subject
XYS_df <- cbind(combine_X, combine_Y, combine_Subj)

# --------------------------------------------------------------
# Merge Data
MERGE_df <- merge(XYS_df, Activity, by.x = "V1", by.y = "ID")
# --------------------------------------------------------------

### 2) Getting the mean and standard deviation

colNames <- colnames(MERGE_df)

df2 <- MERGE_df %>% 
  select(Activity_Label, sub_ID, grep("\\bmean\\b|\\bstd\\b", colNames))

### 3)  Use description activity names to name the activities in the data set
df2$Activity_Label <- as.factor(df2$Activity_Label)
glimpse(df2$Activity_Label)

### 4) Appropriately label data set with descriptive variable names

colnames(df2) <- gsub("^t","time", colnames(df2))
colnames(df2) <- gsub("^f", "frequency", colnames(df2))
colnames(df2) <- gsub("^Acc", "Accelerometer", colnames(df2))
colnames(df2) <- gsub("^Gyro", 'Gyroscope', colnames(df2))
colnames(df2) <- gsub("^BodyBody", "Body", colnames(df2))


### 5) Create a second data set with the average of each variable activities in data set

# Method 1
df2.1 <- aggregate(. ~ Activity_Label+sub_ID, data = df2, mean)
# Method 2
df2.1 <- df2 %>% 
  group_by(Activity_Label, sub_ID) %>% 
  summarise_all(.funs = mean)

# Write table
write.table(df2.1, "df_tidy_data.txt", row.names = F, quote = F)

# 2 nd WAY #####################################################


