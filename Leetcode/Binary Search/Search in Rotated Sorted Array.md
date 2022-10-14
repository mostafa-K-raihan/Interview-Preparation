### Problem Statement
There is an integer array nums sorted in ascending order (with distinct values).

Prior to being passed to your function, nums is possibly rotated at an unknown pivot index k (1 <= k < nums.length) such that the resulting array is `[nums[k]`, `nums[k+1]`, ..., `nums[n-1]`, `nums[0]`, `nums[1]`, ..., `nums[k-1]]` (0-indexed). For example, `[0,1,2,4,5,6,7]` might be rotated at pivot index 3 and become `[4,5,6,7,0,1,2]`.

Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

You must write an algorithm with `O(log n)` runtime complexity.

### Example 1:
```
Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4
```

### Example 2
```
Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1
```

### Example 3
```
Input: nums = [1], target = 0
Output: -1
```

### Constraints
```
- 1 <= nums.length <= 5000
- -10^4 <= nums[i] <= 10^4
- All values of nums are unique.
- nums is an ascending array that is possibly rotated.
- -10^4 <= target <= 10^4
```
### Code

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums) - 1
        
        # there will be two sorted portion before and after pivot
        # in each iteration, figure out which sorted portion u are in
        # if nums[l] <= nums[m], u are in left sorted portion
        # else u r in right
        
        # once u figured that out
        # u need to check where is the target with respect to your sorted portion
        # is it inside of the sorted portion? or is it outside
        # checking inside is easy need one condition
        # checking outside require two condition
        # 1. l.....m..T....r or 2. l....T...m.....r
        # if u r in left sorted portion for outside case 1. t > m or t < l 
        # if u r in right sorted portion for outside case 2. t < m or t > r
        
        # pain in the ass cases ^^ 
        
        while (l <= r):
            m = (l + r) // 2
            if target == nums[m]:
                return m
           
            # which sorted portion are we in??
            # if we are in left sorted portion, then nums[l] <= nums[m]
            if nums[l] <= nums[m]:
                # check the boundary condition first
                # target is > nums[m] or target < nums[l]
                # < 1 ..... m >...Target..
                if target > nums[m]:
                    l = m + 1
                # at this point it is evident that, target is no longer greater than nums[m]
                # so it is smaller than nums[m] i.e. target <= nums[m]
                # but is it also smaller than the smallest value in this portion?
                elif target < nums[l]:
                    # if so then more smaller value are in the right, because of rotation
                    l = m + 1
                
                # at this point it seems, target is greater than the smallest value of left
                # but less than nums[m]
                else:
                    r = m - 1
                    
            # at this point we are sure that we are no longer in left sorted portion
            # we are in right sorted portion
            else:
                # easy case if target < nums[m]
                if target < nums[m]:
                    r = m - 1
                # even greater than greatest value of right
                elif target > nums[r]:
                    r = m - 1
                # in between mid and r
                else:
                    l = m + 1
        return -
```