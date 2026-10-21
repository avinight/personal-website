---
tags:
  - statistics
---
[[Hypothesis Tests (Pooled T-Test for means)]]
Two Independent Samples
- One proportion, Sample size n, Success fraction p-hat
		$$ \hat{p} - p \approx \text{Normal}\left(0, \frac{p(1-p)}{n}\right) $$

- Two Independent Proportions
	$\hat{p}_1 - \hat{p}_2$ has mean $p_1 - p_2$
	
	And 
	$$\text{Var}(\hat{p}_1 - \hat{p}_2) = \text{Var}(\hat{p}_1) + (-1)^2 \text{Var}(\hat{p}_2)$$
	$$= \left(\frac{p_1(1-p_1)}{n_1}\right) + \left(\frac{p_2(1-p_2)}{n_2}\right)$$
	
	By CLT: $\hat{p}_1 - \hat{p}_2 \approx \text{Normal}\left(p_1 - p_2, \frac{p_1(1-p_1)}{n_1} + \frac{p_2(1-p_2)}{n_2}\right)$
	
	So, $\frac{(\hat{p}_1 - \hat{p}_2)-(p_1-p_2)}{\sqrt{\frac{p_1(1-p_1)}{n_1} + \frac{p_2(1-p_2)}{n_2}}} \approx \text{Normal}(0,1)$
Under $H_0$, we assume $p_1=p_2$, so we approximate both $p_1$ and $p_2$ by a
"pooled" estimate:
	$$\hat{p} \equiv \frac{n_1\hat{p}_1 + n_2\hat{p}_2}{n_1+n_2}$$
Now, $$\frac{(\hat{p}_1 - \hat{p}_2)-(p_1-p_2)}{\sqrt{\hat{p}(1-\hat{p})\left(\frac{1}{n_1}+\frac{1}{n_2}\right)}} \approx \text{Normal}(0,1)$$

Then a p-value: (absolute value bigger than absolute value because it is two tailed and measuring observed difference)
$$ = P\left(\frac{|(\hat{p}_1 - \hat{p}_2)-(p_1-p_2)|}{\sqrt{\hat{p}(1-\hat{p})\left(\frac{1}{n_1}+\frac{1}{n_2}\right)}} \geq \frac{|\hat{p}_1 - \hat{p}_2|}{\sqrt{\hat{p}(1-\hat{p})\left(\frac{1}{n_1}+\frac{1}{n_2}\right)}}\right) $$

$$ \approx P\left(|\text{Normal}(0,1)| \geq \frac{|\hat{p}_1 - \hat{p}_2|}{\sqrt{\hat{p}(1-\hat{p})\left(\frac{1}{n_1}+\frac{1}{n_2}\right)}}\right) $$

Random studies describe causal relationships

[[Confidence Intervals]]
$$ \hat{p}_1 - \hat{p}_2 \pm Z^*\sqrt{\frac{p_1(1-p_1)}{n_1} + \frac{p_2(1-p_2)}{n_2}}$$