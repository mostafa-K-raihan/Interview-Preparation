### Problem Statement
There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.

Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.

The test cases are generated so that the answer will be less than or equal to 2 * 10^9

### Example 1
```
Input: m = 3, n = 7
Output: 28
```

### Example 2
```
Input: m = 3, n = 2
Output: 3
Explanation: From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
1. Right -> Down -> Down
2. Down -> Down -> Right
3. Down -> Right -> Down
```

### Constraints
```
- 1 <= m, n <= 100
```
### Code

```python

class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        # we will have a 2D array containing info, like each cell
        # should contain how many unique path is there from that cell
        
        # base case
        # lets assume the robot is at the bottom right corner, then the ans would be 0
        # if it is just above that cell, then robot needs to go down, 1, so ans would be 1
        # if it is just left of that cell, same as above
        # in fact all the cells in the last row/last column would result 1
        # we cant move up/left
        # from the last column we can only go down
        # from the last row we can only go right
        
        # gotcha case when init the dp array
        # inner array is for column, outer array is for row
        dp = [[0 for _ in range(n)] for __ in range(m)]
        
        # base case
        dp[m-1][n-1] = 0
        
        for i in range(m):
            dp[i][n-1] = 1
        for i in range(n):
            dp[m-1][i] = 1
            
        # iteratively build the dp array from the finish marked cell
        # we don't need to go to the last column/row
        # they are covered by the base cases
        for i in range(m-2, -1, -1):
            for j in range(n-2, -1, -1):
                # each cell would depend on two other cell
                # how many unique path there are from the cell that is right of it
                # plus how many unique path there are from the cell that is below it
                dp[i][j] = dp[i+1][j] + dp[i][j+1]
        
        # dp[0][0] holds the ans
        return dp[0][0]
```
