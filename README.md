This dataset contains a reduced & aggregated version of the 
Human Activity Recognition Using Smartphones Dataset (v1.0), originally 
created by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto,
from Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova.
(www.smartlab.ws)

The idea was to both summarise this data (by taking only the averages for each subject - activity
combination), and to reduced the data set by only doing this for the already calculated means and
standard deviation - instead of the raw sensor data in the original data set. 

The original data set is actually a combination of two data sets - one for training the model,
and one for testing the model. Since this split was done arbitrarily (70* of the subject were 
labeled for training), this separation has been undone for this data set.

INSTRUCTIONS
For obtaining the reduced data set as described above, it is necessary to load the function
run_analysis(), and run it from a directory where original data set is located (i.e. your
working directory should contain a subfolder 'UCI HAR Dataset', with subfolders 'train' and 'test'
etc.). After running the function, you'll find a new file 'tidy_data.txt' with the reduced dataset.
The fields of this dataset are explained in the CodeBook.md file.