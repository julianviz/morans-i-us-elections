# morans-i-us-elections
Reproducible code and data for "Religion or class? Measuring voting clustering on religious and socioeconomic lines in US presidential elections" Villaseñor-Ibáñez J, del Castillo-Mussot M, El Deeb O *PLOS ONE*, October 2025  
https://doi.org/10.1371/journal.pone.0331959


## Key Finding

Counties sharing a majority religion vote more similarly than counties 
in the same income bracket or urbanization level. This similarity is second only to 
geographic adjacency as a predictor of voting clustering across the 
2016, 2020, and 2024 US presidential elections. We have added the corresponding calculations
for the 2008 and 2012 elections, which agree with our reported findings in the article.

## Repository Structure
```
├── MoransICalculations.R              # Moran's I spatial autocorrelation calculation
├── MapVisualizations.R                # Choropleth map visualization
├── Data/
│   ├── ReligionDatasets/           # PRRI 2020 religion by county
│   ├── VoteShare2008/ ... 2024/    # MIT Election Lab presidential results
│   ├── IncomeCategories/           # US Census Bureau SAIPE 2021
│   ├── UrbanizationClassification/ # CDC NCHS 2013 scheme
│   ├── GeographicalAdjacencyMatrix/
│   ├── ReligionAdjMatrices/
│   ├── IncomeAdjacencyMatrix/
│   └── UrbanizationAdjacencyMatrix/
└── Results/
    └── MoransI_AllResults.csv      # Full results for all combinations
```

## Usage

### Moran's I Calculation (MoranI.R)

Edit the two configuration lines at the top:
```r
selected_share  <- "Data/VoteShare2020/DemVoteShare2020.csv"
selected_matrix <- "Data/GeographicalAdjacencyMatrix/CountyGeographicalAdjacencyMatrix.csv"
```

Run the script. Output includes observed Moran's I, expected value, 
standard deviation, and p-value.

### Choropleth Maps (Maps.R)

Edit the configuration block at the top of each section to select 
file and column. Covers religion, vote share (2008–2024), median 
household income, and urbanization level.

## Results

Full Moran's I results for all election years, parties, and adjacency 
frameworks are in `Results/MoransI_AllResults.csv`. 
These correspond to Tables 1–3 in the paper.

## Data Sources

| Dataset | Source |
|---------|--------|
| Religion by county | PRRI 2020 Census of American Religion |
| Presidential vote share | MIT Election Data and Science Lab |
| Median household income | US Census Bureau SAIPE 2021 |
| Urbanization classification | CDC NCHS 2013 Urban-Rural Scheme |
| County adjacency | US Census Bureau 2024 County Adjacency File |

**Note:** Shannon County, SD was renamed Oglala Lakota County in 2015 
(FIPS 46113 → 46102). Modified in 2008, 2012 and 2015 datasets accordingly.

## Requirements
```r
install.packages(c("rlang","ggplot2", "usmap", "dplyr", "ape"))
```

## Citation

If you use this code or data, please cite:

Villaseñor-Ibáñez J, del Castillo-Mussot M, El Deeb O (2025) 
Religion or class? Measuring voting clustering on religious and 
socioeconomic lines in US presidential elections. 
*PLoS One* 20(10): e0331959. 
https://doi.org/10.1371/journal.pone.0331959
