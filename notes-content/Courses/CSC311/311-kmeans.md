K-means is guaranteed to converge to the global minimum of its objective function.
- False, it converges to a local minimum

When updating cluster assignments in K-means, each data point is assigned to the cluster
with the smallest sum of squared distances to all points in that cluster.
- False, each datapoint is assigned to the cluster with the nearest centroid.

The K-means algorithm optimizes by minimizing the total squared distances of data points
to their assigned cluster centers.
- True, this is the objective function of kmeans

K-means always requires a fixed number of iterations to converge.
- False, it always converges, we cannot have negative distance, but the iterations are not fixed. It depends on the dataset

In K-means, the cluster center is calculated as the median of all points assigned to that cluster.
- False, its k-means, not k-medians (which is more robust to outliers)

K-means is an example of unsupervised learning.
- True, its a classic algorithm in unsupervised learning where it learns the structure of the data without ground truth labels.

K-means works equally well with clusters of any shape.
- False. K-means assumes clusters are spherical convex and have similar variances

# Short Answer
1. Why is K-Means described as a "chicken and egg" problem and how is this resolved?
	- If we know the assignments we can predict the centers
	- If we know the centers we can predict the assignments

2. What are the main limitations of the K-Means algorithm?
	- Assumes spherical clusters
	- Assignments are hard
	- Sensitive to initialization
	- Sensitive to outliers

3. Would you expect K-Means to work well with high-dimensional data? Justify your answer in a few sentences.
	I would expect it to suffer from curse of dimensionality as knn

4. Why is direct optimization of the likelihood function challenging for GMMs?
	 - There is no closed form solution. Non-convex objective
	 - Gradient descent is difficult. Derivatives are messy and costly to compute
	 - This necessitates the Expectation-Maximization algorithm
	 
5. Suppose that we want to fit a GMM using maximum likelihood. Why don’t we want to find the global optimum parameters for the model?
	- GMMs are universal density approximators
	- With maximum likelihood, the training likelihood can grow without bound
		- By increasing the number of components or
		- placing a tiny-variance Gaussian on one training example.
	- Global optimum corresponds to severe overfitting and is not useful

6. What is the fundamental difference in how K-means and GMM assign data points to clusters?
	- K-means uses hard assignment. Each point belongs strictly to one cluster. (binary)
	- GMM uses soft probabilistic assignment. Each point has a probability of belonging to every cluster. 

7. How do K-means and GMM differ in their representation of cluster shapes?
	- GMM relaxes the spherical constraint, it can be ellipsoidal.

8. Explain the key differences between the optimization objectives of K-means and GMM.

9. What advantages does GMM offer over K-means that make it worth the additional computational complexity?
	- It is more flexible.

10. Is the K-means algorithm guaranteed to converge? Explain in a few sentences.
	- Yes, it is guaranteed to converge to a local optimum.
	- Finite number of possible assignments
	- assignment/update steps are guaranteed to decrease
	- We minimize objective function and is bounded below, we cannot have negative squared distance.

