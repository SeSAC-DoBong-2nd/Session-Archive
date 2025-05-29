//
//  FileSystem.swift
//  08_Tree
//
//  Created by Bran on 5/20/25.
//

import Foundation

struct File {
  var name: String
  let isDirectory: Bool
}

extension File: CustomStringConvertible {
  var description: String {
    name
  }
}

final class FileNode {
  var data: File
  var children: [FileNode] = []
  weak var parent: FileNode?

  init(data: File, children: [FileNode] = []) {
    self.data = data
    self.children = children
  }
}

extension FileNode {
  func add(_ child: FileNode) {
    children.append(child)
    child.parent = self
  }

//  func traverse() {
//    if data.isDirectory {
//      print("\(data)" + "/", terminator: "")
//    } else {
//      print(data)
//    }
//
//    for child in children {
//      child.traverse()
//    }
//  }

  func traverse(path: String = "") {
    let currentPath: String

    if path.isEmpty {
      currentPath = data.description
    } else {
      currentPath = path + "/" + data.description
    }

    if children.isEmpty || !data.isDirectory {
      print(currentPath + (data.isDirectory ? "/" : ""))
    }

    for child in children {
      child.traverse(path: currentPath)
    }
  }
}

