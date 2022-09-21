### Problem Statement
There is an `m x n` rectangular island that borders both the Pacific Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left and top edges, and the Atlantic Ocean touches the island's right and bottom edges.

The island is partitioned into a grid of square cells. You are given an m x n integer matrix heights where heights[r][c] represents the height above sea level of the cell at coordinate (r, c).

The island receives a lot of rain, and the rain water can flow to neighboring cells directly north, south, east, and west if the neighboring cell's height is less than or equal to the current cell's height. Water can flow from any cell adjacent to an ocean into the ocean.

Return a 2D list of grid coordinates result where result[i] = [ri, ci] denotes that rain water can flow from cell (ri, ci) to both the Pacific and Atlantic oceans.

## Example
![pacific_atlantic_water_flow](../images/pacific_atlantic_water_flow?raw=true "Pacific Atlantic Water Flow")

### Code
```python
class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        
        rows, cols = len(heights), len(heights[0])
        
        pacific, atlantic = set(), set()
        
        def dfs(r, c, visit, prev_height):
            
            if (r not in range(rows) or
                c not in range(cols) or
                heights[r][c] < prev_height or
                (r, c) in visit
               ):
                return
            
            visit.add((r, c))
            for dr, dc in [[1, 0], [-1, 0], [0, 1], [0, -1]]:
                dfs(r+dr, c+dc, visit, heights[r][c])
        
        
        result = []
        for r in range(rows):
            dfs(r, 0, pacific, heights[r][0])
            dfs(r, cols - 1, atlantic, heights[r][cols - 1])
        
        for c in range(cols):
            dfs(0, c, pacific, heights[0][c])
            dfs(rows - 1, c, atlantic, heights[rows-1][c])
        
        
        for r in range(rows):
            for c in range(cols):
                if ((r, c) in pacific and (r, c) in atlantic):
                    result.append((r, c))
        
        return result
```
