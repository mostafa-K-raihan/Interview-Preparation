### Problem Statement

Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. This matrix has the following properties:

- Integers in each row are sorted from left to right.
- The first integer of each row is greater than the last integer of the previous row.

### Example 1

```
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true
```

### Example 2

```
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false
```

### Constraints

```
- m == matrix.length
- n == matrix[i].length
- 1 <= m, n <= 100
- -10^4 <= matrix[i][j], target <= 10^4
```

### Code

```python
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        # we will first binary search among the rows using the 2nd prop log row
        # then once we find a row, that can have the target
        # we will bin search along that row using 1st prop: log column
        # gotcha in binary search, always consider 3 case, less than, greater than, and equal
        # in while always check l <= r
        # in mid calculation check constraint if it can lead to overflow, in python its fine,
        # but in other lang it might cause error

        # right pointer should be len - 1

        bottom, top = 0, len(matrix) - 1
        while bottom <= top:
            mid = (bottom + top) // 2

            if target > matrix[mid][-1]:
                bottom = mid + 1
            elif target < matrix[mid][0]:
                top = mid - 1
            else:
                # we got the row, target could be in this row
                break

        # we dont find any row that can have the target
        if bottom > top:
            return False

        # we found a row!
        mid = (bottom + top) // 2

        l, r = 0, len(matrix[0]) - 1

        while l <= r:
            m = (l + r) // 2

            if target > matrix[mid][m]:
                l = m + 1
            elif target < matrix[mid][m]:
                r = m - 1
            else:
                return True

        # did not find the target in that row
        return False
```
