//
//  LinearFileSystem.swift
//  08_Tree
//
//  Created by Bran on 5/20/25.
//

import Foundation

struct FileItem {
  let name: String
  let isDirectory: Bool
  let path: String

  init(name: String, isDirectory: Bool, parentPath: String) {
    self.name = name
    self.isDirectory = isDirectory
    self.path = parentPath.isEmpty ? name : "\(parentPath)/\(name)"
  }
}


final class LinearFileSystem {
  private var items: [FileItem] = []

  func addItem(name: String, isDirectory: Bool, parentPath: String = "") {
    let newItem = FileItem(name: name,
                           isDirectory: isDirectory,
                           parentPath: parentPath)

    items.append(newItem)
  }

  func printAllItems() {
    for item in items {
      print("\(item.isDirectory ? "Dir: " : "File:")\(item.path)")
    }
  }
}
