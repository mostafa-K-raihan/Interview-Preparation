## Course Schedule

### Problem Statement
There are a total of `numCourses` courses you have to take, 
labeled from 0 to `numCourses - 1`. 
You are given an array prerequisites where `prerequisites[i] = [ai, bi]` 
indicates that you must take course `bi` first if you want to take course `ai`.

For example, the pair `[0, 1]`, indicates that to take course `0` you have to first take course `1`.
Return true if you can finish all courses. Otherwise, return false.

```
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
```

### Code
```python
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

