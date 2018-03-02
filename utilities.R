# Utility functions
append_data <- function(base_path, train_file_name, test_file_name) {
        train_data <- read_data(base_path, train_file_name)
        test_data <- read_data(base_path, test_file_name)
        result <- rbind(train_data, test_data)
        result
}

get_valid_features <- function(base_path, features_file_name){
        features <- read_data(base_path, features_file_name)
        
        # we only want the second column with the name
        features <- features[,2]
        get_mean_and_std_features(features) 
}

clean_feature_names <- function(features) {
        # Removing parenthesis
        features_names <- gsub("\\(\\)", "", features$names)
        features$names <- features_names
        features
}

get_mean_and_std_features <- function(features){
        mean_std_indexes <- grep("[mean|std]\\(\\)", features)
        mean_std_names <- grep("[mean|std]\\(\\)", features, value = TRUE)
        
        result <- list("indexes"=mean_std_indexes, "names"=mean_std_names)
        result
}

set_activities_labels <- function(activities, labels) {
        get_label <- function(value){ labels[value, 2] }
        
        sapply(activities, get_label)
}

read_data <- function(base_path, file_name) {
        path <- file.path(base_path, file_name)
        data <- read.table(path)
        data
}