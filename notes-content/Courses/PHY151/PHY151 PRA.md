---
tags:
  - course/phy151
  - physics
---
# PHY151 PRA
#PHY151

Histogram:

```python
import numpy as np
from matplotlib import pyplot as plt

pod4 = np.array([12,6,7,5,2,3,7,12,2,8,11,4,5,10,7,9,7,6,10,8,7,7,9,10,5,9,8,9,2,5,9,9,6,9,7])

plt.title('Two Dice rolled 36 times')
plt.xlabel('Sum of Two Dice')
plt.ylabel('# of occurence')
plt.hist(pod4, bins=11, range=(2,12))
plt.show()
```