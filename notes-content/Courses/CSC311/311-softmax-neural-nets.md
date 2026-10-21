
We want to avoid encoding categorical variables as numeric values. 
- inherent order and distance metric
Instead encode them as one-hot vectors.

# Softmax Regression Model
- Direct generalization of logistic regression


- Weights and biases for softmax regression -> derive the decision boundaries and draw them. This is expected and challenging.

Proof the XOR is linear separable.

# Questions

### 1.1 LO: Develop basic understandings of the softmax regression model.

Consider the problem of recognizing handwritten digits in the MNIST data set. Given a
28 × 28 pixel greyscale image of a digit, we would like to identify the digit using softmax
regression.
y = softmax(Wx + b)
Determine the dimensions of the quantities in this model.
What is the length of our input vector x? 28x28
What is the length of our one-hot target vector t? 10 x 1
What are the shapes of W and b? (10, 28 x 28) (10, 1)
How many (scalar) parameters are there in our model, in total?
10 x 784 + 10 = 7850




Consider the softmax activation function below.
$$ y_k = \frac{e^{z_k}}{\sum_{m=1}^K e^{z_m}}$$
Compute y if $\mathbf{z} = (0, -1, 2)$



How does the output layer differ from hidden layers in a neural network classifying data
into 10 classes? Explain why these differences are necessary.
2. We discussed several activation functions in lecture: hard threshold, logistic, tanh, and
ReLU.
(a) Why is the hard threshold function unsuitable for neural networks trained with gradient
descent?
(b) Which activation function is commonly used first in the hidden layers, and why?
(c) Why are logistic, softmax, or identity activation functions typically used in the output
layer?
(d) For ReLU, logistic, and tanh activation functions, identify the input values that can
lead to poor gradient signals and explain why this occurs.

## 4 Neural Network’s Expressive Power

Consider a two-layer neural network with the following structure.
• The input Layer has 2 input features: x1 and x2.
• The hidden layer has 3 neurons, each with an identity activation function.
• The output Layer has 1 output neuron (ˆy), with an identity activation function.
Let W1 (a 3x2 matrix) be the weights connecting the input layer to the hidden layer, and
W2 (a 1x3 matrix) be the weights connecting the hidden layer to the output layer. Let
b1 (a 3x1 vector) be the biases for the hidden layer, and b2 (a scalar) be the bias for the
output layer.

