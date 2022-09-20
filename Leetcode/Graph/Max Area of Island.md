## Problem Statement
You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

The area of an island is the number of cells with a value 1 in the island.

Return the maximum area of an island in grid. If there is no island, return 0.

```
Example 1:
Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
Output: 6
Explanation: The answer is not 11, because the island must be connected 4-directionally.

Example 2:

Input: grid = [[0,0,0,0,0,0,0,0]]
Output: 0
 

Constraints:
m == grid.length
n == grid[i].length
1 <= m, n <= 50
grid[i][j] is either 0 or 1.
```

## Code
```python

class Solution:
    def maxAreaOfIsland(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        
        visit = set()
        
        def bfs(r, c):
            q = collections.deque([(r, c)])
            area_of_island = 1
            
            
            directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
            
            while q:
                sr, sc = q.popleft()
                visit.add((sr, sc))
                
                
                for dr, dc in directions:
                    nr, nc = sr + dr, sc + dc
                    
                    if (
                        nr in range(rows) and
                        nc in range(cols) and
                        (nr, nc) not in visit and
                        grid[nr][nc] == 1
                    ):
                        area_of_island += 1
                        q.append((nr, nc))
                        visit.add((nr, nc))
                
            return area_of_island
        
        def dfs(r, c):
            if (not r in range(rows) or 
                not c in range(cols) or 
                grid[r][c] == 0 or 
                (r, c) in visit):
                return 0
            
            visit.add((r, c))
            
            return (1 +
                    dfs(r + 1, c) + 
                    dfs(r - 1, c) + 
                    dfs(r, c + 1) + 
                    dfs(r, c - 1)
                   )
                
        max_area = 0
        
        for r in range(rows):
            for c in range(cols):
                if (grid[r][c] == 1 and (r, c) not in visit):
                    # for bfs
                    # max_area = max(max_area, bfs(r, c)) 
        
                    # for dfs
                    max_area = max(max_area, dfs(r, c))
        
        return max_area
```

### Small memory optimization:
We can reuse grid instead of visit hashset. just set `grid[r][c] = 0` whenever, we visit a node

