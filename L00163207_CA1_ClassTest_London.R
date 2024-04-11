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

# Calculate the total number of crimes per borough
crime_summary <- table(london_crime$Borough)
crime_summary
# Sort the summary to ensure the plot follows an order that might highlight the boroughs with most crimes more clearly
sorted_crime_summary <- sort(crime_summary, decreasing = TRUE)
sorted_crime_summary

# Plotting
windows(16, 10)
barplot(sorted_crime_summary, las = 2, col = "blue",
        main = "Total Crimes by Borough in London",
        xlab = "Borough", ylab = "Total Crimes")

# Identify the boroughs with the highest and lowest level of crime
highest_crime_borough <- names(sorted_crime_summary)[1]
lowest_crime_borough <- names(sorted_crime_summary)[length(sorted_crime_summary)]
highest_crime_borough
lowest_crime_borough

# Print the boroughs with the highest and lowest level of crime
cat("Borough with the highest level of crime:", highest_crime_borough, "\n")
cat("Borough with the lowest level of crime:", lowest_crime_borough, "\n")

# Borough with the highest level of crime - Croyden
print(paste("Borough with the highest level of crime:", highest_crime_borough))

# Borough with the lowest level of crime - City of London
print(paste("Borough with the lowest level of crime:", lowest_crime_borough))

# Q5 ------------------------------------------------------------------------------
# Display the MajorCategory variable data in a pie chart. 
# Using data output from the table() function, determine the highest and lowest 
# major categories of crime in London. 
# Then display this information in a pie chart using the pie() function.  
# • Add a comment in your code to indicate which major category had the highest level of crimes.   
# • Add a comment in your code to indicate which category had the lowest level of crimes.  
# ---------------------------------------------------------------------------------

# Summarize the data
crime_counts_by_category <- table(london_crime$MajorCategory)

# Determine the highest and lowest major categories of crime
highest_crime_category <- names(which.max(crime_counts_by_category))
lowest_crime_category <- names(which.min(crime_counts_by_category))

# Plotting the pie chart
windows(16, 10)
pie(crime_counts_by_category, main = "Major Categories of Crime in London",
    col = rainbow(length(crime_counts_by_category)))

# Adding a legend for clarity
legend("topleft", legend = names(crime_counts_by_category), fill = rainbow(length(crime_counts_by_category)))

# Print out the categories with the highest and lowest level of crimes
cat("Highest level of crimes is in the category:", highest_crime_category, "\n")
# Theft & Handling
cat("Lowest level of crimes is in the category:", lowest_crime_category, "\n")
# Sexual Offence

# Q6 ------------------------------------------------------------------------------------
# Categorise each borough in the London_crime dataset into the general area where 
# it lies within London. 
# Using the table below, create a new variable called Region and store within it 
# the correct region for each borough.  
# Once finished, check that all Boroughs have been assigned to a region. 
# You can do this by checking whether any boroughs are assigned with an NA value. 
# If you find any regions that contain NA, replace them with a suitable Region. 
# Clearly indicate in your code how you checked this and any decisions you needed to make.     
# ----------------------------------------------------------------------------------------

# Create a named vector for mapping Boroughs to Regions
borough_to_region <- c(
  "Barking and Dagenham" = "East",
  "Barnet" = "North",
  "Bexley" = "East",
  "Brent" = "West",
  "Bromley" = "South",
  "Camden" = "North",
  "Croydon" = "South",
  "Ealing" = "West",
  "Enfield" = "North",
  "Greenwich" = "East",
  "Hackney" = "North",
  "Hammersmith and Fulham" = "West",
  "Haringey" = "North",
  "Harrow" = "West",
  "Havering" = "East",
  "Hillingdon" = "West",
  "Hounslow" = "West",
  "Islington" = "Central",
  "Kensington and Chelsea" = "Central",
  "Kingston upon Thames" = "East",
  "Lambeth" = "Central",
  "Lewisham" = "Central",
  "Merton" = "South",
  "Newham" = "East",
  "Redbridge" = "East",
  "Richmond upon Thames" = "West",
  "Southwark" = "Central",
  "Sutton" = "South",
  "Tower Hamlets" = "Central",
  "Waltham Forest" = "Central",
  "Wandsworth" = "East",  
  "Westminster" = "Central"
)

# Assign regions to each borough in the dataset
london_crime$Region <- borough_to_region[london_crime$Borough]

# Check for any NAs in the Region column to ensure all boroughs have been assigned
anyNA(london_crime$Region)

# In case of NAs, decide on a suitable region. 
london_crime$Region[london_crime$Borough == "Wandsworth"] <- "Southwest" # Adjust based on actual geographical location or other criteria

# Verify adjustments or check the unique values to ensure correctness
unique(london_crime$Region)

# Q7 ------------------------------------------------------------------------------------
# Display which region in London has the highest recorded crime rate. 
# Using the plot() function, show the number of reported crimes by region. 
# Suitably label the chart and its axes.   
# • Add a comment in your code to indicate which region had the highest number of crimes. 
# How many crimes were committed?  
# • Add a comment in your code to indicate which region had the lowest number of crimes. 
# How many crimes were committed?       
# ----------------------------------------------------------------------------------------

# Summarise the total number of crimes by Region
total_crimes_by_region <- aggregate(Value ~ Region, data = london_crime, sum)

# Sort the data for better visualisation
total_crimes_by_region <- total_crimes_by_region[order(-total_crimes_by_region$Value),]

# Using barplot() to visualise the number of reported crimes by region
windows(16,10)
barplot(total_crimes_by_region$Value, names.arg = total_crimes_by_region$Region, 
        las = 2, col = "blue", 
        main = "Reported Crimes by Region in London", 
        xlab = "Region", ylab = "Number of Reported Crimes", 
        horiz = FALSE)

# Identifying the region with the highest and lowest number of crimes
highest_crime_region <- total_crimes_by_region[1, ]
lowest_crime_region <- total_crimes_by_region[nrow(total_crimes_by_region), ]

# Print out the region with the highest and lowest number of crimes for confirmation
cat("The region with the highest number of crimes is", highest_crime_region$Region,
    "with", highest_crime_region$Value, "crimes committed.\n")
cat("The region with the lowest number of crimes is", lowest_crime_region$Region,
    "with", lowest_crime_region$Value, "crimes committed.\n")

# Region with highest number of crimes is Central with 18248 crimes committed
# Region with the lowest number of crimes is South with 1899 crimes committed

# Q8 ------------------------------------------------------------------------------------
# Referring to your answer in Q7, extract out the subset of data that had the 
# highest number of crimes. 
# And then extract out a subset of data that had the lowest level of crimes.    
# •  Comment the major crime category of both regions.       
# ----------------------------------------------------------------------------------------

# Identify the region with the highest and lowest number of crimes
highest_crime_region_name <- total_crimes_by_region[which.max(total_crimes_by_region$Value), ]$Region
lowest_crime_region_name <- total_crimes_by_region[which.min(total_crimes_by_region$Value), ]$Region

# Extract the subset of data for the highest number of crimes
highest_crime_data <- subset(london_crime, Region == highest_crime_region_name)

# Extract the subset of data for the lowest number of crimes
lowest_crime_data <- subset(london_crime, Region == lowest_crime_region_name)

# Summarise the major crime category for the region with the highest number of crimes
highest_crime_category <- aggregate(Value ~ MajorCategory, data = highest_crime_data, sum)
highest_crime_category <- highest_crime_category[which.max(highest_crime_category$Value), ]

# Summarise the major crime category for the region with the lowest number of crimes
lowest_crime_category <- aggregate(Value ~ MajorCategory, data = lowest_crime_data, sum)
lowest_crime_category <- lowest_crime_category[which.max(lowest_crime_category$Value), ]

# Print out the major crime categories for both regions
cat("In the region with the highest number of crimes, the major crime category is", highest_crime_category$MajorCategory, "with", highest_crime_category$Value, "crimes.\n")
cat("In the region with the lowest number of crimes, the major crime category is", highest_crime_category$MajorCategory, "with", lowest_crime_category$Value, "crimes.\n")

# Region with the highest number of crimes, the major crime category is Theft and Handling 
# with 7846 crimes.

# Region with the lowest number of crimes, the major crime category is Theft and Handling 
# with 2049 crimes.

# Identify regions with the highest and lowest number of crimes
highest_crime_region_name <- names(which.max(table(london_crime$Region)))
lowest_crime_region_name <- names(which.min(table(london_crime$Region)))

# Extract subsets for these regions
highest_crime_region_data <- subset(london_crime, Region == highest_crime_region_name)
lowest_crime_region_data <- subset(london_crime, Region == lowest_crime_region_name)

# Identify major crime categories with the highest number of crimes within these subsets
# For the highest crime region
highest_crime_category_in_highest_region <- names(which.max(table(highest_crime_region_data$MajorCategory)))
# For the lowest crime region
highest_crime_category_in_lowest_region <- names(which.max(table(lowest_crime_region_data$MajorCategory)))

# Comment on the major crime categories for both regions
cat("In the region with the highest number of crimes (", highest_crime_region_name, "), the most common crime category is ", highest_crime_category_in_highest_region, ".\n", sep="")
cat("In the region with the lowest number of crimes (", lowest_crime_region_name, "), the most common crime category is ", highest_crime_category_in_lowest_region, ".\n", sep="")

# Identifying major crime categories with the lowest number of crimes within these subsets (For additional insight)
# For the highest crime region
lowest_crime_category_in_highest_region <- names(which.min(table(highest_crime_region_data$MajorCategory)))
# For the lowest crime region
lowest_crime_category_in_lowest_region <- names(which.min(table(lowest_crime_region_data$MajorCategory)))

# Commenting on the least common major crime categories for both regions
cat("In the region with the highest number of crimes (", highest_crime_region_name, "), the least common crime category is ", lowest_crime_category_in_highest_region, ".\n", sep="")
cat("In the region with the lowest number of crimes (", lowest_crime_region_name, "), the least common crime category is ", lowest_crime_category_in_lowest_region, ".\n", sep="")

# Region with the highest number of crimes (Central), the highest crime category is Theft and Handling.
# Region with the lowest number of crimes (Southwest), the highest crime category is Theft and Handling.
# Region with the highest number of crimes (Central), the lowest crime category is Sexual Offences.
# Region with the lowest number of crimes (Southwest), the lowest crime category is Sexual Offences.

# Q9 ------------------------------------------------------------------------------------
# Using information from the table() function, plot the content of both of your 
# data frames side by side. 
# Make sure that the y axis on both charts are shown in the same scale and 
# that both charts contain suitably labelled titles, x and y axis. 
# And text on the xaxis should be presented vertically.  
# ----------------------------------------------------------------------------------------

# Setting up the plot area to contain 2 side-by-side plots
windows(16, 10)
par(mfrow=c(1,2))

# Plot for the region with the highest number of crimes
crime_counts_high = table(highest_crime_region_data$MajorCategory)
barplot(crime_counts_high, main="Major Crime Categories in the Highest Crime Region", 
        xlab="Major Crime Category", ylab="Number of Crimes", las=2, col="blue")

# Plot for the region with the lowest number of crimes
crime_counts_low = table(lowest_crime_region_data$MajorCategory)
barplot(crime_counts_low, main="Major Crime Categories in the Lowest Crime Region", 
        xlab="Major Crime Category", ylab="Number of Crimes", las=2, col="red")

# Restoring default plotting settings
par(mfrow=c(1,1))

# Ensure y-axis scales are the same for comparability
max_count = max(c(crime_counts_high, crime_counts_low))
par(ylim=c(0, max_count))

# Q10 ------------------------------------------------------------------------------------
# Using the write.csv() command, save the modified london_crime data frame 
# as london-crimemodified.csv.   
# Finally, sync your R script file as well as the London-crime-modified.csv file 
# to the remote GitHub repo.  
# ----------------------------------------------------------------------------------------

write.csv(london_crime, "london-crime-modified.csv", row.names = FALSE)
