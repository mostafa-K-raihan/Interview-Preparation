### Problem statement
You are given an `m x n` grid where each cell can have one of three values:

0 representing an empty cell,
1 representing a fresh orange, or
2 representing a rotten orange.
Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.

Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return -1.

![Rotting Oranges](/Leetcode/images/rotting_oranges.png?raw=true, "Rotting oranges")

```
Example 2:

Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
Output: -1
Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.
Example 3:

Input: grid = [[0,2]]
Output: 0
Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.
 

Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 10
grid[i][j] is 0, 1, or 2.
```
### Code
```python

class Solution:
    def orangesRotting(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        
        q = deque()
        
        # we will keep track of fresh orange
        # if our bfs finished up before fresh could end up zero
        # that means we have a fresh orange that is out of reach from 
        # rotten ones. so -1
        
        fresh, time = 0, 0
        
        # keeping track of fresh orange
        # and pushing rotten orange to the q
        # we will run multi source bfs
        # so that in each time unit, every rotten orange
        # can make fresh orange rotten
        
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    fresh += 1
                elif grid[r][c] == 2:
                    q.append([r, c])
               
        directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
        
        while q and fresh > 0:
            
            
            for i in range(len(q)):
                row, col = q.popleft()
                
                for dr, dc in directions:
                    nr, nc = row + dr, col + dc
                    
                    # if in bound and fresh make that rotten
                    # otherwise continue the search
                    
                    if ( nr not in range(rows) or
                        nc not in range(cols) or
                        grid[nr][nc] != 1
                    ):
                        continue
                    
                    grid[nr][nc] = 2
                    fresh -= 1
                    q.append([nr, nc])
            
            time += 1
            
        return time if fresh == 0 else -1
```
