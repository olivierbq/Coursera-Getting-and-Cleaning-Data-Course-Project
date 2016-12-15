# Coursera-Getting-and-Cleaning-Data-Course-Project

The dataset includes the following files:

- README.txt
- Codebook
- run_analysis.R
- tidyset.txt

The R script, run_analysis.R, does the following:

1. Open required libraries - download en unzip dataset
2. Load the activity and feature info
3. Load the train en test dataset and set collum names 
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Merges the two dataset into one combined dataset where only the mean & std features are in the rest is filtered out. 
6. Converts the activity and subject columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidyset.txt.
