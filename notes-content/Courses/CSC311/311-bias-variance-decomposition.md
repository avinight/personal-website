
Bias: Model’s inability to capture true relationship; underfitting
Variance: Model’s sensitivity to random fluctuations; overfitting
Bayes Error: Inherent noise in the problem

Generalization error = Bias + Variance + Bayes Error

# MLE

What is the rationale behind this estimate? When would this estimation strategy not work?
- Small dataset
- different params yielding same likelihood values
- unbounded domain for a parameter
- multiple maxima

To derive the maximum likelihood estimates, we need to answer:
1. What is 𝑃 data 𝜃 , probability of observed data given 𝜃?
2. What value of 𝜃 maximizes the probability of the observed data?

Why log-likelihood?
- Preserves the location of the maximum
- Efficient to calculate sums instead of products
- Numerical stability

Why and how does MLE overfit and not underfit?
Why MLE is guaranteed a supremum and not infimum or other critical point?
Is MLE value guaranteed by the data? If not what is another dataset possible under the same MLE value?

what is unbounded domain mean???
How do MLE and MAP actually generate likelihood estimates?

# MAP

Why a, b are single parameter estimates? Point estimates for MLE and MAP?




We need to put the estimates in the cheat sheet