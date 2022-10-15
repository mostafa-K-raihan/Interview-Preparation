### Problem Statement

You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.

Return the length of the longest substring containing the same letter you can get after performing the above operations.

### Example 1

```
Input: s = "ABAB", k = 2
Output: 4
Explanation: Replace the two 'A's with two 'B's or vice versa.
```

### Example 2

```
Input: s = "AABABBA", k = 1
Output: 4
Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
The substring "BBBB" has the longest repeating letters, which is 4.
```

### Constraints

```
- 1 <= s.length <= 10^5
- s consists of only uppercase English letters.
- 0 <= k <= s.length
```

### Code

```python
class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        # so u r allowed at most k operations
        # any more than that its not valid
        # and its obvious that we need to replace char that are not most frequent
        # cuz we need to make the NOT most frequent char to frequent char
        # so that we can maximize the frequent char even more
        # we can generate n^2 substrings and then check length of string - max freq <= K
        # if we can then we can definitely operate on that substring and do <= K ops
        # to turn into repeatable char of string ( r - l + 1) will be the ans

        # but we can improve on runtime from O(n**2) to O (n)
        # by employing a sliding window technique

        # we will initialize a left pointer, and right pointer
        # initially both will point to start of the string
        # right will move to the right and we will store the freq of each char
        # at every position, we will calculate if the window size - max freq of char <= K
        # then we will update the result
        # otherwise, we will update the left pointer to move forward
        # and !!important!! decrement the previous left pointer's char value
        count = defaultdict(int)

        res = 0
        l = 0
        for r in range(len(s)):
            count[s[r]] += 1

            if (r - l + 1) - max(count.values()) > k:
                count[s[l]] -= 1
                l += 1

            res = max(res, r - l + 1)

        return res
```
