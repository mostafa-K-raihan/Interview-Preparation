## Problem Description

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Example 1**

```
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807.
```

**Example 2**

```
Input: l1 = [0], l2 = [0]
Output: [0]
```

**Example 3**

```
Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
Output: [8,9,9,9,0,0,0,1]
```

**Constraints:**

The number of nodes in each linked list is in the range [1, 100].
0 <= Node.val <= 9
It is guaranteed that the list represents a number that does not have leading zeros.

### Code

```python
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

- one list can be way smaller than other list
- keep track of carry
