## Problem Statement
Given an `m x n` 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

### Example 1:
```

Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
Output: 1
Example 2:

Input: grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
Output: 3
 
Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 300
grid[i][j] is '0' or '1'.

```


### Code
```python
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:
        rows, cols = len(grid), len(grid[0])
        
        visit = set()
        num_island = 0
        
        def bfs(r, c):
            visit.add((r,c))
            q = collections.deque()
            
            q.append((r, c))
            
            directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
            
            while q:    
                start_r, start_c = q.popleft()
            
                for dr, dc in directions:
                    new_dr = start_r + dr
                    new_dc = start_c + dc

                    if (new_dr in range(rows) and 
                        new_dc in range(cols) and 
                        grid[new_dr][new_dc] == '1' and 
                        (new_dr, new_dc) not in visit
                       ):
                        visit.add((new_dr, new_dc))
                        q.append((new_dr, new_dc))
            
            
                    
        
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == '1' and (r, c) not in visit:
                    bfs(r, c)
                    num_island += 1
                    
        return num_island
```

### Revisit Recommendation
- BFS
- Python Set, Collections, Deque
- How can we change the implementation to DFS (using pop instead of popleft of deque)
- Runtime of BFS/DFS
