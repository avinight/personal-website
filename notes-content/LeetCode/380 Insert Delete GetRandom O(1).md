Tags:

---

O(n) Solution
```Python
class RandomizedSet:

    def __init__(self):
        self.set = set()
        
    def insert(self, val: int) -> bool:
        if val not in self.set:
            self.set.add(val)
            return True
        return False

    def remove(self, val: int) -> bool:
        if val in self.set:
            self.set.remove(val)
            return True
        return False

    def getRandom(self) -> int:
        return random.choice(list(self.set))

# Your RandomizedSet object will be instantiated and called as such:
# obj = RandomizedSet()
# param_1 = obj.insert(val)
# param_2 = obj.remove(val)
# param_3 = obj.getRandom()
```

O(1) Solution
```Python
class RandomizedSet:

    def __init__(self):
        self.dict = {}
        self.set = []
        
    def insert(self, val: int) -> bool:
        if val in self.dict:
            return False
        
        self.dict[val] = len(self.set)
        self.set.append(val)
        return True

    def remove(self, val: int) -> bool:
        if val not in self.dict:
            return False
        
        index = self.dict[val]
        last_element = self.set[-1]

        # Replace value at index with the last element
        self.set[index] = last_element
        self.dict[last_element] = index

        # Delete last element
        self.set.pop()
        del self.dict[val]
        return True


    def getRandom(self) -> int:
        return self.set[random.randrange(len(self.set))]

# Your RandomizedSet object will be instantiated and called as such:
# obj = RandomizedSet()
# param_1 = obj.insert(val)
# param_2 = obj.remove(val)
# param_3 = obj.getRandom()
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---