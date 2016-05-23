#Code Book

The code run_analysis.R executes the following actions to clean the raw data set 
 1. Loads the definitions of the 561 variables (features) from features.txt and the 6 activities from activity_labels.txt
 2. Loads the training data set components and then combines them as follows
    * Load the list of subjects from subject_train.txt
    * Load the list of activities from y_train.txt and decode these using the activity definitions from 1 above.
    * Load the training data rows consisting of 561 variables from x_train.txt and decode the variables using the features definitions from 1 above.
    * column bind the subject, activity and training data rows to form one combined set
 3. Load the test data set components and combine them using same process detailed in 2.
 4. Combine the training and test data sets using row bind
 5. 
