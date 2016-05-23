#Code Book

##Run analysis process
The code run_analysis.R executes the following actions to clean the raw data set 
 1. Loads the definitions of the 561 variables (features) from features.txt and the 6 activities from activity_labels.txt
 2. Loads the training data set components and then combines them as follows
    * Load the list of subjects from subject_train.txt
    * Load the list of activities from y_train.txt and decode these using the activity definitions from 1 above.
    * Load the training data rows consisting of 561 variables from x_train.txt and decode the variables using the features definitions from 1 above.
    * column bind the subject, activity and training data rows to form one combined set
 3. Load the test data set components and combine them using same process detailed in 2.
 4. Combine the training and test data sets using row bind
 5. Creates a clean set consisting of only mean and standard deviation variables. There are 73 variables out of the 561 which meet this criteria
 6. Appropriately labels the variables ensuring that: 
    * all lower case names
    * there are no spaces, underscores or dots
    * names are descriptive
    * variables are not duplicated
 7. Writes the resulting tidy set to a text file named tidy_fitness_data.txt
 8. Creates a second tidy set which is the average of each variable summarised per subject per activity, and writes this out to a second text file named tidy_fitness_data_averages_per_subject_activity.txt. This includes only the 42 mean variables, not the standard deviations, since standard deviations can not be averaged.
 
##Variables

The variables are defined in the source code book as follows:
 * All variable measures are normalized and bounded within [-1,1]
 * xyz is used to denote 3-axial signals in the X, Y and Z directions 
 * The set includes time variables and frequency variables
   * Time variables 
     * Accelerometer and gyroscope 3-axial raw signals were captured at a constant rate of 50 Hz (and filtered to remove noise)
       * time accelleration xyz was split into body and gravity acceleration signals 
         ** time body accelleration xyz 
         ** time gravity accelleration xyz 
       * time body gyroscope xyz 
     * body linear acceleration and angular velocity were derived in time to obtain jerk signals 
       ** time body accelleration jerk xyz 
       ** time body gyroscope jerk xyz 
     * magnitude of these three-dimensional signals were calculated using the Euclidean norm
       ** time body accelleration magnitude 
       ** time gravity accelleration magnitude 
       ** time body accelleration jerk magnitude 
       ** time body gyroscope magnitude 
       ** time body gyroscope jerk magnitude  
   * Frequency variables were calculated using a Fast Fourier Transform (FFT)  
     * frequency body accelleration xyz 
     * frequency body accelleration jerk xyz  
     * frequency body gyroscope xyz 
     * frequency body accelleration magnitude 
     * frequency body accelleration jerk magnitude  
     * frequency body gyroscope magnitude 
     * frequency body gyroscope jerk magnitude 
 * Variables have been summarised into mean and standard deviation measures
 * Additional variables obtained by averaging the signals in a signal window sample:
   * angle gravity mean 
   * angle time body accelleration mean 
   * angle time body accelleration jerk mean 
   * angle time body gyroscope mean 
   * angle time body gyroscope jerk mean 
