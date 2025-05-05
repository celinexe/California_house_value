# Introduction 

This current project is a data science project- completed during my Data science course at UCLA extension - which the main goal is to be able to predict the median house value, given certain informaCon about a property.
It can help to solve some business issue faced by estate agencies: “How to set the price of a property, whether an apartment or a house, in a way that is reasonable while also maximizing profits?”.

[]!(https://github.com/celinexe/California_house_value/blob/main/images/IMG_9688-2-2-3.png)



## Dataset 
We will work with the following dataset: ‘housing.csv’.
This data set appeared in a 1997 paper Ctled Sparse SpaCal Autoregressions by Pace, R. Kelley and Ronald Barry, published in the Sta$s$cs and Probability Le3ers journal. The researchers built it using the 1990 California census data. It contains one row per census block group.
This dataset contains is made of 20,640 observaCons and 10 features. The target feature is of course this one:

•median_house_value (in dollars)
The features we will used to make the median house value predicCon are the
following ones:
•longitude: The geographical coordinate specifying the east-west position of a property. (The unit is degrees)
•latitude: The geographical coordinate specifying the north-south position of a property. Both indicate the position of the property.
•housing_median_age: The median age of houses in a census block group (in the neighborhood). The unit used is years.
•total_rooms: The total number of rooms in all housing units within a block. 
•total_bedrooms: The total number of bedrooms in all housing units within a block. 
•population: The total number of people residing in the block
•households: The total number of households (occupied housing units) in the block. 
•median_income: The median income of a households in the block. (In tens of thousands of dollars)
•ocean_proximity: A categorical variable describing the property’s proximity to the ocean.




## Key steps

The details of R codes, plots, comments are available in the R files.
MoreOver , if interested , there is an non technical pdf project repor. 

###  EDA and Visualization
Ran summary(), head(), tail() <br>
Created histograms and boxplots <br>
Performed correlation analysis <br>
Visualized boxplots grouped by ocean proximity 

### Data Processing
Imputed missing total_bedrooms with median <br>
One-hot encoded ocean_proximity <br>
Created mean_rooms and mean_bedrooms <br>
Scaled numerical features (except target and binary vars) <br>
Split into 70% training / 30% testing sets 

### Modeling
Used randomForest with: <br>
ntree = 500 <br>
importance = TRUE <br>
Trained model on predictors, tested on holdout set <br>
Model's performance evaluation using RMSE 




