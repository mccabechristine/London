# Q1------------------------------------------------------------------------------
# Read the dataset into a data frame called london_crime. 
# Then show the structure of the dataset.   
# The date attributes of each crime are currently shown in two different variables. 
# Using the paste() function, amalgamate the day, 
# month and year variables into a new variable called Date.   
# ---------------------------------------------------------------------------------
london_crime <- read.csv("london-crime-data.csv")

# View the structure of the London_crime data frame
str(london_crime)

# Show the first 15 rows of the London_crime data frame
head(london_crime, 15)

# Count the number of rows in the London_crime data frame
rows_count <- nrow(london_crime)
print(paste("The number of rows in the London_crime data frame is:", rows_count))

# Use the paste() function to combine year, month, and day into a single string
# and then convert it to a Date object.
london_crime$Date <- as.Date(paste(london_crime$year, london_crime$month, london_crime$day, sep = "-"), format = "%Y-%m-%d")

# Verify the transformation by checking the structure of the dataframe
str(london_crime)

# Q2 ------------------------------------------------------------------------------
# We want to retain only the variables shown in this table, 
# and we wish to convert the variable names to that shown under the heading 
# Convert to in the table. 
# Make the relevant changes to the content of the London_crime data frame so that 
# your variables are correctly named, and that unrequired variables are discarded.   
# ---------------------------------------------------------------------------------

# Display current column names
names(london_crime)

# Update column names
names(london_crime)[names(london_crime) == "borough"] <- "Borough"
names(london_crime)[names(london_crime) == "major_category"] <- "MajorCategory"
names(london_crime)[names(london_crime) == "minor_category"] <- "SubCategory"
names(london_crime)[names(london_crime) == "value"] <- "Value"
names(london_crime)[names(london_crime) == "Date"] <- "CrimeDate"

# Load the dplyr package
library(dplyr)

# Retain only the specified columns
london_crime <- london_crime %>%
  select(Borough, MajorCategory, SubCategory, Value, CrimeDate)

# Display updated column names to confirm changes
names(london_crime)

# Q3 ------------------------------------------------------------------------------
# Convert the CrimeDate variable so that it is a variable of type Date. 
# Confirm that the variable has been changed to the required variable type by 
# showing the structure and content of the date variable.   
# ---------------------------------------------------------------------------------

# Convert 'datetime' from character to Date format
london_crime$CrimeDate <- as.Date(london_crime$CrimeDate, format="%m/%d/%Y")

# To check  the conversion, use the str() function to show the structure of the data frame again
str(london_crime$CrimeDate)

# Q4 ------------------------------------------------------------------------------
# Plot a chart to show the summary of the borough information from the data frame 
# so that we can view where most crimes occur. Using the table() function, 
# display this data in a chart with suitable chart title and x and y axis subtitles. 
# Then answer the following: 
# • Add a comment in your code to show which borough has the highest level of crime.  
# • And add a comment in your code to indicate which area has the lowest level of crime.  
# ---------------------------------------------------------------------------------
