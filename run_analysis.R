# May 6 2016 : Divya Swaminathan 
# Code for final assignment course: Getting and Cleaning data. 
#
# All relevant .txt files I am using for the assignment, from the UCI HAR Dataset,
# have been placed in a single folder. 
#
# Step1: Merge test and train data.
  # import test data
df_test<-read.table("X_test.txt",header=FALSE)
df_test_subject<-read.table("subject_test.txt", header=FALSE)
df_test_activity<-read.table("y_test.txt",header=FALSE)
  # import train data
df_train<-read.table("X_train.txt",header=FALSE)
df_train_subject<-read.table("subject_train.txt", header=FALSE)
df_train_activity<-read.table("y_train.txt",header = FALSE)
  # Merge
df<-rbind(df_test,df_train)
df_subject<-rbind(df_test_subject,df_train_subject)
  # Change column name to subject
names(df_subject)[1]<-"subject"
df_activity<-rbind(df_test_activity,df_train_activity)
 # Change column name to activity
names(df_activity)[1]<-"activity"
##
# Step2: From merged data set df, extract only measurements of mean and standard deviation
  # Read feature list and use grep to extract colums with mean & std.
  # Add descrptive names using features.txt
    feature_list<-read.table("features.txt")
    columns_with_means<-grep("mean",feature_list$V2)
    names_with_mean<-grep("mean",feature_list$V2,value=TRUE)
    names_with_mean<-gsub("-","",names_with_mean)
    names_with_mean<-sub("\\()","",names_with_mean)
    ##
    columns_with_std<-grep("std",feature_list$V2)
    names_with_std<-grep("std",feature_list$V2,value=TRUE)
    names_with_std<-gsub("-","",names_with_std)
    names_with_std<-sub("\\()","",names_with_std)
    ##
  # Subset merged dataset: collect columns that measure mean values
    df_mean_ss<-df[,columns_with_means]
    names(df_mean_ss)<-tolower(names_with_mean)
  # Sunset merged dataset: collect columns that measure std values
    df_std_ss<-df[,columns_with_std]
    names(df_std_ss)<-tolower(names_with_std)
    ##
  # Merge mean and std data sets and also add subject & activity columns
    df_final<-cbind(df_mean_ss,df_std_ss,df_activity,df_subject)
    ##
# Step3: Set activity labels
    activity_label<-c("walking","walkingupstairs","walkingdownstairs","sitting","standing","laying")
# Step4: Desriptive names have been added; see step2 above.    
# Step5: Average over subject and activity
    library(dplyr)
    df_final<-tbl_df(df_final)
    # Split based on subject: SS is a list of 30
    SS<-split(df_final,df_final$subject)
    Mat<-NULL
    for (i in 1:length(SS)){
        dfg<-split(SS[[i]],SS[[i]]$activity) ## Split based on activity , dfg is a list of 6
        a<-sapply(dfg,colMeans)
        a<-t(a)
        Mat<-rbind(Mat,a)
    }
    # rearrange the columns; subject is column 1 and activity column2
    Mat<-Mat[,c(81,80,1:79)]
    # convert Matrix to data frame.
    Mat<-as.data.frame(Mat)
    # Label activity
      for (i in 1:length(activity_label)){
           Mat[Mat[,2]==i,2]<-activity_label[i]
         }
    Mat<-tbl_df(Mat)
    # Write text file and submit
    write.table(Mat,file="FinalTidyDataSet.txt",row.names=FALSE)
    
 
