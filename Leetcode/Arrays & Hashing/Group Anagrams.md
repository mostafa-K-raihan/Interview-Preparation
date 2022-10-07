## Problem Statement

Given an array of strings strs, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

## Example 1

```
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
```

## Example 2

```
Input: strs = [""]
Output: [[""]]
```

## Example 3

```
Input: strs = ["a"]
Output: [["a"]]
```

## Constraint

```
- 1 <= strs.length <= 10^4
- 0 <= strs[i].length <= 100
- strs[i] consists of lowercase English letters.
```

### Code

```python
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
