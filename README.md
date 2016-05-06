# GettingandCleaningData
This is a markdown file explaining computational steps I took to clean up the UCI HAR Dataset.

All .txt files relevant for the analysis where placed in one folder. 
The script run_analysis.R was run and results generated.

##Step1 Import and merge test and train datasets 
I load files: X_test.txt (collected data), subject_test.txt (subject number), y_test.txt (activity label),
X_train.txt (collected data), subject_train.txt (subject number), y_train.txt (activity label)
into dataframes.

Using rbind I merge the collected training and test datasets: dataframe labelled df in the code. I also merge
subject and activity training and test sets. Dataframe df_subject is a column vector of all subjects and 
df_activity a column vector of all activity as numeric labels. Column names "activity" and "subject" are given to 
df_subject & df_activity.



