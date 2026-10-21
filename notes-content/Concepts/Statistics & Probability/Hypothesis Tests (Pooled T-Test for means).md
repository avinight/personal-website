---
tags:
  - statistics
---
[[Hypothesis Tests (Pooled T-Test for proportions)]]
Two Independent Samples
- One mean, sample size n, mean $\bar{X}$, variance $s^2$
	$$\frac{\bar{X}-\mu}{\sqrt{\frac{s^2}{n}}} \approx t_{n-1} $$
- Two independent means (not matched)
	- Samples: sizes $n_1, n_2$, means $\bar{X}_1, \bar{X}_2$, vars. $s_1^2, s_2^2$
	- Fact:
		$$\frac{(\bar{X}_1 - \bar{X}_2) - (\mu_1 - \mu_2)}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}} \approx t_{df}$$
		where [[Welch-Satterthwaite Approximation]] is used to measure $df$

We cannot "pool" the samples (like for proportions), unless we also assume that $$\sigma_1^2 = \sigma_2^2$$

P-value
$$=P(|\bar{X}_1 - \bar{X}_2| \geq \bar{X}_1 - \bar{X}_2)$$ under $H_0$
$$P\left(\frac{|(\bar{X}_1 - \bar{X}_2) - (\mu_1 - \mu_2)|}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}\geq \frac{\bar{X}_1 - \bar{X}_2}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}\right)$$
$$ \approx P\left(|t_{df} \geq \frac{\bar{X}_1 - \bar{X}_2}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}\right)$$

"Pooled" T-Test for means (assuming equal variances)
- Pooled variance
	$$ s^2 = \frac{(n_1-1)s_1^2 + (n_2-1)s_2^2)}{n_1-1)+ (n_2-1)}$$
- Pooled degrees of freedom
	$$ df = (n_1-1) + (n_2-1) = n_1 + n_2 - 2 $$

[[Confidence Intervals]]:
$$\bar{X}_1 - \bar{X}_2 \pm T_{\frac{\alpha}{2},df} \sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}$$

Instead of $100(1 - \alpha)$% confidence level, $\alpha/2$ is the tail probability for one tailed test

