//
//  QueuewithArray.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

struct QueueWithArray<T> {
    private var elements: [T] = []
    
    mutating func push(with element: T) {
        elements.append(element) // 시간복잡도 O(1)
//        elements.insert(element, at: 0) // 시간복잡도 O(n)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        elements.isEmpty ? nil : elements.removeFirst()
    }
    
    func top() -> T? {
        elements.first
    }
}

extension QueueWithArray: CustomStringConvertible {
  var description: String {
    elements.description
  }
}
