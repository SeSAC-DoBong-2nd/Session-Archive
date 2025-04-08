//
//  Search.swift
//  05_Search_Sort
//
//  Created by Bran on 4/8/25.
//

import Foundation

///  선형탐색 - 정렬 유무와 상관없이 적용 가능
///  - Complexity: O(N)
///  - Returns: target의 인덱스
func sequentialSearch<T: Comparable>(_ arr: [T],
                                     _ target: T) -> Int {
  for i in 0..<arr.count {
    if arr[i] == target { return i }
  }
  return -1
}



/// 이분탐색 - 정렬된 경우에만 사용 가능
/// - Parameters:
///   - arr: 정렬된 배열
/// - Complexity: O(logN)
/// - Returns: target의 인덱스
func binarySearch<T: Comparable>(_ arr: [T], _ target: T) -> Int {
  var left = 0
  var right = arr.count - 1

  while left <= right {
    let mid = left + (right - left) / 2

    if arr[mid] == target {
      return mid
    } else if arr[mid] < target {
      left = mid + 1
    } else {
      right = mid - 1
    }
  }

  return -1
}
