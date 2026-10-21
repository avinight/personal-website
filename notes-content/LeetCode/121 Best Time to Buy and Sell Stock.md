Tags: #problem

---

7 1 5 3 6 4

Dynamic Programming
- Bellman Eq

size 1 = 0 profit
size 2 = 0 profit or > 0 profit if $A[i] < A[j]$ for i < j

OPT(i) denotes the maximum profit achievable for list of length i

OPT(i) = max(OPT(i-1), A[i] - min(A[:i-1]))
	   = 0 if i = 1

Bottom-Up
```Python
def maxProfit(self, prices: List[int]) -> int:
        profits = [0] * (len(prices))
        for i in range(1, len(prices)):
            profits[i] = max(profits[i-1], prices[i] - min(prices[:i]))
        return profits[len(prices) - 1]
```

Top-Down (fix)
```Python
def maxProfit(self, prices: List[int], memo = {}) -> int:
    n = len(prices)
    if not prices or (n == 1):
        return 0
    memo[n] = max(self.maxProfit(prices[:n-1], memo), prices[n-1] - min(prices[:n]))
    return memo[n]
```

For-Loop
```Python
# O(n)
def maxProfit(self, prices: List[int]) -> int:
	buy_price = prices[0]
	profit = 0

	for p in prices[1:]:
		if buy_price > p:
			buy_price = p
		profit = max(profit, p - buy_price)
	
	return profit
```
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---