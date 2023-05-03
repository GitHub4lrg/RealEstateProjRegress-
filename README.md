
![Real Estate Image](images/RealEstate.png "Real Estate Case Study - Regression")
# Real Estate Case Study - Regression

## Index:

- [Scenario](#scenario)
- [Objective](#objective)
- [First Approach](#first-approach)
- [Analysis](#analysis)
-	[Conclusions](#conclusions)
-	[Tableau](#tableau)
- [SQL](#sql)
- [Presentation](#presentation)
 
## Scenario

### We are working as an analyst for a real estate company. Our company wants to build a machine learning model to predict the selling prices of houses based on a variety of features on which the value of the house is evaluated.

## Objective

### Our job is to build a model that will predict the price of a house based on features provided in the dataset. Senior management also wants to explore the characteristics of the houses using some business intelligence tools. One of those parameters includes understanding which factors are responsible for higher property value of $650K and above.

## We used Python to build the required Model. To explore our Python Notebook, follow this [link](Python/mid_bcamp_proRegression.ipynb)

## First Approach

### The dataset consists of information on 22,000 properties and include historic data of houses sold between May 2014 to May 2015. We will initially:
- Import Data
- Explore Data through Exploratory Data Analysis
- Data wrangling
- Data cleaning

## Analysis 

### Our Data consisted of 21597 rows where we found no nulls nor duplicates, but there were some houses with repeated entries due to been sold more than once. We also found a house with number of rooms completely out of the range, so we assumed it was a bad data. We needed to fix data types for some features for a better analysis, and finally we decided to drop some features with the purpose of eliminating some bias in our data.

### In our first iteration after using MinMaxScaler and our Machine learning model we used 3 different sets where our best R2 score was 0.7454 having on this set also the lower MSE. Here the model performed well, but we wanted to improve it.

### We then performed a sequence of iterations but this time using KNN model for which our R2 scored 0.8201 with K = 6. We were pleased with this last result.

## Conclusions

- We concluded, after running different sets of Linear Regression and using KNN model that our best prediction is presented with the K-Nearest Neighbors using K = 6. It gave us an R2 result of 0.8201.

- Understanding which factors are responsible for higher property value of $650K and above. We wrote some queries on SQL to calculate Mode on the main factors:
   -	Bedrooms – 4
   - Bathrooms – 2.5
   - Sqft Living – 2,440
   - Condition – 3
   - Grade – 9
   - Year Built – 2014
- The 3 Most expensive Zip codes on this data frame were 98004 Bellevue, 98053 Redmond, and 98040 Mercer Island.
 
## Tableau

### We have some deliverables for visualization in Tableau, so we will present our findings in a simple way to understand. To view our presentation, follow the [link](https://public.tableau.com/shared/JR9KF24FW?:display_count=n&:origin=viz_share_link) 

## SQL

### We used MySQL Workbench to complete some deliverables and run the queries requested and get a better understanding of our data frame. To find our queries, follow the [link](SQL/Mid_bootCampProRegression.sql).

## Presentation

### We used Story in Tableau to make our presentation with the simplest and visually appealing. To view our presentation, follow the [link](https://public.tableau.com/views/RealEstate-ProjRegress/RealEstateKingCountyAnalysis?:language=en-US&:display_count=n&:origin=viz_share_link)
