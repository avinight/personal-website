https://youtu.be/XUTk3pyHIxY?si=M4eI0vnSxVisvG-h

The 
# Lab

> [!question] 
> Why did we create a dataset with a roughly equal number of data points that have `target_heart=1` and `target_heart=0`? In particular, what do you think might happen to our decision tree if we allowed 92% our training data to reflect the true prevalence of heart disease?

To prevent bias towards the majority class. If we allowed 92% of our training data to reflect the true prevalence (mostly `target_heart=0`), the decision tree would likely learn to always predict "no heart disease" to maximize accuracy, ignoring the minority class.

`pandas.crosstab`
https://pandas.pydata.org/docs/reference/api/pandas.crosstab.html
Compute a simple cross tabulation of two (or more) factors.

By default, computes a frequency table of the factors unless an array of values and an aggregation function are passed.

Lots of outliers in BMI

`test_train_split`

Split arrays or matrices into random train and test subsets.

Quick utility that wraps input validation, `next(ShuffleSplit().split(X, y))`, and application to input data into a single call for splitting (and optionally subsampling) data into a one-liner.

# Homework

### LO: Understand the decision tree learning algorithm.

> [!question] 
> What are some examples of model parameters of the decision tree model? what are some
> examples of hyperparameters of the decision tree model?

**Model parameters** of a decision tree are learned from the data during training. Examples include:

- The specific feature and threshold chosen at each split (e.g., "age > 50").
- The structure of the tree (which features are used at which nodes).
- The class label assigned to each leaf node.

**Hyperparameters** are set before training and control the learning process. Examples include:

- `max_depth`: the maximum depth of the tree.
- `min_samples_split`: the minimum number of samples required to split a node.
- `criterion`: the function used to measure the quality of a split (e.g., "gini" or "entropy").
- `min_samples_leaf`: the minimum number of samples required at a leaf node.

> [!question] 
> Can we test the same feature more than once along one branch in a decision tree? Justify
> your answer

Yes, this just restricts the number of samples. This happens when the optimal split at different levels of the tree involves the same feature but with different threshold values. Decision trees do not restrict splits to unique features per branch.

### LO: Explain the pros and cons of the decision tree model.

> [!question] 
> “A decision tree is a universal function approximator.” What does this statement mean?

The statement means that an arbitrarily deep decision tree can implement any function from a multi-dimensional Euclidean space to real numbers.

Decision trees can represent any function arbitrarily well. In other words, decision trees are flexible enough to represent any relationship between features and targets, including highly nonlinear and complex patterns. However, in practice, very deep trees may overfit the training data and generalize poorly.

> [!question] 
> Our decision tree learning algorithm is a “greedy" algorithm. Explain what “greedy” means.

At each step, choose the feature (and split) that most reduces a loss.

- Uncertainty (e.g., entropy)
- Impurity (e.g., Gini)
- Squared error (for regression)

A “greedy” algorithm makes the locally optimal choice at each step, without considering future consequences. In decision tree learning, this means the algorithm selects the best feature and threshold to split the data at each node based only on the current data and split quality (e.g., information gain or Gini impurity), rather than searching for a sequence of splits that might yield a better overall tree. This approach is fast and simple, but may not always produce the globally optimal tree.

> [!question] 
> Is it possible to run into a situation where there are no features/splits left to test at a node?
> Justify your answer briefly.

Yes, it is possible. In case there are two data points sharing the same feature with different labels (i.e. data is noisy), a decision tree might run out of features/splits to classify those data points.

Yes, it is possible to run into a situation where there are no features or splits left to test at a node. This can happen if all features have already been used for splitting along the current branch (in some implementations), or if all remaining features have identical values for all samples at the node, so no further split can separate the data. In such cases, the node becomes a leaf and is assigned the majority class label of the samples at that node.

> [!question] 
> What are the advantages/disadvantages of a tree that is deep (versus shallow)? Justify
> your answer. You may want to consider underfitting/overfitting, computational cost of
> training/making predictions, and the interpretability of the model.

**Advantages of a deep tree:**
- Can model complex relationships and capture subtle patterns in the data.
- Lower risk of underfitting, as the tree can fit the training data very closely.

**Disadvantages of a deep tree:**
- High risk of overfitting: the tree may memorize noise in the training data and generalize poorly to new data.
- Increased computational cost for both training and prediction, as more nodes must be processed.
- Reduced interpretability: deep trees are harder to visualize and understand compared to shallow trees.

**Summary:**  
A shallow tree is more interpretable and less likely to overfit, but may underfit if the data is complex. A deep tree can fit complex data but may overfit and be harder to interpret and more costly to use.

> [!question] 
> Recall that the KNN model suffers from the curse of dimensionality and it is a good idea
> to normalize the features before applying KNN. What about decision tree? Can we apply
> decision tree to high dimensional data?

Since decision trees do not operate over distances and instead split data based on individual feature thresholds, it doesn't suffer from the curse of dimensionality. However, with very high-dimensional data, trees may become complex and overfit, so feature selection or regularization may still be helpful.

> [!question] 
> Can decision tree handle missing values in a data set? For example, consider the lemon
> versus orange data set. Suppose that for one fruit, we know its weight but not its height.

Standard decision tree implementations in libraries like scikit-learn **cannot** directly handle missing values; they require all feature values to be present for each sample. If a sample is missing a value (e.g., height for a fruit), you must either impute the missing value (e.g., fill with mean or median), remove the sample, or use a tree algorithm that supports missing values (such as some implementations in XGBoost or LightGBM). Some decision tree algorithms can handle missing values by learning surrogate splits, but this is not supported in basic scikit-learn DecisionTreeClassifier.

### LO: Compare and contrast KNN and decision tree.

> [!question] 
> Compare and contrast the KNN and decision tree models regarding the following aspects.
> (a) Poorly scaled data, e.g. one feature has a much larger range than another feature.
> (b) Training complexity
> (c) Categorical features, e.g. color = {red, blue}
> (d) Test complexity


6 + 10 + 1 + 6 + 8


