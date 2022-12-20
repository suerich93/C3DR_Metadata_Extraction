# Assignment 2, week 2

## Tree cover prediction using Linear regression and RF regression

### Your task
Tree cover products represent a canopy closure for high vegetation. It is encoded as a percentage (0-100) indicating different canopy closure levels. Tree cover products [e.g. by University of Maryland](https://earthenginepartners.appspot.com/science-2013-global-forest) have a variety of uses: generating forest masks, identifying dense forested areas, forest biomass estimation, understanding forest structure, and so on. 
You would like to map tree percent cover of Gewata region using random forest regression and linear regression. In general the same principle as classification apply here. The only difference is that the response variable is continuous, not categorical.  Since you will carry out two regression algorithms, it is interesting to see the difference between the results. Simply subtracting the two results is sufficent here. Also, you would like to know how the tree percent cover varies among different land cover types. 

### Details
- The Landsat data can be found [here](https://www.dropbox.com/s/cv1de2fmy855wpy/data.zip?dl=1)


### Requirements
- The data should be downloaded in your script, and not be uploaded to your Git repository
- Write and use at least 2 functions for analyzing the results of the regressions
- Visualize the two predictions as maps and save them as a `.png` files
- Identify three most important explanatory variables (bands) for tree cover prediction using Random Forest regression
- Visualize the resulting difference map, and save as a `.png` file
- Visualize tree percent covers for different land cover types for each of the results and save as a `.png` file


### Assessment
You will be assessed according to the rubric that you can find on CodeGrade. Ensure you use the proper project structure, pay attention to documentation, Git use and keep the above requirements in mind. The functionality of you code will be assessed on: 

Task 1: Predict tree cover using `lm()` AND `RandomForest()` models 

Task 2: Identify the Landsat bands that have high influence in the tree cover prediction and compare the results of the two models by creating a difference prediction raster

Task 3: Compare the results of the two models for different land cover classes (you used for the Exercise 7). Calculate average tree cover percent for each land cover class.



### Hints
- `?zonal()` 
- `?lm()` on how linear regression works
