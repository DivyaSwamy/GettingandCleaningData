# GettingandCleaningData
This is a markdown file explaining computational steps I took to clean up the UCI HAR Dataset.

All .txt files relevant for the analysis where placed in one folder. 
The script run_analysis.R was run and results generated.

#Step1 Import and merge test and train datasets 
I load files: X_test.txt/X_train.txt (collected data), subject_test.txt/subject_train.txt (subject number)
, y_test.txt/y_train.txt (activity label), into dataframes.

Using rbind I merge the collected training and test datasets: dataframe labelled df in the code. I also merge
subject and activity training and test sets. Dataframe df_subject is a numeric column of all subjects and 
df_activity a numeric column of all activity labels. Column names "activity" and "subject" are given to 
df_subject & df_activity.

check: dimension of df [10299 561]

# Step2 Extract only measurements of mean and standard deviation for each measurement variable. 
 
 The file features.txt has all the column names listed in it. To pull out all the mean(std) measurement columns & column names I 
 use the grep command. This allows me to subset df based on mean (stored in df_mean_ss) and std (stored in df_std_ss) measurements. 
 There are a total of 46 columns measuring mean values and 33 columns measuring std values. 
 
 Command gsub, sub and tolower are used to clean up column names. 
 
 Finally mean and std subset dataframes are merged together with df_activity and df_subject to create a 
 final dataframe to work with : df_final. All columns that are not measuring mean or std have been removed. 
 
 
 check: dimension of df_final [10299 81]: 
 


