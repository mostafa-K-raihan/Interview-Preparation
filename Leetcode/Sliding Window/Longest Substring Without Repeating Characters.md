## Problem Statement

Given a string s, find the length of the longest substring without repeating characters.

## Example 1

```
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
```

## Example 2

```
Input: s = "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
```

## Example 3

```
Input: s = "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
```

## Constraints

```
- 0 <= s.length <= 5 * 104
- s consists of English letters, digits, symbols and spaces.
```

### Code

```python
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

```js
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

- keep track of two pointers and a set
- move the right pointer along the length
- r - l + 1 will be the ans, our sliding window
- if a duplicate is found by right pointer (use the set to determine this),
  - shrink the window, how??
  - keep the right pointer as it is (why?? because we will treat this a new char, and discard the prev one, abca, we found a in 4th position, so we will treat this as new and discard the 1st one)
  - remove the left char from the set
  - update the left pointer

PS:

- please remove first then update the left pointer,
- otherwise we will fall into a classic bug
