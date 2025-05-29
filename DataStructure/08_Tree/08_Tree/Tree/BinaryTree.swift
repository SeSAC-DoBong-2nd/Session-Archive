//
//  BinaryTree.swift
//  08_Tree
//
//  Created by Bran on 5/20/25.
//

import Foundation

// MARK: - Node기반 BinaryTree
final class BinaryTree<T: Equatable> {
  var value: T
  var leftChild: TreeNode<T>?
  var rightChild: TreeNode<T>?

  init(_ value: T) {
    self.value = value
  }
}

// MARK: - 순회
extension BinaryTree {
}

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
  }

  func inorder(_ index: Int = 1) {
  }

  func postorder(_ index: Int = 1) {
  }
}
