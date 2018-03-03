# Tidyng the Human Activity Recognition Dataset
## Dataset Description
This repo shows R scripts for tyding the "Human Activity Recognition Using Smartphones" dataset. 

The dataset has data collected from the accelerometers from the Samsung Galaxy S smartphone by:
* Smartlab - Non-Linear Complex Systems Laboratory
* CETpD - Technical Research Centre for Dependency Care and Autonomous Living

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person 
performed six activities while wearing the smartphone: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and 
LAYING.

Using the accelerometer and gyroscope in the smartphones, 3-axial linear acceleration and 3-axial angular velocity were captured. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The dataset includes a list of files where the following are involved in the tyding process:

#### General
* _README.txt_
* _features.txt_: List of all features.
* _activity_labels.txt_: Links the class labels with their activity name.
* _features_info.txt_: Shows information about the variables used on the feature vector.
#### Training
* _train/X_train.txt_: Training set.
* _train/y_train.txt_: Training labels.
* _train/subject_train.txt_: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
#### Test
* _test/X_test.txt_: Test set.
* _test/y_test.txt_: Test labels.
* _test/subject_train.txt_: Test subjects where, as the train subjects, they identify the subject who performed the activity for each window sample. 

A full description of the dataset can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Requirements
The tidy process requires an R script that follows these requirements:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## Files involved on the tidy process
The tidy process was specified in two files, the high-level process of tidying data in the __run_analysis.R__ file and the low-level functions in the __utilities.R__. 
This file assumes that the data is in the running directory under the name __UCI_HAR_Dataset__, and that the __utilities.R__ script is also in the current directory. 
The dataset is commonly distributed in a zip format, these scripts work with directly with their directories, so you need to decompress the dataset before to being able of executing the scripts.
Therefore, the content of this project involves:
* _run_analysis.R_: main script.
* _utilities.R_: utilities and low level functions.
* _CodeBook.md_: A description of the variable names and the general tidy process.

Executing the _run_analysis.R_ will produce two text files: main_data.txt and avg_data.txt. Who contains the general tidy dataset and the independent dataset from step 5. 
This files can be read back into R with the following code:
```
main_data <- read.table(path_to_main_data.txt, header = TRUE)
View(main_data)
```
To see an overview of the general transformations applied to the dataset you can see the CodeBook.md file.
