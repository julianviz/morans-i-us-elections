# ================================================
# MORAN'S I CALCULATION FOR DIFFERENT ADJACENCY MATRICES
# Author: Julián Villaseñor-Ibáñez
# Data: PRRI 2020, MIT Election Lab, US Census Bureau SAIPE 2021, 2013 NCHS Urban-Rural Classification
# Description: Calculates Moran's I spatial autocorrelation for Republican or Democratic vote share in the
# 2008, 2012, 2016, 2020 or 2024 presidential elections, using distinct adjacency matrices: Geographical,
# Religious, Median Household Income or Urbanization Level
# ================================================



library(ape)
#setwd("C:/Users/julia/Desktop/ReligionCounties/Github") #LOCAL ONLY


# ============================================
# MORAN'S I CALCULATION
# ============================================
# Calculates Moran's I for the selected vote share and adjacency matrix. Adjacency matrices have already
# been constructed using the listed data sources. 
# Data sources: PRRI 2020, MIT Election Lab, US Census Bureau SAIPE 2021, 2013 NCHS Urban-Rural Classification

# Select vote share to load:
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
# code in the original 2008, 2012 and 2016 datasets.

selected_share <- "Data/VoteShare2016/DemVoteShare2016.csv"
voteshare <-  read.csv(selected_share, header=TRUE)
voteshare <- as.numeric(voteshare[,2])

# Select an adjacency matrix to load:
# Note: FirstReligion_ReligionAdjacencyMatrix.csv contains the adjacency matrix corresponding
# to the largest religion in the LargestReligions.csv file where the All White Christian Category has not been 
# split into denominations. The rest of the files correspond to matrices obtained from LargestReligionsWhiteChristian.csv where 
# this category has been split.

# "Data/GeographicalAdjacencyMatrix/CountyGeographicalAdjacencyMatrix.csv"
# "Data/ReligionAdjMatrices/FirstReligion_ReligionAdjacencyMatrix.csv"              
# "Data/ReligionAdjMatrices/FirstReligionChr_ReligionAdjacencyMatrix.csv"
# "Data/ReligionAdjMatrices/SecondReligionChr_ReligionAdjacencyMatrix.csv"              
# "Data/ReligionAdjMatrices/ThirdReligionChr_ReligionAdjacencyMatrix.csv"
# "Data/ReligionAdjMatrices/FourthReligionChr_ReligionAdjacencyMatrix.csv"              
# "Data/IncomeAdjacencyMatrix/IncomeAdjacencyMatrix.csv"              
# "Data/UrbanizationAdjacencyMatrix/UrbanizationAdjacencyMatrix.csv"

selected_matrix <-"Data/GeographicalAdjacencyMatrix/CountyGeographicalAdjacencyMatrix.csv"
adj_matrix <- read.csv(selected_matrix, header=FALSE)


# Calculate Moran's I for the selected vote share according to the specified adjacency matrix
Moran.I(voteshare, adj_matrix, scaled=TRUE)
# Moran.I returns:
#   observed: Moran's I statistic (-1 to 1, positive = clustering, negative = dispersion)
#   expected: expected value under null hypothesis of no spatial autocorrelation
#   sd:       standard deviation
#   p.value:  p-value for two-tailed test
