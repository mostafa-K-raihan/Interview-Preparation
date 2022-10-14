### Problem Statement

Given a `m x n` grid filled with non-negative numbers, find a path from top left to bottom right, which minimizes the sum of all numbers along its path.

Note: You can only move either down or right at any point in time.

### Example 1

```
Input: grid = [[1,3,1],[1,5,1],[4,2,1]]
Output: 7
Explanation: Because the path 1 → 3 → 1 → 1 → 1 minimizes the sum.
```

### Example 2

```
Input: grid = [[1,2,3],[4,5,6]]
Output: 12
```

### Constraints

```
m == grid.length
n == grid[i].length
1 <= m, n <= 200
0 <= grid[i][j] <= 100
```

### Code

```python
class Solution:
    def minPathSum(self, grid: List[List[int]]) -> int:

        # our dp will contain min cost from each cell
        # dp[i][j] = min path sum from this cell to last cell
        row, col = len(grid), len(grid[0])
        # init dp array
        dp = [[0 for _ in range(col+1)] for __ in range(row+1)]

        # from the last cell to last cell
        # or think if the matrix is just 1 X 1
        dp[row-1][col-1] = grid[row-1][col-1]

        # base cases
        # imagine the matrix is just M X 1
        # we can only move downward
        # so the dp[i][j] will be current cell value + dp value of the down cell
        for i in range(row-2, -1, -1):
            dp[i][col-1] = grid[i][col-1] + dp[i+1][col-1]

        # base cases
        # imagine the matrix is just 1 X N
        # we can only move right
        # so the dp[i][j] will be the current cell value + dp value of the right cell
        for i in range(col-2, -1, -1):
            dp[row-1][i] = grid[row-1][i] + dp[row-1][i+1]

        # for every other intermediate cell
        # calculate dp[i][j] = current cell value + min (dp down cell, dp right cell)
        for i in range(row-2, -1, -1):
            for j in range(col-2, -1, -1):
                dp[i][j] = grid[i][j] + min(dp[i+1][j], dp[i][j+1])

        # return the initial cell
        # basically min path sum from the start to finish
        return dp[0][0]
```
