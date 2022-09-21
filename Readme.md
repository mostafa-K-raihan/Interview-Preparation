### Problem Statement

Given an `m x n` matrix board containing `'X'` and `'O'`, capture all
regions that are 4-directionally surrounded by `'X'`.

A region is captured by flipping all `'O's` into `'X's` in that
surrounded region.

![surrounded by
region](/Leetcode/images/surrounded_by_region.png?raw=true, "Surrounded by Region")

    Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
    Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
    Explanation: Notice that an 'O' should not be flipped if:
    - It is on the border, or
    - It is adjacent to an 'O' that should not be flipped.
    The bottom 'O' is on the border, so it is not flipped.
    The other three 'O' form a surrounded region, so they are flipped.
    Example 2:

    Input: board = [["X"]]
    Output: [["X"]]
     

    Constraints:

    m == board.length
    n == board[i].length
    1 <= m, n <= 200
    board[i][j] is 'X' or 'O'.

### Code

```python

class Solution:
    def solve(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        
        rows, cols = len(board), len(board[0])
        
        def is_in_border(r, c):
            return r in [0, rows - 1] or c in [0, cols - 1]
        
        
        # capture unsurrounded region (mark O => C)
        
        def capture(r, c):
            if (r not in range(rows) or
                c not in range(cols) or 
                board[r][c] != "O"
               ):
                return
            
            board[r][c] = "C"
            
            for dr, dc in [[1, 0], [-1, 0], [0, 1], [0, -1]]:
                capture(r + dr, c + dc)
        
        for r in range(rows):
            for c in range(cols):
                if (board[r][c] == "O" and is_in_border(r, c)):
                    capture(r, c)
        
        
        # change all occurrence of O to X, because this is 
        # the actual captured region
        
        def mark(char, to_replace):
            for r in range(rows):
                for c in range(cols):
                    if board[r][c] == char:
                        board[r][c] = to_replace
        
        mark("O", "X")
        
        # change all occurrence of "C" to "O" again
        # because this is should not have been captured
        
        mark("C", "O")
        
        return
```

### Key consideration:

-   (1/3) phases
-   instead of finding surrounded region, we are going to find O that is
    not in a surrounded region
-   so we will start from the border, cuz it is not surrounded, and look
    for an O
-   if we find one, we will DFS and look for connected O, and mark these
    O to a dummy char "C"

-   (2/3) phases
-   mark the remaining O to X, cuz these are the actual surrounded
    region, that can be flipped

-   (3/3) phases
-   mark the dummy chars to O again, because temporarily we marked as
    dummy, it should be O

We can combine these two phases in one go, with a second elif branch,
but this way it feels like more readable

Problem Statement
-----------------

Given a reference of a node in a `connected undirected` graph.

Return a `deep copy (clone)` of the graph.

Each node in the graph contains a value (int) and a list (List\[Node\])
of its neighbors.


    class Node {
        public int val;
        public List<Node> neighbors;
    }

Test case format:

For simplicity, each node's value is the same as the node's index
(1-indexed). For example, the first node with val == 1, the second node
with val == 2, and so on. The graph is represented in the test case
using an adjacency list.

An adjacency list is a collection of unordered lists used to represent a
finite graph. Each list describes the set of neighbors of a node in the
graph.

The given node will always be the first node with val = 1. You must
return the copy of the given node as a reference to the cloned graph.

    Example 1:


    Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
    Output: [[2,4],[1,3],[2,4],[1,3]]
    Explanation: There are 4 nodes in the graph.
    1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
    2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
    3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
    4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
    Example 2:


    Input: adjList = [[]]
    Output: [[]]
    Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.
    Example 3:

    Input: adjList = []
    Output: []
    Explanation: This an empty graph, it does not have any nodes.
     

    Constraints:

    The number of nodes in the graph is in the range [0, 100].
    1 <= Node.val <= 100
    Node.val is unique for each node.
    There are no repeated edges and no self-loops in the graph.
    The Graph is connected and all nodes can be visited starting from the given node.

Code
----

``` {.python}
class Solution:
    def cloneGraph(self, node: 'Node') -> 'Node':
        if not node:
            return None
        d = {}
        
        def dfs(node):
            if node in d:
                return d[node]
        
            copy = Node(node.val)
            d[node] = copy
            
            for n in node.neighbors:
                copy.neighbors.append(dfs(n))
            return copy
```

Problem Statement
-----------------

You are given an m x n binary matrix grid. An island is a group of 1's
(representing land) connected 4-directionally (horizontal or vertical.)
You may assume all four edges of the grid are surrounded by water.

The area of an island is the number of cells with a value 1 in the
island.

Return the maximum area of an island in grid. If there is no island,
return 0.

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

Code
----

``` {.python}

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

We can reuse grid instead of visit hashset. just set `grid[r][c] = 0`
whenever, we visit a node

### Problem Statement

There is an `m x n` rectangular island that borders both the Pacific
Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left
and top edges, and the Atlantic Ocean touches the island's right and
bottom edges.

The island is partitioned into a grid of square cells. You are given an
m x n integer matrix heights where heights\[r\]\[c\] represents the
height above sea level of the cell at coordinate (r, c).

The island receives a lot of rain, and the rain water can flow to
neighboring cells directly north, south, east, and west if the
neighboring cell's height is less than or equal to the current cell's
height. Water can flow from any cell adjacent to an ocean into the
ocean.

Return a 2D list of grid coordinates result where result\[i\] = \[ri,
ci\] denotes that rain water can flow from cell (ri, ci) to both the
Pacific and Atlantic oceans.

Example
-------

![pacific\_atlantic\_water\_flow](./Leetcode/images/pacific_atlantic_water_flow?raw=true "Pacific Atlantic Water Flow")

### Code

``` {.python}
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

Problem Statement
-----------------

Given an `m x n` 2D binary grid grid which represents a map of '1's
(land) and '0's (water), return the number of islands.

An island is surrounded by water and is formed by connecting adjacent
lands horizontally or vertically. You may assume all four edges of the
grid are all surrounded by water.

### Example 1:


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

### Code

``` {.python}
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

-   BFS
-   Python Set, Collections, Deque
-   How can we change the implementation to DFS (using pop instead of
    popleft of deque)
-   Runtime of BFS/DFS

Double Ended Queue (deque)
--------------------------

prefered over list when we needed quicker append and pop operations.
both can be done in `O(1)` where in list it could be `O(n)`

``` {.python}
from collections import deque

q = deque(['name', 'age', 'dob'])
print(q)
```

### Output

``` {.python}

deque(['name', 'age', 'dob'])
```

### Operations

-   append()
-   appendleft(): notice the case for left
-   pop()
-   popleft(): notice the case for left
-   insert(index, value)
-   remove(value): remove the first occurrence only
-   index(value, \[start, \[stop\]\]): return first occurrence of value
    in \[start, stop) raises ValueError if not found
-   reverse(): reverses in place
-   rotate(value): rotate value amount to the right, default 1, negative
    value rotates to the left
-   extend(iterable): appends multiple value to the end
-   extendleft(iterable): appends multiple value to beginning and order
    is reversed
-   count(value)

``` {.python}

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
