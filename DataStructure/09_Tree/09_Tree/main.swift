//
//  main.swift
//  09_Tree
//
//  Created by Bran on 5/22/25.
//

import Foundation

// MARK: - Binary Tree
var binaryTree = BinaryTreeArray(rootValue: 7)
binaryTree.insert(1, at: 2)
binaryTree.insert(2, at: 3)
binaryTree.insert(77, at: 4)
binaryTree.insert(1, at: 5)
binaryTree.insert(1, at: 6)
binaryTree.insert(3, at: 7)

//binaryTree.preorder()
//binaryTree.inorder()
binaryTree.postorder()

