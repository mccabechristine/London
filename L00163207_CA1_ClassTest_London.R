# Q1------------------------------------------------------------------------------
# Read the dataset into a data frame called london_crime. 
# Then show the structure of the dataset.   
# The date attributes of each crime are currently shown in two different variables. 
# Using the paste() function, amalgamate the day, 
# month and year variables into a new variable called Date.   
# ---------------------------------------------------------------------------------
london_crime <- read.csv("london-crime-data.csv")

# View the structure of the UFO data frame
str(london_crime)

# Show the first 15 rows of the UFO data frame
head(london_crime, 15)

# Count the number of rows in the UFO data frame
rows_count <- nrow(london_crime)
print(paste("The number of rows in the UFO data frame is:", rows_count))

# Q2 ------------------------------------------------------------------------------
# We want to retain only the variables shown in this table, 
# and we wish to convert the variable names to that shown under the heading 
# Convert to in the table. 
# Make the relevant changes to the content of the London_crime data frame so that 
# your variables are correctly named, and that unrequired variables are discarded.   
# ---------------------------------------------------------------------------------