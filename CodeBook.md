# CodeBook

## run_analysis.R
### Variables
* _dataset_path_: This is the path where all the data is stored, by default it searches the dataset under the current directory and with the name __UCI_HAR_Dataset__
* _train_file_: The path and file name of the training set. The dataset stores it under the train directory so his default value is: ```train/X_train.txt```
* _test_file_: The path and file name of the test set. The dataset stores it under the test directory so his default value is: ```test/X_test.txt```
* _features_file_: The path and name of the file with the list of all features, the script search the file under the current directory and by default it's value is: ```features.txt```
* _train_subject_file_: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. This variable stores the subjects for the train set. It's default value is: ```train/subject_train.txt```
* _test_subject_file_: Stores the subjects for the test set. It's default value is: ```test/subject_test.txt```
* _train_activities_file_: Specifies the path for the file with the activities id's for the train set. It's default value is: ```train/y_train.txt```
* _test_activities_file_: Specifies the path for the file with the activities id's for the test set. It's default value is: ```test/y_train.txt```
* _activity_labels_file_: The variable stores the path of the file who links the class labels with their activity name. The default value is: ```activity_labels.txt```
* _main_data_: Stores the combination of the train and test set.
* _features_: Stores the data obtained through the reading of the features_file.txt.
* _subject_data_: Stores the combination of the subjects for the train and test sets. 
* _activities_data_: Stores the combination of the activities for the train and test sets. 
* _avg_data_: Independent tidy data set with the average of each variable for each activity and each subject.

### Tidy Process
The main tidy process is specified by the run_analysis.R file. This file follows the following flow of activities:
1. As described previously, the data is partitioned into multiple txt files, at the start of the script we specify the base path and the names of the required files.
2. The dataset is splitted in the training and test set. So we merge the datasets through the append_data function defined in the utilities. R file, who is describe in the next section.
3. The features, that are the variable names of the dataset, are read with the get_valid_features function, part the utilities.R code. This function filters the variable names in order to get only the ones related with the average and standard deviation of each measure. The variable names follow a pattern that makes easy to apply regular expressions to extract the ones who have the __mean__ or __std__ words.
For the second requirement, we don't consider the variables that include __meanFreq()__, mainly because thesee are the variables that describe the weighted average of the frequency components to obtain a mean frequency, not the concrete average of measure as the __mean()__ variable name especifies.
4. The function clean_features_names removes the parenthesis of the variable names in order to make a little more easy to work with them.
5. The train and test data related with the subjects are combined with the append_data function.
6. The train and test data of the activities are combined too, but in this case the activities are represented by id. An external file relates the activity name with their id. So, with the function set_activities_labels, we can replace the id's with his corresponding name.
7. Using the indexes for the features that represent a mean or a standard deviation we get a subset of the dataset with only those columns.
8. We combine the datasets, we combine first the columns for the fixed variables, like the subject and activity
and later on, the data of the measurements.
9. The variable names are added manually for the subject and activity variables, for the measurements we use the names of the
features previously filtered by mean and std and later cleaned.
10. The final requirement asks for a second dataset with the average for each activity and subject so we use some dplyr functions, first we group by the required variables and summarise_all, provides a concise way to apply the mean function to all the variables without the need of specifying their names.

You can open the file

### Notes:
We can observe that some of the variables violate the rules of tidy data, mainly the principle that states that multiple values don't have to be in one column, here's an example:
* tBodyAcc-mean-X
* tBodyAcc-mean-Y
* tBodyAcc-mean-Z

In order to solve this we could split the columns, but this variables aren't completely independent, ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions) and decomposing the variable names  would introduce a significant amount of NA's.

## utilities.R
In order to group some common steps and concentrate the main flow of the tidy process in the run_analysis file, 
the helper functions where encapsulated in utilities.R

* ```append_data```
A common pattern, given that the data was splitted in multiple files, was to read two diferent files, create their
datasets and merge their rows, so this function encapsulates this behavior.

* ```get_valid_features```
This function it's an interface between the features file and the processing his content through regular expressions. 
It the reads and calls the low level function ```get_mean_and_std_features```.

* ```get_mean_and_std_features```
Using regular expressions we can find the variable names who have have the "mean" or "std" words followed by parenthesis.

* ```clean_feature_names```
Most of the variables end with a parenthesis, clean feature names removes it.

* ```set_activities_labels```
The labels of the activities are ordered by their id, so here we define an anonymous function that based on the activity id
returns their label. The function, then it's applied to every observation for the activity variable. 

* ```read_data```
Joins a file name with their base path, then it reads the file and return his data as a dataframe.

* ```write_data```
Takes the data and writes a txt file. The row.names parameter is configured to FALSE.
