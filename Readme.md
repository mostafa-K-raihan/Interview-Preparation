### Problem Statement

There is a robot on an m x n grid. The robot is initially located at the
top-left corner (i.e., grid\[0\]\[0\]). The robot tries to move to the
bottom-right corner (i.e., grid\[m - 1\]\[n - 1\]). The robot can only
move either down or right at any point in time.

Given the two integers m and n, return the number of possible unique
paths that the robot can take to reach the bottom-right corner.

The test cases are generated so that the answer will be less than or
equal to 2 \* 10\^9

### Example 1

    Input: m = 3, n = 7
    Output: 28

### Example 2

    Input: m = 3, n = 2
    Output: 3
    Explanation: From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
    1. Right -> Down -> Down
    2. Down -> Down -> Right
    3. Down -> Right -> Down

### Constraints

    - 1 <= m, n <= 100

### Code

``` python

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
    - It is on the border,
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

``` python

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

### Problem Statement

![walls and
gates](/Leetcode/images/walls_and_gates.png?raw=true, "Walls and gates")

### Code

``` python

class Solution:
    """
    @param rooms: m x n 2D grid
    @return: nothing
    """

    def walls_and_gates(self, rooms: List[List[int]]):
        ROWS, COLS = len(rooms), len(rooms[0])
        visit = set()
        q = deque()

        def addRooms(r, c):
            if (
                min(r, c) < 0
                or r == ROWS
                or c == COLS
                or (r, c) in visit
                or rooms[r][c] == -1
            ):
                return
            visit.add((r, c))
            q.append([r, c])

        for r in range(ROWS):
            for c in range(COLS):
                if rooms[r][c] == 0:
                    q.append([r, c])
                    visit.add((r, c))

        dist = 0
        while q:
            for i in range(len(q)):
                r, c = q.popleft()
                rooms[r][c] = dist
                addRooms(r + 1, c)
                addRooms(r - 1, c)
                addRooms(r, c + 1)
                addRooms(r, c - 1)
            dist += 1
```

Course Schedule
---------------

### Problem Statement

There are a total of `numCourses` courses you have to take, labeled from
0 to `numCourses - 1`. You are given an array prerequisites where
`prerequisites[i] = [ai, bi]` indicates that you must take course `bi`
first if you want to take course `ai`.

For example, the pair `[0, 1]`, indicates that to take course `0` you
have to first take course `1`. Return true if you can finish all
courses. Otherwise, return false.

    Example 1:

    Input: numCourses = 2, prerequisites = [[1,0]]
    Output: true
    Explanation: There are a total of 2 courses to take. 
    To take course 1 you should have finished course 0. So it is possible.
    Example 2:

    Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
    Output: false
    Explanation: There are a total of 2 courses to take. 
    To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
     

    Constraints:

    - 1 <= numCourses <= 2000
    - 0 <= prerequisites.length <= 5000
    - prerequisites[i].length == 2
    - 0 <= ai, bi < numCourses
    - All the pairs prerequisites[i] are unique.

### Code

``` python
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        # it will be a directed graph
        # so need an adj list
        pre_requisite = { i: [] for i in range(numCourses) }
        
        # to detect a cycle
        visited = set()
        
        # create an adjacency list
        for crs, pre in prerequisites:
            pre_requisite[crs].append(pre)
            
        def dfs(crs):
            if crs in visited:
                return False
            
            if pre_requisite[crs] == []:
                return True
            
            visited.add(crs)
                
            for pre in pre_requisite[crs]:
                if not dfs(pre):
                    return False
            
            # we can successfully complete the course
            # and its pre req
            visited.remove(crs)
            pre_requisite[crs] = []
            return True    
        
        for i in range(numCourses):
            if not dfs(i):
                return False
        
        return True
```

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

``` python
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

### Problem statement

You are given an `m x n` grid where each cell can have one of three
values:

0 representing an empty cell, 1 representing a fresh orange, or 2
representing a rotten orange. Every minute, any fresh orange that is
4-directionally adjacent to a rotten orange becomes rotten.

Return the minimum number of minutes that must elapse until no cell has
a fresh orange. If this is impossible, return -1.

![Rotting
Oranges](/Leetcode/images/rotting_oranges.png?raw=true, "Rotting oranges")

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

### Code

``` python

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

``` python

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

![pacific\_atlantic\_water\_flow](/Leetcode/images/pacific_atlantic_water_flow.png?raw=true "Pacific Atlantic Water Flow")

### Code

``` python
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

``` python
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

Problem Statement
-----------------

Given a string s, find the length of the longest substring without
repeating characters.

Example 1
---------

    Input: s = "abcabcbb"
    Output: 3
    Explanation: The answer is "abc", with the length of 3.

Example 2
---------

    Input: s = "bbbbb"
    Output: 1
    Explanation: The answer is "b", with the length of 1.

Example 3
---------

    Input: s = "pwwkew"
    Output: 3
    Explanation: The answer is "wke", with the length of 3.
    Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

Constraints
-----------

    - 0 <= s.length <= 5 * 104
    - s consists of English letters, digits, symbols and spaces.

### Code

``` python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        # go thru the entire list
        # if we find a dup (use set to determine that)
        # update the left pointer + 1
        # also remove the left pointer char from the set


        chars = set()
        res, l = 0, 0

        for r in range(len(s)):
            while s[r] in chars:
                # found duplicate

                #remove from the set
                chars.remove(s[l])

                # update left pointer
                l += 1


            chars.add(s[r])
            res = max(res, r - l + 1)

        return res
```

``` {.js}
/**
 * @param {string} s
 * @return {number}
 */
var lengthOfLongestSubstring = function (s) {
  charMap = {};
  let l = 0,
    r = 0,
    res = 0;
  for (; r < s.length; r += 1) {
    const c = s[r];

    while (charMap[c]) {
      delete charMap[s[l]];
      l += 1;
    }
    charMap[c] = true;
    res = Math.max(res, r - l + 1);
  }

  return res;
};
```

### Gotchas

-   keep track of two pointers and a set
-   move the right pointer along the length
-   r - l + 1 will be the ans, our sliding window
-   if a duplicate is found by right pointer (use the set to determine
    this),
    -   shrink the window, how??
    -   keep the right pointer as it is (why?? because we will treat
        this a new char, and discard the prev one, abca, we found a in
        4th position, so we will treat this as new and discard the 1st
        one)
    -   remove the left char from the set
    -   update the left pointer

PS:

-   please remove first then update the left pointer,
-   otherwise we will fall into a classic bug

### Problem Statement

Write an efficient algorithm that searches for a value target in an m x
n integer matrix matrix. This matrix has the following properties:

-   Integers in each row are sorted from left to right.
-   The first integer of each row is greater than the last integer of
    the previous row.

### Example 1

    Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
    Output: true

### Example 2

    Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
    Output: false

### Constraints

    - m == matrix.length
    - n == matrix[i].length
    - 1 <= m, n <= 100
    - -10^4 <= matrix[i][j], target <= 10^4

### Code

``` python
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

Problem Description
-------------------

You are given two non-empty linked lists representing two non-negative
integers. The digits are stored in reverse order, and each of their
nodes contains a single digit. Add the two numbers and return the sum as
a linked list.

You may assume the two numbers do not contain any leading zero, except
the number 0 itself.

Example 1
---------

    Input: l1 = [2,4,3], l2 = [5,6,4]
    Output: [7,0,8]
    Explanation: 342 + 465 = 807.

Example 2
---------

    Input: l1 = [0], l2 = [0]
    Output: [0]

Example 3
---------

    Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    Output: [8,9,9,9,0,0,0,1]

Constraints:
------------

The number of nodes in each linked list is in the range \[1, 100\]. 0
\<= Node.val \<= 9 It is guaranteed that the list represents a number
that does not have leading zeros.

### Code

``` python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        head1 = l1
        head2 = l2

        head = ListNode()
        res = head
        carry = 0
        while (head1 and head2):
            head.val = (head1.val + head2.val + carry) % 10

            carry = ( head1.val + head2.val + carry ) // 10

            head1 = head1.next
            head2 = head2.next

            if (head1 or head2 or carry > 0):
                head.next = ListNode()
            head = head.next

        while(head1):
            head.val = (head1.val + carry) % 10
            carry = (head1.val + carry) // 10
            head1 = head1.next

            if (head1 or carry > 0):
                head.next = ListNode()
            head = head.next

        while(head2):
            head.val = (head2.val + carry) % 10
            carry = (head2.val + carry) // 10
            head2 = head2.next

            if (head2 or carry > 0):
                head.next = ListNode()
            head = head.next

        if carry > 0:
            head.val = carry

        return res
```

#### Gotchas

-   one list can be way smaller than other list
-   keep track of carry

### Problem Statement

Given the head of a linked list, rotate the list to the right by k
places.

### Example 1

    Input: head = [1,2,3,4,5], k = 2
    Output: [4,5,1,2,3]

### Example 2

    Input: head = [0,1,2], k = 4
    Output: [2,0,1]

### Constraints

    - The number of nodes in the list is in the range [0, 500].
    - -100 <= Node.val <= 100
    - 0 <= k <= 2 * 10^9

### Code

``` python

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def rotateRight(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        
        # so much edge cases in this problem
        # strategy 
        # - basically we need to break the original list into two part
        # - (1) ---- X ---- (2)
        # join the end of 2 to the begining of 1
        # first we need to know how many elements in the list
        # so do a normal iteration to figure that out
        count = 0
        
        
        # what if k is 0, means no rotation
        # or if the list is empty
        if not k or not head:
            return head
        
        tmp = head
        while tmp:
            tmp = tmp.next
            count += 1
        
        
        # then need to figure out where the X would be
        # gotchas: k can be > count
        # so we need to have k % count 
        k = k % count
        
        
        # k is from the last, and hop is from the first
        # since this is not doubly link list we cant go back
        hop = count - k
        
        
        tmp = head
        
        # go to the X point
        while tmp and hop > 1:
            hop -= 1
            tmp = tmp.next
    
        # if we end up going at the very end, again edge case -_-
        # this means the broken_part is empty, so nothing to join
        if not tmp.next:
            return head
        
        # disjoint the broken part
        broken_part = tmp.next
        tmp.next = None
        
        # keep track of the new head
        new_head = broken_part
        
        # go to the end of broken part
        while broken_part.next:
            broken_part = broken_part.next 
            
        # and finally join the previous head
        broken_part.next = head
        
        return new_head
```

Problem Statement
-----------------

Given an integer array nums and an integer k, return the k most frequent
elements. You may return the answer in any order.

### Example 1

Input: nums = \[1,1,1,2,2,3\], k = 2 Output: \[1,2\]

### Example 2

Input: nums = \[1\], k = 1 Output: \[1\]

### Constraints

-   1 \<= nums.length \<= 10\^5
-   -10\^4 \<= nums\[i\] \<= 10\^4
-   k is in the range \[1, the number of unique elements in the array\].
-   It is guaranteed that the answer is unique.

### Code

``` python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        # count the freq
        d = defaultdict(int)

        for n in nums:
            d[n] += 1


        # store in a freq array count => items
        freq = [[] for _ in range(len(nums) + 1)]

        for n, count in d.items():
            freq[count].append(n)

        # print (d, freq)
        res = []
        # iterate from the end, since we need top k
        for i in range(len(freq) - 1, 0, -1):
            for n in freq[i]:
                res.append(n)

                if len(res) == k:
                    return res
```

Problem Statement
=================

Given an array of integers nums and an integer target, return indices of
the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you
may not use the same element twice.

You can return the answer in any order.

Example 1:
----------

    Input: nums = [2,7,11,15], target = 9
    Output: [0,1]
    Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

Example 2:
----------

    Input: nums = [3,2,4], target = 6
    Output: [1,2]

Example 3:
----------

    Input: nums = [3,3], target = 6
    Output: [0,1]

Constraint:
-----------

    - 2 <= nums.length <= 10^4
    - 10^9 <= nums[i] <= 10^9
    - 10^9 <= target <= 10^9
    Only one valid answer exists.

``` python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # go thru the entire list
        # keep track of that number with index (use dict)
        # if we find target - n in the dict, we got a pair
        S = {}
        res = []
        for i, n in enumerate(nums):
            if target - n in S:
                x = S[target - n]
                res = [i, x]
            S[n] = i

        return res
```

Problem Statement
-----------------

Given an array of strings strs, group the anagrams together. You can
return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a
different word or phrase, typically using all the original letters
exactly once.

Example 1
---------

    Input: strs = ["eat","tea","tan","ate","nat","bat"]
    Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

Example 2
---------

    Input: strs = [""]
    Output: [[""]]

Example 3
---------

    Input: strs = ["a"]
    Output: [["a"]]

Constraint
----------

    - 1 <= strs.length <= 10^4
    - 0 <= strs[i].length <= 100
    - strs[i] consists of lowercase English letters.

### Code

``` python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        # for each string count which char appears how many times
        # generate a signature for string
        # for string aab its signature could be a => 2, b => 1, c....z => 0
        # match this signature with other strings signature and hence group them if matched

        res = defaultdict(list)

        for s in strs:
            # generate the signature for s
            count = [0] * 26

            for c in s:
                count[ord(c) - ord('a')] += 1

            signature = tuple(count) # in python list can't be the key of dict
            # since list is mutable
            # so we need immutable stuff like converting it to tuple

            # store the signature
            res[signature].append(s)

        return res.values() # we dont need the signature, just the strings
```

Double Ended Queue (deque)
--------------------------

prefered over list when we needed quicker append and pop operations.
both can be done in `O(1)` where in list it could be `O(n)`

``` python
from collections import deque

q = deque(['name', 'age', 'dob'])
print(q)
```

### Output

``` python

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

``` python

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
