library(dplyr)

setwd("~/Documents/coursera/dataScience/DataCleaning")
source("./utilities.R")

# Paths and filenames
dataset_path <- "./UCI_HAR_Dataset"

train_file <- "train/X_train.txt"
test_file <- "test/X_test.txt"

features_file <- "features.txt"

train_subject_file <- "train/subject_train.txt"
test_subject_file <- "test/subject_test.txt"

train_activities_file <- "train/y_train.txt"
test_activities_file <- "test/y_test.txt"
activity_labels_file <- "activity_labels.txt"



main_data <- append_data(dataset_path, train_file, test_file)

features <- get_valid_features(dataset_path, features_file)
features <- clean_feature_names(features)

subject_data <- append_data(dataset_path, train_subject_file, test_subject_file)

activities_data <- append_data(dataset_path, train_activities_file, test_activities_file)
activity_labels <- read_data(dataset_path, activity_labels_file)
activities_data <- set_activities_labels(activities_data, activity_labels)

main_data <- main_data[, features$indexes]
main_data <- cbind(subject_data, activities_data, main_data)
names(main_data) <- c("subject", "activity", features$names)

avg_data <- main_data %>%
        group_by(activity, subject) %>%
        summarise_all(mean)


