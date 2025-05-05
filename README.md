# Introduction 

This current project is a data science project- completed during my Data science course at UCLA extension - which the main goal is to be able to predict the median house value, given certain informaton about a property.
It can help to solve some business issue faced by estate agencies: “How to set the price of a property, whether an apartment or a house, in a way that is reasonable while also maximizing profits?”.


![](https://github.com/celinexe/California_house_value/blob/main/images/california.png)


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
Moreover, if interested, there is an non-technical pdf project report. 

### 1. EDA and Visualization
Ran summary(), head(), tail() <br>
Created histograms and boxplots <br>
Performed correlation analysis <br>
Visualized boxplots grouped by ocean proximity 

### Data Processing
Imputed missing total_bedrooms with median <br>
One-hot encoded ocean_proximity <br>
Created mean_rooms and mean_bedrooms <br>
Scaled numerical features-Normalization (except target and binary vars) <br>
Split into 70% training / 30% testing sets 

### Modeling
Used randomForest with: <br>
ntree = 500 <br>
importance = TRUE <br>
Trained model on predictors, tested on holdout set <br>
Model's performance evaluation using RMSE 

### Feature importance 

Random forest gives us feature importance based on %Inc MSE (Percentage Increase in Mean Squared Error) or IncNodePurity (Increase in Node Purity). <br>
I will build another model using 4 features thats has the highest contribution and compare it performance with the previous model using all the features. 



# Quick Overview 
More details available in project report

1. Interesting Exploratory, Bareplot visualization and interpretation

1.1 General  Histogram 


<img src="https://github.com/celinexe/California_house_value/blob/main/images/histogramme.png" width="600" height="400">


Here is look on the histogram of different features, 
We can see for some feature such as the median income, housing median age. They follow a normal distribution. 


1.2 Boxplot

<img src="https://github.com/celinexe/California_house_value/blob/main/images/barplot.png" width="600" height="400">



Immediately, by examining the boxplots of these different features, some appear to have unusual distributions.
The following features: median_income, total_bedrooms, population, and total_rooms show a significant number of values outside the whiskers, indicating potential outliers. But the number of points outside the whiskers seems a little too significant to be considered potential outliers.



1.2 Boxplot for the feature 'median_income' and median_home_value with respect to the factor variable ocean_proximity.  
<img src="https://github.com/celinexe/California_house_value/blob/main/images/oceanProximity.png" width="600" height="400">


Here We have a can deduce that the house that are located less than 1h or near from the ocean belongs to the household who tend to have a highest median income. 

1.3 Boxplot for the feature 'median_home_value' with respect to the factor variable ocean_proximity.  
<img src="https://github.com/celinexe/California_house_value/blob/main/images/oceanprox_mhv.png" width="600" height="400">


Here, we observe that the most expensive houses are mostly located on islands, followed by those near the ocean (within 1 hour). However, the boxplot for INLAND shows a significant number of outliers. This could indicate specific neighborhoods where house prices are potentially overpriced.


2. Correlation map
<img src="https://github.com/celinexe/California_house_value/blob/main/images/correlation.png" width="600" height="400">


  By examining this correlation map, we can observe that the darkest colors represent the strongest correlations between features. First, we notice that only one feature, median_income, is highly correlated with our target value. This feature will contribute the most to our model’s predictions. Additionally, we observe that total_rooms, total_bedrooms, population, and households are strongly correlated with each other, which makes sense given their inherent relationships.

   

3. Feature importance


 <img src="https://github.com/celinexe/California_house_value/blob/main/images/feature_importance.png" width="600" height="400">

We observe that on the first graph (%Inc MSE Increasing in mean squarred error)
the feature 'median_income' and 'housing_median_age' contribute the most to 
the model predictive accuracy. The features 'longitude' and 'latitude’ also impact the model's accuracy which is logical since the location of a house significantly influence its price.

By examining "IncNodePurity," we observe that the feature median_income has the greatest impact on node purity. This variable is highly significant for the tree.

The model's performance was evaluated using Root Mean Squared Error (RMSE):
Initial Model (All Features, 500 Trees):
•Training RMSE: 49,396.36
•Testing RMSE: 49,372.00
Reduced Model (Top 4 Features, 500 Trees):
•Training RMSE: 51,537.84
•Testing RMSE: 50,735.52



# Summary 

### Business answer
This analysis highlights the key factors that influence house prices. Among these, median income emerged as the strongest predictor, emphasizing its importance in determining property values. Other significant features, such as housing median age and geographic factors like longitude and laCtude, also reflect trends seen in real estate markets.

### Insights for Stakeholders:
Median income acts as a solid indicator of housing demand, making it a crucial factor for seong property prices and identifying high-value areas.
Geographic factors like proximity to desirable locations play a key role in determining house prices. Properties close to the ocean or in affluent neighborhoods tend to be priced higher.
The simplified model, based on just four key features, shows that reliable predictions can still be made. This makes the model easier to interpret and implement, without losing much accuracy.
With an error margin of about $49,000–$51,000, the model provides valuable insights for real estate businesses, investors, and policymakers to make informed decisions about property pricing, investment opportuniCes, and urban development.



