### Problem Statement
Given the head of a linked list, rotate the list to the right by k places.

### Example 1
```
Input: head = [1,2,3,4,5], k = 2
Output: [4,5,1,2,3]
```


### Example 2
```
Input: head = [0,1,2], k = 4
Output: [2,0,1]
```

### Constraints
```
- The number of nodes in the list is in the range [0, 500].
- -100 <= Node.val <= 100
- 0 <= k <= 2 * 10^9
```

### Code

```python

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
