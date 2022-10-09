## Problem Statement

Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

### Example 1

Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]

### Example 2

Input: nums = [1], k = 1
Output: [1]

### Constraints

- 1 <= nums.length <= 10^5
- -10^4 <= nums[i] <= 10^4
- k is in the range [1, the number of unique elements in the array].
- It is guaranteed that the answer is unique.

### Code

```python
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
