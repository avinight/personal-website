Tags:
Links: [[220 STA220]]

---
# Distributions
-   [[Random variable]]
    
    A random variable takes an outcome from a random experiment and gives it a numerical value.
    
-   Independence
    
    If knowing the value of one does not affect the probability of the other.
    
-   Discrete Random Variable
    
    A discrete random variable can take one of a countable list of distinct values.
    
-   Continuous Random Variable
    
    A continuous random variable can take any value in an interval (or collection of intervals)

-   Bernoulli Random Variable
    
    Either true or false
    
-   Binomial Distribution
    
    Y ~ Bin(# of trials, probability of success)
    
    There are some conditions that random variable Y must satisfy in order to be Bin(n, p):
    
    -   _There is a fixed number n of independent and identical trials._ In our example there are 10 births per day, hence n = 10.
    -   _Each trial can result in one of only two possibilities called success or failure; that is each trial is a Bernoulli trial._ In our example the two possibilities are Boy or Girl.
    -   _The probability p of success is constant from trial to trial_. This means that probability that a baby is a Boy on birth one is 0.5 and probability on the second birth is also 0.5. The probability of being a Boy does not change from birth to birth.
-   Probability Mass Function
    
    gives the probability of the possible values of a discrete random variable

![Screenshot 2021-10-08 121756.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/62f3a343-8972-427d-8b3a-58a2e5280080/Screenshot_2021-10-08_121756.png)

-   [[Expected Value]] E(x)
    -   The population mean
    -   Average if there are infinite trials. Probability in terms of frequency that each value shows up

5-5

-   Sample means are different from E(x) since the sample mean can vary depending on the outcome of the trials.
    
-   E(x) of a 6 sided die is $\frac{1}{6}1+\frac{1}{6}2+\frac{1}{6}3+\frac{1}{6}4+\frac{1}{6}5+\frac{1}{6}6 = 3.5$
    
-   The Law of Large Numbers
    
    We also expect that as sample size increases, the sample mean will approach expected value of X
    

5-6

![Screenshot 2021-10-08 122026.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/062a04d7-cd77-45e9-84e8-5262a2e9c272/Screenshot_2021-10-08_122026.png)

-   In the variance formula, dividing by (n-1) returns a slightly larger value to get closer to the population mean. It is known as an unbiased estimate

![Screenshot 2021-10-08 122253.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/83f40c2c-373a-4d4f-a7a7-1fecea15dadd/Screenshot_2021-10-08_122253.png)

5-8

![Screenshot 2021-10-08 122440.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0fe3b702-04eb-4da9-aff9-aacdee50b4e6/Screenshot_2021-10-08_122440.png)

-   The E(X) of a sample mean is the same as the E(X) of a population mean

![Screenshot 2021-10-08 122557.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/797cb288-5809-4feb-93e2-23a14bcd5c12/Screenshot_2021-10-08_122557.png)

![Screenshot 2021-10-08 122701.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/af3ccbac-0acb-492e-943d-23596aa0704b/Screenshot_2021-10-08_122701.png)