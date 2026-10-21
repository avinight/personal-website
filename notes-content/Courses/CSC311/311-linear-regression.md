---
tags:
  - course/csc311
  - computer-science
---

Questions I have:
- The model restricts the hypothesis space using what methods, what is the restriction?
- Why are we learning an approximate function f, when we can take each data point and map it to its target? A: Regression is a form of interpolation
- Is the model learning or making an inference like in lecture 1. A: We are learning. The goal is to make an inference 

Advantages of Direct Solution
- Deriving the solution requires no iterations.
Disadvantages of Direct Solution
- Computing $(\mathbf{X}^T \mathbf{X})^{-1} \mathbf{X}^T \mathbf{t}$ can be expensive if $D$ is large.
- Matrix inversion is an $\mathcal{O}(D^3)$ algorithm.
- Does not generalize to other models or loss functions.


![[Gradient Vectorization.webp]]

# Lab

# Homework

> [!question] 
> T/F By using correlations between the features of a dataset, Linear regression models can
> capture non-linear relationships between the initial features and target values.

False. Linear regression models cannot capture non-linear relationships between the initial features and target values, even when using correlations between features.
1. **Linear regression is inherently linear**: The model assumes a linear relationship of the form `y = w₀ + w₁x₁ + w₂x₂ + ... + wₙxₙ`. This is linear in both the parameters (weights) and the features.
2. **Correlations don't create non-linearity**: While features may be correlated with each other, linear regression still combines them linearly. Correlation is a measure of linear association between variables, not non-linear relationships.
3. **What linear regression can do**: It can capture linear combinations of features and their interactions if you explicitly add interaction terms (like x₁ × x₂) or polynomial terms (like x₁²) as new features to your dataset.
4. **To capture non-linear relationships**, you would need to:
    - Manually engineer non-linear features (polynomial terms, interactions, etc.)
    - Use non-linear models (polynomial regression, kernel methods, neural networks, etc.)
    - Apply non-linear transformations to the features before applying linear regression

> [!question] 
> T/F The following cost function will optimize the linear regression model to fit the data
> well:
> $$\mathcal{E}(\mathbf{w}) = \frac{1}{N} \sum_{i=1}^N \frac{1}{(\mathbf{w}^T \mathbf{x}^{(i)} - t^{(i)})^2}$$

**False**. This cost function will **not** optimize the linear regression model to fit the data well.
1. **Inverted relationship**: The cost function uses `1/(error)²` instead of `(error)²`. This means:
    - When predictions are **close** to targets (small error), the cost becomes **very large**
    - When predictions are **far** from targets (large error), the cost becomes **very small**
2. **Optimization will minimize cost**: Since optimization algorithms minimize the cost function, this will:
    - Push the model to make **worse** predictions (larger errors)
    - Avoid making **good** predictions (smaller errors)
    - Lead to the worst possible fit
3. **Mathematical issues**:
    - The function becomes undefined when `w^T x^(i) = t^(i)` (division by zero)
    - The gradient behavior near perfect predictions becomes problematic

> [!question] 
> T/F The following cost function will optimize the linear regression model to fit the data
> well:
> $$\mathcal{E}(\mathbf{w}) = \frac{1}{N} \sum_{i=1}^N \text{exp}({(\mathbf{w}^T \mathbf{x}^{(i)} - t^{(i)})^2})$$

**False**. This cost function will **not** optimize the linear regression model to fit the data well.

> [!question] 
> What are the pros and cons of using the linear regression model rather than another machine
> learning model to fit a given data set?

Pros:
- Easy to understand and interpret.
- Computationally efficient to train.
- Good baseline model.
Cons:
- Assumes linear relationship.
- Sensitive to outliers.
- Limited to continuous features.
- Struggles if some features are highly correlated.
- High bias model.

> [!question] 
> T/F The number of parameters in a linear regression model is equal to the number of
> datapoints in the training set.

**False**. The number of parameters in a linear regression model is **not** equal to the number of datapoints in the training set.

> [!question] 
> In class, we showed that the vectorized gradient for linear regression is as follows.
> $$\nabla_w \mathcal{E}(\mathbf{w}) = \frac{1}{N} \mathbf{X}^T(\mathbf{Xw} - \mathbf{t})$$
> However, your friend Makayla tried to re-derive the gradient and obtained the following
> expression.
> $$\nabla_w \mathcal{E}(\mathbf{w}) = \frac{1}{N} (\mathbf{Xw} - \mathbf{t})^T \mathbf{X}$$
> Is Makayla’s expression correct? Justify your answer.

Yes, they are equivalent under the transpose property: $(AB)^T = A^T B^T$

Show that the linear regression model in Eq. 3 can be alternatively written as the model in
Eq. 4. Write the values and shapes of w2 and x2 relating to that of w1 and x1.
$$
\begin{aligned}
y &= \mathbf{w_1}^T \mathbf{x_1} + b \\
y &= \mathbf{w_2}^T \mathbf{x_2}
\end{aligned}
$$
We can absorb b into w1 and append 1 to x1 to compensate.

we will have $(D+1) \times 1$ vectors

## Gradient Descent

2.1 Short Questions

### LO: Compare and contrast direct solution and gradient descent.

> [!question] 
> What are the advantages of using gradient descent over the direct solution for optimizing
> the parameters of a machine learning model?

A general method for optimizing a function
Easier to implement than direct solution
More efficient than direct solution
- Each GD update costs $\mathcal{O}(ND)$ rather than $\mathcal{O}(D^3)$ for matrix inversion.
- much cheaper if $D$ is large (i.e., high-dimensional data).

### LO: Explain the components of the gradient descent update rule.

> [!question] 
> The gradient descent update rule is given below, where E is the cost function.
> $$w \leftarrow w - \alpha \nabla_w \mathcal{E}(w)$$
> (a) What is the direction of each update, and how does it relate to the sign of the
> gradient?
> (b) What is the magnitude of each update, and how does it relate to the magnitude of
> the gradient?
> (c) What is the role of the learning rate in gradient descent? How does choosing a learning
> rate that is too small or too large affect the convergence of the algorithm?

A) direction of each update is negative the gradient
B) magnitude is proportional to the magnitude of the gradient 
C) Learning rate controls **how big a step we take along the negative gradient** at each iteration.
- Too small, and it takes too long to converge
- Too large and it may diverge

### LO: Explain the components of the gradient descent algorithm.

Discuss the criteria for stopping the gradient descent algorithm. What practical considerations might influence the choice of stopping condition?

> [!question] 
> What are two practical stopping conditions for gradient descent mentioned in the lecture?

- Stop when the change in $F(\mathbf{w})$ is small enough.When change in $\epsilon$ is small enough.
- Stop when we are tired of waiting. After some number of iterations

> [!question] 
> What is the computational complexity of each gradient descent update for linear regression
> with N data points and D features?

- $\mathcal{O}(ND)$ - N data points, D features

> [!question] 
> According to the lecture, what are the three components of a modular approach to machine
> learning?

- Model - Describes relationships between variables.
- Loss/Cost function - Quantifies how badly the model fits the data.
- Optimization algorithm - Fit a model that minimizes the loss.
