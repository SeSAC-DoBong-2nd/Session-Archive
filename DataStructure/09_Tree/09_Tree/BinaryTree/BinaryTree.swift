//
//  BinaryTree.swift
//  09_Tree
//
//  Created by Bran on 5/22/25.
//

import Foundation

// MARK: - Array기반 BinaryTree
struct BinaryTreeArray<T: Equatable> {
  private var elements: [T?] = [nil]

  init(rootValue: T) {
    self.elements.append(rootValue)
  }

  private mutating func expandIfNeeded(index: Int) {
    while elements.count <= index {
      elements.append(nil)
    }
  }

  mutating func insert(_ value: T, at index: Int) {
    expandIfNeeded(index: index)
    elements[index] = value
  }
}

// MARK: - 순회
extension BinaryTreeArray {
  func preorder(_ index: Int = 1) {
    /// Base Condition
    guard index < elements.count,
          let node = elements[index]
    else { return }

    print(node)
    preorder(index * 2) // Left Child
    preorder(index * 2 + 1) // Right Child
  }

  func inorder(_ index: Int = 1) {
    /// Base Condition
    guard index < elements.count,
          let node = elements[index]
    else { return }

    inorder(index * 2) // Left Child
    print(node)
    inorder(index * 2 + 1) // Right Child
  }

  func postorder(_ index: Int = 1) {
      /// Base Condition
      guard index < elements.count,
            let node = elements[index]
      else { return }

      postorder(index * 2) // Left Child
      postorder(index * 2 + 1) // Right Child
      print(node)
  }
}
