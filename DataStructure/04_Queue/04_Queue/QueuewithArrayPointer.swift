//
//  QueuewithArrayPointer.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

struct QueueWithArrayPointer<T> {
var elements: [T] = []
  private var front = 0 // 제일 먼저 들어온 원소의 index를 가리키는 포인터

  var isEmpty: Bool {
      count < 1
  }

  var count: Int {
    elements.count - front
  }

  mutating func push(with element: T) {
      elements.append(element)
  }

  @discardableResult
  mutating func pop() -> T? {
//      if elements.count == 0 { return nil }
//      let removeElement = elements[front]
//      front += 1
//      return removeElement
      
      //defer: 해당 메서드에서 제일 마지막에 실행되는 함수
      if isEmpty {
          return nil
      } else {
          defer { front += 1 }
          return elements[front]
      }
  }

  func top() -> T? {
      return isEmpty ? nil : elements[front]
  }
}

//extension QueueWithArrayPointer: CustomStringConvertible {
//  var description: String {
//    (front..<elements.count).map { elements[$0] }.description
//  }
//}
