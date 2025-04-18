//
//  List.swift
//  06_HashTable
//
//  Created by Bran on 4/13/25.
//

import Foundation

struct PhoneBookArray {
  var names = ["Hue", "Jack", "Bran", "Den"]
  var numbers = ["01031258728", "01068927321", "01089210809", "01032094412"]

  /// - Complexity: O(N)
  /// - Parameter number: 입력값으로 들어온 전화번호
  /// - Returns: 해당 전화번호를 사용하는 사람의 이름
  func findNumber(_ number: String) -> String? {
    for i in 0..<numbers.count {
      if numbers[i] == number {
        return names[i]
      }
    }
    return nil
  }

  /// - Complexity: O(1)
  mutating func append(_ name: String, _ number: String) {
    names.append(name)
    numbers.append(number)
  }
}

struct PhoneBookSortedArray {
  var names = ["Hue", "Jack", "Bran", "Den"].sorted()
  var numbers = ["01031258728", "01068927321", "01089210809", "01032094412"].sorted()

  /// - Complexity: O(logN)
  /// - Parameter number: 입력값으로 들어온 전화번호
  /// - Returns: 해당 전화번호를 사용하는 사람의 이름
  func findNumber(_ number: String) -> String? {
    var left = 0
    var right = numbers.count - 1

    while left <= right {
      let mid = left + (right - left) / 2

      if numbers[mid] == number {
        return names[mid]
      } else if numbers[mid] < number {
        left = mid + 1
      } else {
        right = mid - 1
      }
    }

    return nil
  }

  /// 이미 정렬되어 있는 배열에 원소를 추가하는 방법은 어떤것들이 있을까요?
  /// lower bound, upper bound 개념을 찾아보세요!
  mutating func append(name: String, _ number: String) {
    names.append(name)
    names.sort()

    numbers.append(number)
    numbers.sort()
  }
}
