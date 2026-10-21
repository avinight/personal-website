
What is a Z-Score?
- A z-score is an adjustment of a data value to get its position in a data set.

(e.g.) A z-score of -1.0 tells you that the corresponding data value is one standard deviation below the mean.

(e.g.) A z-score of +2.5 tells you that the corresponding data value is 2.5 standard deviations above the mean.

Z-Score for means:
$$ Z = \frac{\bar{x} - \mu}{\sigma}$$
Z-Score for proportions:
$$ Z = \frac{\hat{p} - p}{\sigma} $$

Something to think about: Using the empirical rule, how often will a student get a grade more than 3 standard deviations above the mean, like the student in class 2 did.

```r
(x - mean(x))/sd(x)
```