CodeBook
========
All of the analysis takes place in [run_analysis.R](https://github.com/burtonjc/coursera-cleaning-data/blob/master/run_analysis.R). Running that one file will clean up the data into a single tidy data set and run a small bit of analysis on it.

##Variables
After running the analysis, you will see a variable called ```data``` in your environment. ```data``` contains a data frame of the tidied data that the analysis will be run on.

##Data
The original data lives under ```./data/UCI HAR Dataset/```. It is split between two groups called "test" and "train". [run_analysis.R](https://github.com/burtonjc/coursera-cleaning-data/blob/master/run_analysis.R) cleans this data into the ```data``` variable. The first column in ```data``` is the subject id, the second is the activity, and the rest are the means and standard deviations of different measurements broken down by subject and activity.

##Transformations
The following transormations take place in [run_analysis.R](https://github.com/burtonjc/coursera-cleaning-data/blob/master/run_analysis.R):
  1. merge test and train group subject data (via ```rbind```)
  2. merge test and train group y_data (via ```rbind```)
  3. merge test and train group x_data (via ```rbind```)
  4. name the merged data columns based on the data in the features data
  5. merge subject data, y\_data, x\_data, into one data frame (via ```colbind```)
  6. rename all columns to be more human readable
  7. turn the activity column into a factor using labels from the activity labels data

After the transformations are complete, we use ```ddply``` from the plyr package to calculate the mean for each column based on unique id, activity factors. The result of ```ddply``` is written out to output.csv.
