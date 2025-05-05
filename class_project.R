#FINAL CLASS PROJECT 
# DEC 5, 2024
#Celine XIAO 


#1 Access the Data set


housing<-read.csv("housing.csv")



unique(housing$ocean_proximity)
#[1] "NEAR BAY"   "<1H OCEAN"  "INLAND"     "NEAR OCEAN" "ISLAND"   

class(housing$ocean_proximity)
#[1] "character"
#We observe here that this variable contains character , let's turn it into 
#factor class

housing$ocean_proximity<-as.factor(housing$ocean_proximity)
class(housing$ocean_proximity)
levels(housing$ocean_proximity)

#> class(housing$ocean_proximity)
#[1] "factor"
#> levels(housing$ocean_proximity)
#[1] "<1H OCEAN"  "INLAND"     "ISLAND"     "NEAR BAY"   "NEAR OCEAN"


#2/ EDA and Data Visualization 



head(housing)

#longitude latitude housing_median_age total_rooms total_bedrooms population
#1   -122.23    37.88                 41         880            129        322
#2   -122.22    37.86                 21        7099           1106       2401
#3   -122.24    37.85                 52        1467            190        496
#4   -122.25    37.85                 52        1274            235        558
#5   -122.25    37.85                 52        1627            280        565
#6   -122.25    37.85                 52         919            213        413
#households median_income median_house_value ocean_proximity
#1        126        8.3252             452600        NEAR BAY
#2       1138        8.3014             358500        NEAR BAY
#3        177        7.2574             352100        NEAR BAY
#4        219        5.6431             341300        NEAR BAY
#5        259        3.8462             342200        NEAR BAY
#6        193        4.0368             269700        NEAR BAY


tail(housing)

#b
summary(housing)

#By observing the summary, we observe that there is only one feature that contains NAs
#which is total_bedrooms (207 NAs).




#Let's perform a correlation analysis on numeric variables in the data frame 

#Let's chek on the correlation matrix, for this all variables (features) has to be numeric 
#So we are going to make a cop of our dataframe and delete the categorical feature

housing_copy<-housing
housing_copy$ocean_proximity<-NULL

class(housing_copy)
head(housing_copy)

cor(housing_copy)

#longitude    latitude housing_median_age total_rooms total_bedrooms   population  households median_income median_house_value
#longitude           1.00000000 -0.92466443        -0.10819681  0.04456798             NA  0.099773223  0.05531009  -0.015175865        -0.04596662
#latitude           -0.92466443  1.00000000         0.01117267 -0.03609960             NA -0.108784747 -0.07103543  -0.079809127        -0.14416028
#housing_median_age -0.10819681  0.01117267         1.00000000 -0.36126220             NA -0.296244240 -0.30291601  -0.119033990         0.10562341
#total_rooms         0.04456798 -0.03609960        -0.36126220  1.00000000             NA  0.857125973  0.91848449   0.198049645         0.13415311
#total_bedrooms              NA          NA                 NA          NA              1           NA          NA            NA                 NA
#population          0.09977322 -0.10878475        -0.29624424  0.85712597             NA  1.000000000  0.90722227   0.004834346        -0.02464968
#households          0.05531009 -0.07103543        -0.30291601  0.91848449             NA  0.907222266  1.00000000   0.013033052         0.06584265
#median_income      -0.01517587 -0.07980913        -0.11903399  0.19804965             NA  0.004834346  0.01303305   1.000000000         0.68807521
#median_house_value -0.04596662 -0.14416028         0.10562341  0.13415311             NA -0.024649679  0.06584265   0.688075208         1.00000000


#Let's replace the NA value with the median because if we don't do it we can not see the correlation between this feature 
#and the other ones. 

install.packages("dplyr")
library(dplyr)

# Impute missing values with the median of total_bedrooms using dplyr
housing_copy <- housing_copy %>%
  mutate(total_bedrooms = ifelse(is.na(total_bedrooms), 
                                 median(total_bedrooms, na.rm = TRUE), 
                                 total_bedrooms))

summary(housing_copy)

#No more NA's 

install.packages("corrplot")
library(corrplot)
corrplot(cor(housing_copy), method = "color", type = "upper")

#Create a histograms for each numeric variables 

names(housing_copy)
#"longitude"          "latitude"           "housing_median_age" "total_rooms"        "total_bedrooms"    
# "population"         "households"         "median_income"      "median_house_value"

par(mfrow=c(3,3))

for (col_name in names(housing_copy)) {
  hist(housing_copy[[col_name]], 
       main = paste("Histogram of", col_name), 
       col = 'pink', 
       xlab = col_name, 
       freq = TRUE)
}

#

for (col_name in names(housing_copy)) {
  boxplot(housing_copy[[col_name]], 
          main = paste("Boxplot of", col_name), 
          ylab = col_name, 
          col = "lightblue", 
          border = "blue")}


#We can barely analyze each boxplot, we can see them one at the time 

par(mfrow=c(1,1))
boxplot(housing_copy$total_rooms, 
        main = paste("Boxplot of total_rooms"), 
        ylab = "longitude", 
        col = "lightblue", 
        border = "blue")


boxplot(housing_copy$longitude, 
        main = paste("Boxplot of longitude"), 
        ylab = "longitude", 
        col = "lightblue", 
        border = "blue")

boxplot(housing_copy$median_income, 
        main = paste("Boxplot of median_income"), 
        ylab = "median_income", 
        col = "lightblue", 
        border = "blue")

#By observing the median income boxplot , we can see that there is a lot of point that 
#seems to be outliers as they are beyound the whiskers. 
#same for the boxplot of households , total beddoor , and totals rooms 



boxplot(housing_copy$median_income, 
        main = paste("Boxplot of median_income"), 
        ylab = "median_income", 
        col = "lightblue", 
        border = "blue")





###f/

par(mfrow=c(1,1))

boxplot(housing$housing_median_age~ housing$ocean_proximity, 
        col=c("magenta","pink","yellow","orange",'red'))

boxplot(housing$median_income~ housing$ocean_proximity, 
        col=c("magenta","pink","yellow","orange",'red'))

boxplot(housing$median_house_value~ housing$ocean_proximity, 
        col=c("magenta","pink","yellow","orange",'red'))


#3/ Data Transformation 

#a/
install.packages("dplyr")
library(dplyr)

# Impute missing values with the median of total_bedrooms using dplyr
housing <- housing %>%
  mutate(total_bedrooms = ifelse(is.na(total_bedrooms), 
                                 median(total_bedrooms, na.rm = TRUE), 
                                 total_bedrooms))

summary(housing)
#We see no more NA's in the feature total_bedrooms 

#b/

install.packages('fastDummies')
library(fastDummies)

# Create dummy variables for ocean_proximity, 
#by putting 'remove_selected_columns ' to TRUE , the columns ocean_proximity is deleted.

housing <- dummy_cols(housing, select_columns = "ocean_proximity", remove_first_dummy = FALSE, remove_selected_columns = T)


# View the updated dataset
head(housing)

#c/let's use the pipeline from dplyr library

housing<- housing %>%
  mutate(mean_bedrooms=total_bedrooms/households,
  mean_rooms=total_rooms/households ) %>%
  select(-total_bedrooms, -total_rooms)

head(housing)

#> head(housing)
#longitude latitude housing_median_age population households median_income median_house_value ocean_proximity_<1H OCEAN
#1   -122.23    37.88                 41        322        126        8.3252             452600                         0
#2   -122.22    37.86                 21       2401       1138        8.3014             358500                         0
#3   -122.24    37.85                 52        496        177        7.2574             352100                         0
#4   -122.25    37.85                 52        558        219        5.6431             341300                         0
#5   -122.25    37.85                 52        565        259        3.8462             342200                         0
#6   -122.25    37.85                 52        413        193        4.0368             269700                         0
#ocean_proximity_INLAND ocean_proximity_ISLAND ocean_proximity_NEAR BAY ocean_proximity_NEAR OCEAN mean_bedrooms mean_rooms
#1                      0                      0                        1                          0     1.0238095   6.984127
#2                      0                      0                        1                          0     0.9718805   6.238137
#3                      0                      0                        1                          0     1.0734463   8.288136
#4                      0                      0                        1                          0     1.0730594   5.817352
#5                      0                      0                        1                          0     1.0810811   6.281853
#6                      0                      0                        1                          0     1.1036269   4.761658



#d/feature scaling
#we are going to normalize every features excepts the median_house_value 


#In the housing dataset , every features are already numeric variable 
# Let's exclude median_house_value (response variable) and binary variables (0 or 1)

columns_to_scale <- names(housing) %>%
  setdiff(c("median_house_value")) %>%
  setdiff(names(housing)[sapply(housing, function(x) all(x %in% c(0, 1)))])

columns_to_scale
#[1] "longitude"          "latitude"           "housing_median_age" "population"         "households"         "median_income"     
#[7] "mean_bedrooms"      "mean_rooms"  


# Scale the selected columns
housing[columns_to_scale] <- lapply(housing[columns_to_scale], scale)

# View the scaled dataset
head(housing)

#longitude latitude housing_median_age population households median_income median_house_value ocean_proximity_<1H OCEAN
#1 -1.327803 1.052523          0.9821189 -0.9744050 -0.9770092    2.34470896             452600                         0
#2 -1.322812 1.043159         -0.6070042  0.8614180  1.6699206    2.33218146             358500                         0
#3 -1.332794 1.038478          1.8561366 -0.8207575 -0.8436165    1.78265622             352100                         0
#4 -1.337785 1.038478          1.8561366 -0.7660095 -0.7337637    0.93294491             341300                         0
#5 -1.337785 1.038478          1.8561366 -0.7598283 -0.6291419   -0.01288068             342200                         0
#6 -1.337785 1.038478          1.8561366 -0.8940491 -0.8017678    0.08744452             269700                         0
#ocean_proximity_INLAND ocean_proximity_ISLAND ocean_proximity_NEAR BAY ocean_proximity_NEAR OCEAN mean_bedrooms mean_rooms
#1                      0                      0                        1                          0  -0.148510661  0.6285442
#2                      0                      0                        1                          0  -0.248535936  0.3270334
#3                      0                      0                        1                          0  -0.052900657  1.1555925
#4                      0                      0                        1                          0  -0.053646030  0.1569623
#5                      0                      0                        1                          0  -0.038194658  0.3447024
#6                      0                      0                        1                          0   0.005232996 -0.2697231


cleaned_housing<- housing

names(cleaned_housing)

names(cleaned_housing)<- gsub("ocean_proximity_","",names(cleaned_housing))

names(cleaned_housing)

#[1] "longitude"          "latitude"           "housing_median_age" "population"        
#[5] "households"         "median_income"      "median_house_value" "<1H OCEAN"         
#[9] "INLAND"             "ISLAND"             "NEAR BAY"           "NEAR OCEAN"        
#[13] "mean_bedrooms"      "mean_rooms"   



#4/ Create Training and Test sets 



#a/
n<-nrow(cleaned_housing)

set.seed(22)
index<- sample(n,n)

#b/

ntrain<-round(n*0.7)
tindex<- sample(n,ntrain)

train<-cleaned_housing[tindex,]

#c/ 

test<-cleaned_housing[-tindex,]

head(test)

#5/ Supervised Machine Learning-Regression 


#Let's create x_train and x_test  dataset which contain every feature from cleaned_housing dataset
# except the target value 



x_train<-train
x_train$median_house_value<-NULL 

names(x_train)

#[1] "longitude"          "latitude"           "housing_median_age" "population"        
#[5] "households"         "median_income"      "<1H OCEAN"          "INLAND"            
#[9] "ISLAND"             "NEAR BAY"           "NEAR OCEAN"         "mean_bedrooms"     
#[13] "mean_rooms"     

x_test<-test
x_test$median_house_value<-NULL 

names(x_test)


#now let's do the same for the target variable 

y_train<-train$median_house_value
y_test<-test$median_house_value

head(y_train)
#[1]  95800 124700 152500 182500  97400 306700

head(y_test)

#[1] 452600 352100 241400 213500 191300 152500


install.packages("randomForest")
library(randomForest)


rf = randomForest(x=x_train, y=y_train ,
                  ntree=500, importance=TRUE)



names(rf)

#[1] "call"            "type"            "predicted"       "mse"            
#[5] "rsq"             "oob.times"       "importance"      "importanceSD"   
#[9] "localImportance" "proximity"       "ntree"           "mtry"           
#[13] "forest"          "coefs"           "y"               "test"           
#[17] "inbag"       



#6. Evaluating Model Performance

#a/
#Let's calculate the rmse of the model , we take the last mse and we use sqrt


rmse <-sqrt(rf$mse[500])
rmse
#[1] 49396.36


#b/ already done higher

#c/


prediction<-predict(object = rf,newdata = x_test,type="response")

class(prediction)
head(prediction)

#       1        3        8       13       14       17 
#422364.4 409874.7 240587.8 216304.5 172363.6 197829.1 

rmse_test <- sqrt(mean((prediction - y_test)^2))
print(rmse_test)

#[1] 49372.

#d/we can see that the rmse on the training dataset and on the test dataset is pretty similar. 
#Thus, we can deduce that the model is not overfitting and is generalizing pretty well.


#e/

varImpPlot(rf)

#We observe that on the first graph (%Inc MSE Increasing in mean squarred error)
#the feature 'median_income' and 'housing_median_age' contribute the most to 
#the model predictive accuracy. The features 'longitude' and 'latitude'  also impact the model's accuracy 
#which is logical since the location of a house significantly influence its price. 



#By examining "IncNodePurity," we observe that the feature median_income has the greatest impact 
#on node purity. This variable is highly significant for the tree.



#We might want to retrain our model by using the features variable that are the most
#"important" according to these plot. SO we will use median_income, housing_median_age , 
#longitude and latitude to train our new model.


# Select the most important features for the new training data
new_xtrain <- x_train[, c("median_income", "housing_median_age", "longitude", "latitude")]
new_xtest <- x_test[, c("median_income", "housing_median_age", "longitude", "latitude")]


head(new_xtrain)
#median_income housing_median_age  longitude   latitude
#13657    -1.1596725         -1.7988465  1.1328518 -0.7405883
#12956    -0.3345951         -0.8453727 -0.8636227  1.4364265
#16573    -0.5504048          0.7437504 -0.9235170  0.9869783
#10232     0.9032579          0.5053819  0.8184070 -0.8295416
#5221     -1.3794300          0.5848381  0.6636803 -0.7874059
#15986     0.1098150          1.8561366 -1.4475915  0.9963418

head(new_xtest)

new_rf = randomForest(x=new_xtrain, y=y_train ,
                  ntree=500, importance=TRUE)

#Let's take a look on new rmse 


rmse <-sqrt(new_rf$mse[500])
rmse

#[1] 51537.84

prediction<-predict(new_rf,newdata =new_xtest,type="response")
rmse_test <- sqrt(mean((prediction - y_test)^2))
print(rmse_test)

#[1] 50735.52

#We see a little difference between the rmse on the training dataset and on the test dataset 
#but it is generalizing pretty well.


#However, we can see that the RMSE of the new model, trained with only 4 features, 
#is slightly higher than the RMSE of the old model, which was trained with all the features.
#RMSE of the new model = 51,537.84
#RMSE of the old model = 49,396.36
#We deduce that the old model is giving better predictions, which is not surprising
#since it takes more features into account when predicting house prices.
#However, in the new model, the RMSE only increases by $1,000–$2,000, which is not a significant difference.
#It is performing fairly well considering it only uses 4 features instead of 13


