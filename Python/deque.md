## Double Ended Queue (deque)

prefered over list when we needed quicker append and pop operations.
both can be done in `O(1)` where in list it could be `O(n)`

```python
from collections import deque

q = deque(['name', 'age', 'dob'])
print(q)

```

### Output
```python

deque(['name', 'age', 'dob'])
```

### Operations

- append()
- appendleft(): notice the case for left
- pop()
- popleft(): notice the case for left
- insert(index, value)
- remove(value): remove the first occurrence only
- index(value, [start, [stop]]): return first occurrence of value in [start, stop)
  raises ValueError if not found
- reverse(): reverses in place
- rotate(value): rotate value amount to the right, default 1, negative value rotates to the left
- extend(iterable): appends multiple value to the end
- extendleft(iterable): appends multiple value to beginning and order is reversed
- count(value)
```python

q = deque([1, 2, 3])
q.append(4)           # [1, 2, 3, 4]
q.appendleft(0)       # [0, 1, 2, 3, 4]
q.pop()               # [0, 1, 2, 3]
q.popleft()           # [1, 2, 3]
q.insert(1, -1)       # [1, -1, 2, 3]
q.append(-1)          # [1, -1, 2, 3, -1]
q.remove(-1)          # [1, 2, 3, -1]
q.index(-1)           # 3
q.reverse()           # [-1, 3, 2, 1]
q.rotate()            # [1, -1, 3, 2]
q.extend([7, 8])      # [1, -1, 3, 2, 7, 8]
q.extendleft([5, 6])  # [6, 5, 1, -1, 3, 2, 7, 8]
q.count(99)           # 0
```
