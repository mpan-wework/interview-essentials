---
title:  "Leetcode Top Interview Questions"
date:   "2020-05-10 00:00:00+08:00"
tags: [algorithm]
pull_request_id: 6
---

> 目前共计 145 题，其中 9 题加锁（163、251、253、269、277、285、308、340、348）<br/>优先链表、树、数组、二分查找、动态规划（有先后）<br/>优先中等、简单（有先后）<br/>最好全部掌握、反复背熟

<!--
Array
  .from(document.querySelectorAll('.question-list-table tbody tr'))
  .map((el, i) => {
    const div = el.querySelector(':nth-child(2)');
    const a = el.querySelector(':nth-child(3) a');
    return `# #${div.innerText} [${a.innerText}](${a.href})`;
  })
  .join('\n')
-->

# #1 [Two Sum](https://leetcode.com/problems/two-sum)

算法：维护字典 `d`，如果 `d` 中有 `nums[i]` 则返回，没有则将 `target - nums[i]` 放入 `d` 中

# #2 [Add Two Numbers](https://leetcode.com/problems/add-two-numbers)

算法：对每一位包括进位进行加运算，遍历完一个后，无进位则直接追加，否则对每一个 `9` 置为 `0` 直到非 `9`，最后如果还有进位追加 `1`

# #3 [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters)

算法：维护窗口 `w`，如果 `s[i]` 不在 `w` 中，追加到尾部，否则记录 `w` 长度 `l`，然后清空从头到 `s[i]` 的位置并追加 `s[i]` 到尾部

# #4 [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays)
# #5 [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring)
# #7 [Reverse Integer](https://leetcode.com/problems/reverse-integer)

算法：维护两个数字 `x` 和 `s`，`x` 对 `10` 取模，加给 `s`，迭代，`x` 对 `10` 取商，`s` 不断乘以 `10`

# #8 [String to Integer (atoi)](https://leetcode.com/problems/string-to-integer-atoi)
# #10 [Regular Expression Matching](https://leetcode.com/problems/regular-expression-matching)
# #11 [Container With Most Water](https://leetcode.com/problems/container-with-most-water)
# #13 [Roman to Integer](https://leetcode.com/problems/roman-to-integer)
# #14 [Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix)

算法：找到最短的字符串 `strs[i]` 作为遍历基准，对每一位和其他字符串进行比较，直到第一个字符不一样的

# #15 [3Sum](https://leetcode.com/problems/3sum)
# #17 [Letter Combinations of a Phone Number](https://leetcode.com/problems/letter-combinations-of-a-phone-number)
# #19 [Remove Nth Node From End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list)

算法：维护两个指针 `p` 和 `q`，先将 `p` 向后移动 `n` 步，然后 `p` 和 `q` 同时移动直到 `p` 指向尾部，删除 `q` 

# #20 [Valid Parentheses](https://leetcode.com/problems/valid-parentheses)

算法：维护栈 `s`，左括号压栈，右括号出栈并确认是否匹配，最后确认 `s` 是否为空

# #21 [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists)

算法：构建新的链表 `l`，维护两个指针指向 `l1` 和 `l2`，每次选小的追加到 `l`，其中一个遍历完，直接追加另一个剩余部分到 `l`

# #22 [Generate Parentheses](https://leetcode.com/problems/generate-parentheses)

算法：

dp[0] = [''], dp[1] = ['()']

dp[i]，遍历已经已有括号总和为 `i-1` 的一对 `dp[m][x]` 和 `dp[i-1-m][y]`，把括号加给 `dp[m][x]` 

# #23 [Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists)

算法：构建新链表 `l`，维护最小堆 `h`，把每个头压入堆中，取出堆顶 `x`，把 `x.next` 压入堆中，添加 `x` 到 `l`

# #26 [Remove Duplicates from Sorted Array](https://leetcode.com/problems/remove-duplicates-from-sorted-array)

算法：每次找到第一个和当前字符不一样的，去掉中间的部分

# #28 [Implement strStr()](https://leetcode.com/problems/implement-strstr)
# #29 [Divide Two Integers](https://leetcode.com/problems/divide-two-integers)
# #33 [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array)
# #34 [Find First and Last Position of Element in Sorted Array](https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array)
# #36 [Valid Sudoku](https://leetcode.com/problems/valid-sudoku)
# #38 [Count and Say](https://leetcode.com/problems/count-and-say)
# #41 [First Missing Positive](https://leetcode.com/problems/first-missing-positive)
# #42 [Trapping Rain Water](https://leetcode.com/problems/trapping-rain-water)
# #44 [Wildcard Matching](https://leetcode.com/problems/wildcard-matching)
# #46 [Permutations](https://leetcode.com/problems/permutations)
# #48 [Rotate Image](https://leetcode.com/problems/rotate-image)
# #49 [Group Anagrams](https://leetcode.com/problems/group-anagrams)
# #50 [Pow(x, n)](https://leetcode.com/problems/powx-n)
# #53 [Maximum Subarray](https://leetcode.com/problems/maximum-subarray)
# #54 [Spiral Matrix](https://leetcode.com/problems/spiral-matrix)
# #55 [Jump Game](https://leetcode.com/problems/jump-game)
# #56 [Merge Intervals](https://leetcode.com/problems/merge-intervals)
# #62 [Unique Paths](https://leetcode.com/problems/unique-paths)
# #66 [Plus One](https://leetcode.com/problems/plus-one)
# #69 [Sqrt(x)](https://leetcode.com/problems/sqrtx)
# #70 [Climbing Stairs](https://leetcode.com/problems/climbing-stairs)
# #73 [Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes)
# #75 [Sort Colors](https://leetcode.com/problems/sort-colors)
# #76 [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring)
# #78 [Subsets](https://leetcode.com/problems/subsets)
# #79 [Word Search](https://leetcode.com/problems/word-search)
# #84 [Largest Rectangle in Histogram](https://leetcode.com/problems/largest-rectangle-in-histogram)
# #88 [Merge Sorted Array](https://leetcode.com/problems/merge-sorted-array)
# #91 [Decode Ways](https://leetcode.com/problems/decode-ways)
# #94 [Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal)
# #98 [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree)
# #101 [Symmetric Tree](https://leetcode.com/problems/symmetric-tree)
# #102 [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal)
# #103 [Binary Tree Zigzag Level Order Traversal](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal)
# #104 [Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree)
# #105 [Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal)
# #108 [Convert Sorted Array to Binary Search Tree](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree)
# #116 [Populating Next Right Pointers in Each Node](https://leetcode.com/problems/populating-next-right-pointers-in-each-node)
# #118 [Pascal's Triangle](https://leetcode.com/problems/pascals-triangle)
# #121 [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock)
# #122 [Best Time to Buy and Sell Stock II](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii)
# #124 [Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum)
# #125 [Valid Palindrome](https://leetcode.com/problems/valid-palindrome)
# #127 [Word Ladder](https://leetcode.com/problems/word-ladder)
# #128 [Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence)
# #130 [Surrounded Regions](https://leetcode.com/problems/surrounded-regions)
# #131 [Palindrome Partitioning](https://leetcode.com/problems/palindrome-partitioning)
# #134 [Gas Station](https://leetcode.com/problems/gas-station)
# #136 [Single Number](https://leetcode.com/problems/single-number)
# #138 [Copy List with Random Pointer](https://leetcode.com/problems/copy-list-with-random-pointer)
# #139 [Word Break](https://leetcode.com/problems/word-break)
# #140 [Word Break II](https://leetcode.com/problems/word-break-ii)
# #141 [Linked List Cycle](https://leetcode.com/problems/linked-list-cycle)
# #146 [LRU Cache](https://leetcode.com/problems/lru-cache)

算法：维护一个双向链表 `l` 和 字典 `d`，新数据从 `l` 尾端插入，老数据从 `l` 头端淘汰，如果 `key` 在 `d` 中，把节点移动到 `l` 尾端

# #148 [Sort List](https://leetcode.com/problems/sort-list)
# #149 [Max Points on a Line](https://leetcode.com/problems/max-points-on-a-line)
# #150 [Evaluate Reverse Polish Notation](https://leetcode.com/problems/evaluate-reverse-polish-notation)
# #152 [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray)
# #155 [Min Stack](https://leetcode.com/problems/min-stack)
# #160 [Intersection of Two Linked Lists](https://leetcode.com/problems/intersection-of-two-linked-lists)
# #162 [Find Peak Element](https://leetcode.com/problems/find-peak-element)
# #163 [Missing Ranges](https://leetcode.com/problems/missing-ranges)
# #166 [Fraction to Recurring Decimal](https://leetcode.com/problems/fraction-to-recurring-decimal)
# #169 [Majority Element](https://leetcode.com/problems/majority-element)
# #171 [Excel Sheet Column Number](https://leetcode.com/problems/excel-sheet-column-number)
# #172 [Factorial Trailing Zeroes](https://leetcode.com/problems/factorial-trailing-zeroes)
# #179 [Largest Number](https://leetcode.com/problems/largest-number)
# #189 [Rotate Array](https://leetcode.com/problems/rotate-array)
# #190 [Reverse Bits](https://leetcode.com/problems/reverse-bits)
# #191 [Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits)
# #198 [House Robber](https://leetcode.com/problems/house-robber)
# #200 [Number of Islands](https://leetcode.com/problems/number-of-islands)
# #202 [Happy Number](https://leetcode.com/problems/happy-number)
# #204 [Count Primes](https://leetcode.com/problems/count-primes)
# #206 [Reverse Linked List](https://leetcode.com/problems/reverse-linked-list)
# #207 [Course Schedule](https://leetcode.com/problems/course-schedule)
# #208 [Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree)
# #210 [Course Schedule II](https://leetcode.com/problems/course-schedule-ii)
# #212 [Word Search II](https://leetcode.com/problems/word-search-ii)
# #215 [Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)
# #217 [Contains Duplicate](https://leetcode.com/problems/contains-duplicate)
# #218 [The Skyline Problem](https://leetcode.com/problems/the-skyline-problem)
# #227 [Basic Calculator II](https://leetcode.com/problems/basic-calculator-ii)
# #230 [Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst)
# #234 [Palindrome Linked List](https://leetcode.com/problems/palindrome-linked-list)
# #236 [Lowest Common Ancestor of a Binary Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree)
# #237 [Delete Node in a Linked List](https://leetcode.com/problems/delete-node-in-a-linked-list)
# #238 [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self)
# #239 [Sliding Window Maximum](https://leetcode.com/problems/sliding-window-maximum)
# #240 [Search a 2D Matrix II](https://leetcode.com/problems/search-a-2d-matrix-ii)
# #242 [Valid Anagram](https://leetcode.com/problems/valid-anagram)
# #251 [Flatten 2D Vector](https://leetcode.com/problems/flatten-2d-vector)
# #253 [Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii)
# #268 [Missing Number](https://leetcode.com/problems/missing-number)
# #269 [Alien Dictionary](https://leetcode.com/problems/alien-dictionary)
# #277 [Find the Celebrity](https://leetcode.com/problems/find-the-celebrity)
# #279 [Perfect Squares](https://leetcode.com/problems/perfect-squares)
# #283 [Move Zeroes](https://leetcode.com/problems/move-zeroes)
# #285 [Inorder Successor in BST](https://leetcode.com/problems/inorder-successor-in-bst)
# #287 [Find the Duplicate Number](https://leetcode.com/problems/find-the-duplicate-number)
# #289 [Game of Life](https://leetcode.com/problems/game-of-life)
# #295 [Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream)
# #297 [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree)
# #300 [Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence)
# #308 [Range Sum Query 2D - Mutable](https://leetcode.com/problems/range-sum-query-2d-mutable)
# #315 [Count of Smaller Numbers After Self](https://leetcode.com/problems/count-of-smaller-numbers-after-self)
# #322 [Coin Change](https://leetcode.com/problems/coin-change)
# #324 [Wiggle Sort II](https://leetcode.com/problems/wiggle-sort-ii)
# #326 [Power of Three](https://leetcode.com/problems/power-of-three)
# #328 [Odd Even Linked List](https://leetcode.com/problems/odd-even-linked-list)
# #329 [Longest Increasing Path in a Matrix](https://leetcode.com/problems/longest-increasing-path-in-a-matrix)
# #334 [Increasing Triplet Subsequence](https://leetcode.com/problems/increasing-triplet-subsequence)
# #340 [Longest Substring with At Most K Distinct Characters](https://leetcode.com/problems/longest-substring-with-at-most-k-distinct-characters)
# #341 [Flatten Nested List Iterator](https://leetcode.com/problems/flatten-nested-list-iterator)
# #344 [Reverse String](https://leetcode.com/problems/reverse-string)
# #347 [Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements)
# #348 [Design Tic-Tac-Toe](https://leetcode.com/problems/design-tic-tac-toe)
# #350 [Intersection of Two Arrays II](https://leetcode.com/problems/intersection-of-two-arrays-ii)
# #371 [Sum of Two Integers](https://leetcode.com/problems/sum-of-two-integers)
# #378 [Kth Smallest Element in a Sorted Matrix](https://leetcode.com/problems/kth-smallest-element-in-a-sorted-matrix)
# #380 [Insert Delete GetRandom O(1)](https://leetcode.com/problems/insert-delete-getrandom-o1)
# #384 [Shuffle an Array](https://leetcode.com/problems/shuffle-an-array)
# #387 [First Unique Character in a String](https://leetcode.com/problems/first-unique-character-in-a-string)
# #395 [Longest Substring with At Least K Repeating Characters](https://leetcode.com/problems/longest-substring-with-at-least-k-repeating-characters)
# #412 [Fizz Buzz](https://leetcode.com/problems/fizz-buzz)
# #454 [4Sum II](https://leetcode.com/problems/4sum-ii)

# Linked List

# #143 [Reorder List](https://leetcode.com/problems/reorder-list/)

算法：通过快慢指针到达中间，将链表分成两个链表并把后半个链表反转，从后半个链表中不断取节点添加到前半个链表中

# Tree
