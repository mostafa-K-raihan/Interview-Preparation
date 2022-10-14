### Problem Statement

You are given the head of a linked list. Delete the middle node, and return the head of the modified linked list.

The middle node of a linked list of size n is the `⌊n / 2⌋th` node from the start using 0-based indexing, where `⌊x⌋` denotes the largest integer less than or equal to `x`.

For n = 1, 2, 3, 4, and 5, the middle nodes are 0, 1, 1, 2, and 2, respectively.

### Example 1

```
Input: head = [1,3,4,7,1,2,6]
Output: [1,3,4,1,2,6]
```

### Example 2

```
Input: head = [2,1]
Output: [2]
```

### Constraints

```
- The number of nodes in the list is in the range [1, 10^5].
- 1 <= Node.val <= 10^5
```

### Code

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def deleteMiddle(self, head: Optional[ListNode]) -> Optional[ListNode]:
        # declare two pointers, one slow, and other fast
        # idea is when the fast goes to the end, the slow should be in the middle
        # we can do that if the fast moves twice as fast as the slow one
        tortoise = head # slow
        hare = head.next # fast

        # we have only one node
        # this needs to be deleted
        if not hare:
            head = None
            return head

        # keep track of the prev pointer
        prev = head

        while hare:
            # movements
            prev = tortoise
            tortoise = tortoise.next
            hare = hare.next
            if hare:
                hare = hare.next


        # delete the middle, denoted by tortoise
        prev.next = tortoise.next
        return head


```
