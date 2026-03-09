# ================================================
# US County Religion, Voting and Urbanization Maps
# Author: Julián Villaseñor-Ibáñez
# Data: PRRI 2020, MIT Election Lab, US Census Bureau SAIPE 2021, 2013 NCHS Urban-Rural Classification
# Description: Choropleth maps exploring US geographic
# patterns in religion, income, urban-rural classification and vote share
# at the county level. Preliminary to Moran I spatial
# autocorrelation analysis.
# ================================================

#Needed packages
#install.packages("rlang")
#install.packages("ggplot2")

library(ggplot2)
library(usmap)
library(dplyr)

#setwd("C:/Users/julia/Desktop/ReligionCounties/Github") #LOCAL ONLY

# ============================================
# RELIGION BY COUNTY 
# ============================================
# Visualizes the dominant religious group by county
# excluding Hawaii and Alaska for map clarity.
# Data source: PRRI 2020 Census of American Religion
# Note: The All White Christian category is split into denominations
# in the LargestReligions.csv file.

# ---- USER CONFIGURATION ----
# Select file to load:
# "Data/ReligionDatasets/LargestReligions.csv"               - All White Christian disaggregated by denomination
# "Data/ReligionDatasets/LargestReligionsWhiteChristian.csv" - All White Christian grouped as single category
selected_file <- "Data/ReligionDatasets/LargestReligions.csv"

# Select column to visualize:
# For LargestReligionsWhiteChristian.csv:
# "first_religion"  - dominant religion by county
# "second_religion" - second largest religion by county
# "third_religion"  - third religion by county
# "fourth_religion" - fourth largest religion by county
# "fifth_religion"  - fifth largest religion by county  

# For LargestReligions.csv:
# "first_religion"  - dominant religion by county without splitting All White Christian. Same as first_religion from Largest_Religions.csv
# "first_religion_chr" - dominant religion by county
# "second_religion_chr" - second largest religion by county
# "third_religion_chr"  - third religion by county
# "fourth_religion_chr" - fourth largest religion by county

selected_column <- "second_religion_chr"
# ----------------------------

# PRRI 2020 data. 
readfile <- read.csv(selected_file)

# Verify selected column exists in loaded file
if (!selected_column %in% colnames(readfile)) {
  stop(paste("Column", selected_column, "not found in", selected_file, 
             "\nAvailable columns:", paste(colnames(readfile), collapse = ", ")))
}

#Plots the choropleth map corresponding to the values in the selected column.
plot_usmap(data = readfile, values=selected_column, regions="counties", exclude = c("HI", "AK"))+
  labs(title = paste("Religion by County -", selected_column),
  subtitle = "Source: PRRI 2020 Census of American Religion") + 
  scale_fill_manual(values = c(`All White Christian` = "darkblue",`White Evangelical Protestant` = "blue",`Other Christian` = "dodgerblue", 
                               `White Mainline Protestant` = "lightblue", `Black Protestant` = "darkcyan", 
                               `White Catholic`="gold",
                               `Hispanic Catholic`="yellow",
                               `Hispanic Protestant`="yellow4", 
                               `Unaffiliated`="white",`Mormon`="violet",
                               `Jewish`="purple"
                               ), name = "Religious Group")+  
  theme(legend.position = "right")


# ============================================
# VOTE SHARE BY COUNTY 
# ============================================
# Visualizes the vote share by county for US presidential elections
# excluding Hawaii and Alaska.
# Data source: MIT Election Lab US presidential results by county 2008-2024


# ---- USER CONFIGURATION ----
# Select file to load:
# "Data/VoteShare2008/DemVoteShare2008.csv"              
# "Data/VoteShare2008/RepVoteShare2008.csv"
# "Data/VoteShare2012/DemVoteShare2012.csv"              
# "Data/VoteShare2012/RepVoteShare2012.csv"
# "Data/VoteShare2016/DemVoteShare2016.csv"              
# "Data/VoteShare2016/RepVoteShare2016.csv"
# "Data/VoteShare2020/DemVoteShare2020.csv"              
# "Data/VoteShare2020/RepVoteShare2020.csv"
# "Data/VoteShare2024/DemVoteShare2024.csv"              
# "Data/VoteShare2024/RepVoteShare2024.csv"
# Note : In 2015 Shannon County in South Dakota was renamed to Oglala Lakota country,
# with a corresponding fips code change from 46113 to 46102. We have modified this fips 
# code in the original 2008 2012 datasets so the county is shown in the latest version of usmap.


selected_file <-"Data/VoteShare2008/RepVoteShare2008.csv"  

# Select column to visualize:
# If the file contains Republican vote share -> pct_rep
# If the file contains Democratic vote share -> pct_dem

selected_column <- "pct_rep"


#Select the vote share file to read
readfile <- read.csv(selected_file)

# Derive candidate/party label from filename for title
# e.g. "Data/DemVoteShare2020.csv" -> "Democratic Vote Share 2020"
year <- regmatches(selected_file, regexpr("[0-9]{4}", selected_file))
party <- ifelse(grepl("Dem", selected_file), "Democratic", "Republican")

# Automatically set color based on party
high_color <- ifelse(grepl("Dem", selected_file), "blue", "red")

#Plots the choropleth map for the selected vote share file.
plot_usmap(data = readfile, values=selected_column, exclude = c("HI", "AK"))+
  labs(title = paste(party, "Vote Share by County -", year),
       subtitle = paste("Percentage of total votes having gone to the", party, "candidate")) + 
  scale_fill_continuous(low = "white", high = high_color, name = paste(party, "Vote Share"), label = scales::percent_format(scale = 1))+  
  theme(legend.position = "right")

# ============================================
# MEDIAN HOUSEHOLD INCOME BY COUNTY 
# ============================================
# Visualizes the median household income from the 2021 SAIPE by county,
# excluding Hawaii and Alaska. 
# Data source: US Census Bureau SAIPE 2021
# We have defined five income categories in USD:
#   Less than $50,000
#   $50,000 to $75,000
#   $75,000 to $100,000
#   $100,000 to $125,000
#   More than $125,000


#Read the medium income category file
readfile <- read.csv("Data/IncomeCategories/CountyIncome.csv", header = TRUE)

#Plots the choropleth map for median household income category by county.
plot_usmap(data = readfile, values="categoria", exclude = c("HI", "AK"))+
  labs(title = "Median Household Income by County",
       subtitle = "According to U.S. Census Bureau 2021 SAIPE Program") + 
  scale_fill_manual(values = c(`More than $125,000` = "darkgreen",`$100,000 to $125,000` = "green", 
                               `$75,000 to $100,000` = "chartreuse", `$50,000 to $75,000` = "orange", 
                               `Less than $50,000`="red"
  ), name = "Income Grouping")+  
  theme(legend.position = "right")


# ============================================
# URBANIZATION LEVEL CLASSIFICATION BY COUNTY 
# ============================================
# Visualizes the urbanization level of every county according to the NCHS classification,
# excluding Hawaii and Alaska. 
# Data source: 2013 NCHS Urban-Rural Classification Scheme

#2013 NCHS Urban-Rural Classification Scheme
readfile <- read.csv("Data/UrbanizationClassification/UrbanRuralCounties.csv", header = TRUE)

#Plots the choropleth map for urbanization level by county.
plot_usmap(data = readfile, values="clasificacion", regions="counties",exclude = c("HI", "AK"))+
  labs(title = "County Urban-Rural Classification Scheme",
       subtitle = "County Urbanization Level according to the CDC NCHS") + 
  scale_fill_manual(values = c(`Large central metro` = "darkgreen",`Large fringe metro` = "green",`Medium metro` = "chartreuse", 
                               `Small metro` = "yellow", `Micropolitan` = "orange", 
                               `Noncore`="red"
  ), name = "Urbanization Level")+  
  theme(legend.position = "right")

