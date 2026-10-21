Tags: #Statistics 
Links: [[220 STA220]], <a href=https://en.wikipedia.org/wiki/Linear_regression>Linear Regression</a>,<a href=https://stats.stackexchange.com/questions/135564/null-hypothesis-for-linear-regression> Null Hypothesis Confusion </a>

---
# Linear Regression

A linear regression is a line of best fit for our data.
- Can the relationship in our scatterplots be represented by a straight line?
- We can predict or describe a relationship
- Best predicts the response variable from the explanatory variable

Cautions
- The intercept may only have a practical interpretation if a value of 0 for the predictor variable is within the range of the data.
- Extrapolation shouldn't be used outside the range of data, linear relationship may not continue
- More complicated models could be suited to model the data when there is a subtle, but distinct pattern that can go unnoticed.
- Residual plot should look like random scatter for a straight line model to be appropriate. -> [[Autocorrelation]]
- Leverage point
	- if it is an outlier in the in the horizontal direction
	- Influential if there seems to not be an linear relationship between variables
	- One leverage point doesn't determine the regression line

<u>Variables</u>
	- y: response, dependent
	- x: assumed fixed, predictor, independent, regressor, explanatory
	
Data: $(x, y) = \{(x_1, y_1), ... , (x_n, y_n)\}$
Residuals: Devations from the line
	$$ e_i = y_i - \hat{y}_i $$
Minimizing square distance
Method of least squares:
- The regression line is found by minimizing the sum of squares of the vertical distances from the data points to the line.

Slope: 
- When x changes 1 unit, the corresponding average change in y is the slope.
- Slope of regression line can be calculated using standard deviations and correlation.
	$$b_1 = \frac{s_y}{s_x}r$$
	$s_y, s_x$ are the standard deviations

Intercept: 
- The expected value of y when x is 0.
$$ \hat{y} = b_0 + b_1x $$ -> predicted value by the regression
$$ b_0 = \bar{y} - b_1x $$
*The regression line passes through $(\bar{x}, \bar{y})$*

Sum of Squares: (Explained by regression line + Not explained by regression line)
	Each value of y to its mean
	$$ SS_{Total} = \sum_{i=1}^{n}(y_i - \bar{y})^2 $$

Regression Sum of Squares: (variation in the lines that is explained by the regression line)
	$\hat{y}_i =$ Distances that fit exactly along the regression line 
	$$ SS_{Regression} = \sum_{i=1}^{n}(\hat{y_i} - \bar{y})^2 $$
	
Residual Sum of Squares: (variation in the line that the regression does not explain)
	$$ SS_{Residual} = \sum_{i=1}^{n}(y_i - \hat{y})^2 =  \sum_{i=1}^{n}e_i^2$$
	
Total Sum of Squares = Regression Sum of Squares + Residual Sum of Squares

Formula for standard deviation
$$ s_y = \sqrt{\frac{1}{n-1} \sum_{i=1}^{n}(y_i - \bar{y})^2} $$

The coefficient of determination R^2
- The proportion of the variation in the response variable that is explained by the regression line.
$$ R^2 = SS_{Rregression}/SS_{Total} = 1 - SS_{Residual}/SS_{Total} $$
- R^2 is between
	- 0 (the line explains none of the variation in the response variable) and 
	- 1 (the line explains all of the variation in the response variable)
	- The square of the correlation between the response and predictor variables
- Correlation r is square root of R^2
- R^2 never indicates whether relationship is positive or negative
- Cautions
	- There are no general rules about how large R^2 should be.
		- Less variability (close to 1)
		- More natural variability (close to 0)
	- It's not possible to have a large value of R^2 even when the linear model is not ideal
		- Model that has R^2 very close to 1 should have a better explanation
	- R^2 is not meaningful if a linear model is not appropriate
		- Lots of variability + 1 point of significance
	- It's posisble to get very high R^2 by fitting complicated models to data using multiple regression. This is called overfitting and the resulting models typically fit poorly to new data.

Inference for the slope
- The predictor variable directly causes the response variable
- The response variable causes the predictor variable
- The predictor variable contributes to, but is not the sole cause of, the response variable.
- Confounding variables exist
- There is a common cause
- Both variables are changing over time
- The relationship is a coincedence

Conditions for Inference for Linear Regression
- Linear
	- Look at a scatter plot of the data. Follow-up a linear model with a plot of the residuals versus the predictor variable or the predicted values of the explanatory variable
- Independence
	- [[Autocorrelation]]
	- Understand data and how it was collected
- Normality
	- Look at normal quantile plot of the residuals
- Equal and constant variance
	- A line plus error noise:  $y = \beta_{0} + \beta_{1}x + \epsilon$
	- Check the scatterplot and residual plot for signs of non-constant variance
- Random

The goal of LR
- Is there a relationship between are response and predictor variables.

Transformations in Linear Regression

$$log_{10}(x) + 1 = log_{10}(10x)$$

[[Descriptive Statistics#^fda6e5 | Lurking Variable]]

[[Residual Plot]]

