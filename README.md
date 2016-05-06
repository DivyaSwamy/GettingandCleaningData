## GettingandCleaningData
This is a markdown file explaining computational steps I took to clean up the UCI HAR Dataset.

All .txt files relevant for the analysis where placed in one folder. 
The script run_analysis.R was run and results generated.

##Step1 Import and merge test and train datasets 
I load files: X_test.txt/X_train.txt (collected data), subject_test.txt/subject_train.txt (subject number)
, y_test.txt/y_train.txt (activity label), into dataframes.

Using rbind I merge the collected training and test datasets: dataframe labelled df in the code. I also merge
subject and activity training and test sets. Dataframe df_subject is a numeric column of all subjects and 
df_activity a numeric column of all activity labels. Column names "activity" and "subject" are given to 
df_subject & df_activity.

check: dimension of df [10299 561]

## Step2 Extract only measurements of mean and standard deviation for each measurement variable. 
 
 The file features.txt has all the column names listed in it. To pull out all the mean(std) measurement columns & column names I 
 use the grep command. This allows me to subset df based on mean (stored in df_mean_ss) and std (stored in df_std_ss) measurements. 
 There are a total of 46 columns measuring mean values and 33 columns measuring std values. 
 
 Command gsub, sub and tolower are used to clean up column names. The cleaned names are then passed to  label respective columms in df_std_ss & df_mean_ss.
 
 Finally mean and std subset dataframes are merged together with df_activity and df_subject to create a 
 final dataframe to work with : df_final. All columns that are not measuring mean or std have been removed. 
 
 check: dimension of df_final [10299 81]: 
 
## Step 3: Use descriptive activity names to name the activities in the data set.
 
 I create an character array activity_label which labels the six different activities being measured. The labels were obtained from file activity_labels.txt. I substitute  the numeric activity label (1..6) for the descriptive labels at the very end, after I have processed and calculated all the relavant means.  
 
## Step4: Appropriately labels the data set with descriptive variable names.
 
 The descriptive column names were extracted from features.txt in step2.  The names were cleaned and columns in df_final appropriately labelled. See step 2 for details.
 
## Step5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

 For this step I first load library dplyr. 
 
 Split is used to split dataframe df_final by subject. This will give us a list with 30 elements, one for each subject. On each element of this list, split is used again to separate by activity. Therefore, each subject list gets subsectioned into 6 lists based on activity label. The command sapply,calling function colMeans, in a for loop, is used to calculate the average of every variable for each activity and each subject. 
 
 Check:The final Matrix has dimensions of [180,81].The number of rows equal the number of subjects(30) times the number of activity recorded (6). 

 Once the matrix is created, I rearrange the columns making subject the first column and activity the second. 
 
 I convert the final matrix into a data table, and give the activity column descriptive labels. 
 
 Finally write.table() is used to create the final tidy  .txt file: FinalTidyDataSet.txt



 
