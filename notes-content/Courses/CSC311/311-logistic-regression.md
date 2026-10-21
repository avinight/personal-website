# Feature Mapping

What if the relationship is non-linear?


# Regularization

- Either tune M using validation data or use a regularizer: fixed number of parameters, changing magnitude of the weights.
- Does it change the number of parameters in the model?
- Larger M means more parameters, smaller M means fewer parameters.

What is regularization?
- Quantify between different models
- Prefer weights that are smaller in magnitiude and penalize larger weights; very sensitive to a specific feature, when we want the output to prefer multiple features

Regularize model in the project


# Stochastic Gradient Descent

# Mini-Batch Gradient Descent

```
Repeat until convergence (an epoch):
	Group the data set into mini-batches of size 𝑘
	For each mini-batch (an iteration):
		Estimate the gradient using the mini-batch
		Update the parameters based on the gradient
```

niter = epochs * (N/ batch size)
# Lab

# Homework

## Feature Mapping


> [!question] 
> How can we learn a non-linear relationship using a linear regression model? What does the
> word “linear” mean in linear regression?

We can use feature mapping to learn a non-linear relationship by creating a basis and expanding to it. For example, polynomial feature mapping. Linear in linear regression means satisfies the linearity properties.

### LO: Determine the decision boundary of a machine learning model with a non-linear feature map.

Imagine you plot the training and validation error curves for a machine learning model. The
x-axis represents model complexity, while the y-axis shows the training or validation error.
• Describe the expected shapes of these curves.
• Explain how you can use these curves to determine if the model is underfitting, over-
fitting, or well-fitted to the data.

Training error starts high when model complexity is low, causing it to underfit. Then Training error becomes low when it begins to generalize well and fits the data. Then as model complexity becomes large, the model overfits and training error becomes 0 while validation/test error becomes very high.

- **Training error (y_train)**  
    Starts **high** when model complexity is very low (model can’t fit data → underfit).  
    As complexity increases the training error **monotonically decreases** (more capacity → can fit training data better).  
    Eventually it approaches (but does not go below) the irreducible noise floor; it keeps decreasing or plateaus.
- **Validation error (y_val)**  
    Starts **high** at very low complexity (underfitting).  
    As complexity increases the validation error **initially decreases** (model gets better at capturing pattern).  
    After some point it reaches a **minimum** (best generalization) and then **increases** as complexity grows further (overfitting — the model fits noise).  
    So the validation curve is typically **U-shaped** (or bowl-shaped): decrease → minimum → increase.

- **Underfitting (high bias)**
    - Training error: **high**.
    - Validation error: **high**, and close to training error.
    - Interpretation: model capacity too small to capture the true pattern.
    - Action: increase model complexity (richer features, deeper net), reduce regularization.
- **Good fit (sweet spot)**
    - Training error: **low or moderate**.
    - Validation error: **low** and **about the same** as training error (small gap).
    - Interpretation: model captures the pattern and generalizes well.
    - Action: this is the region you want to pick (choose complexity near the validation minimum).
- **Overfitting (high variance)**
    - Training error: **very low** (possibly near zero).
    - Validation error: **higher** and **increasing** as complexity grows; there is a **large gap** between train and val error.
    - Interpretation: model is fitting noise / idiosyncrasies of training data, harming generalization.
    - Action: reduce complexity, add regularization, get more data, or use early stopping.
## Regularization

Suppose you are training a regression model using a regularized cost function
Ereg(w) = E(w) + λR(w)
What could happen if λ is too large? What if λ is too small?

If lambda is large, 
- model too “simple”
- poor fit to training data
- model could underfit

If lambda is small, 
- model too “complex”
- great fit to training data.
- large test error.
- model could overfit.

Consider the lecture example on learning a polynomial function of degree M . In class, we
discussed two strategies below to control the model’s complexity. Explain the difference
between these strategies in terms of how they affect the number of model parameters and
the magnitudes of the model parameters.

• Tune M as a hyperparameter using a validation set.
• Use a regularizer.

One common regularization strategy in machine learning is to penalize models with large
weight magnitudes. Explain why having a large weight on a feature can be problematic.

## Binary Linear Classification

Explain how we started with the first model below and simplified it to the second model.
Model 1:
$$
\begin{aligned}
z = \mathbf{w}^T \mathbf{x} + b \\
y = \begin{cases} 
1, z ≥ r \\
0, z < r
\end{cases}
\end{aligned}
$$
Model 2:
$$
\begin{aligned}
z = \mathbf{w}^T \mathbf{x}\\
y = \begin{cases} 
1, z \geq 0 \\
0, z < 0
\end{cases}
\end{aligned}
$$
We do 
$$
\begin{aligned}
z &= \mathbf{w}^T \mathbf{x} + b \geq r \\
z &= \mathbf{w}^T \mathbf{x} + (b - r) \geq 0 \\
z &= \mathbf{w}^T \mathbf{x} + b_0 \geq 0 \\
z &= \mathbf{w}^T \mathbf{x} \geq 0
\end{aligned}
$$

where $x_0=1$ and $b_0$ is the weight for $x_0$ absorbed into w


## Logistic Regression

## Stochastic Gradient Descent

> [!question] 
> What is the difference between an epoch and an iteration?

epoch: one pass over the data set
iteration: one update for each weight

> [!question] 
> Compare and contrast stochastic, mini-batch, and batch gradient descents in terms of the
> number of examples used to compute the gradient estimate for each update.

Stochastic uses one example
Mini-batch uses random subset of examples
Batch uses all examples

> [!question] 
> Compare and contrast stochastic, mini-batch, and batch gradient descents in terms of the
> computational complexity of performing each update.

Stochastic is fast
Mini-batch is moderate
Batch is slow

> [!question] 
> Compare and contrast stochastic, mini-batch, and batch gradient descents in terms of the
> memory requirement of performing each update.

Stochastic doesn't require much memory
Mini-batch requires as much memory as the subset
Batch requires a lot of memory

> [!question] 
> Compare and contrast stochastic, mini-batch, and batch gradient descents in terms of the
> accuracy of the gradient estimates.

Stochastic is very noisy
Mini-batch can be noisy 
Batch is accurate

> [!question] 
> Compare and contrast stochastic, mini-batch, and batch gradient descents in terms of
> whether computing the gradient estimates could take advantage of optimized vectorized
> operations.

Stochastic cannot take advantage of optimized vectorized operations
Mini-batch can
Batch can