### Problem Statement
Given an `m x n` matrix board containing `'X'` and `'O'`, capture all regions that are 4-directionally surrounded by `'X'`.

A region is captured by flipping all `'O's` into `'X's` in that surrounded region.

![surrounded by region](../images/surrounded_by_region.png?raw=true, "Surrounded by Region")

```
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
```
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
- (1/3) phases
- instead of finding surrounded region, we are going to find O that is not in a surrounded region
- so we will start from the border, cuz it is not surrounded, and look for an O
- if we find one, we will DFS and look for connected O, and mark these O to a dummy char "C"

- (2/3) phases
- mark the remaining O to X, cuz these are the actual surrounded region, that can be flipped

- (3/3) phases
- mark the dummy chars to O again, because temporarily we marked as dummy, it should be O

We can combine these two phases in one go, with a second elif branch, but this way it feels like
more readable
