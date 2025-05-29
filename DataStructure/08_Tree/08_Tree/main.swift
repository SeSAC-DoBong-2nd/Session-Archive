//
//  main.swift
//  08_Tree
//
//  Created by Bran on 5/20/25.
//

import Foundation

// MARK: - Linear File System
//let fileSystem = LinearFileSystem()
//
//fileSystem.addItem(name: "Data", isDirectory: true)
//
//fileSystem.addItem(name: "DB", isDirectory: true, parentPath: "Data")
//fileSystem.addItem(name: "Network", isDirectory: true, parentPath: "Data")
//fileSystem.addItem(name: "Repositories", isDirectory: true, parentPath: "Data")
//
//fileSystem.addItem(name: "someDTO1.swift", isDirectory: false, parentPath: "Data/DB")
//fileSystem.addItem(name: "someDTO2.swift", isDirectory: false, parentPath: "Data/DB")
//
//fileSystem.addItem(name: "Router", isDirectory: true, parentPath: "Data/Network")
//fileSystem.addItem(name: "Target1.swift", isDirectory: false, parentPath: "Data/Network/Router")
//fileSystem.addItem(name: "Target2.swift", isDirectory: false, parentPath: "Data/Network/Router")
//
//fileSystem.printAllItems()

// MARK: - Non-Linear FileSystem
//let data = FileNode(data: .init(name: "Data", isDirectory: true))
//
//let network = FileNode(data: .init(name: "Network", isDirectory: true))
//let db = FileNode(data: .init(name: "DB", isDirectory: true))
//let repo = FileNode(data: .init(name: "Repositories", isDirectory: true))
//
//data.add(network)
//data.add(db)
//data.add(repo)
//
//db.add(.init(data: .init(name: "seomDTO1.swift", isDirectory: false)))
//db.add(.init(data: .init(name: "someDTO2.swift", isDirectory: false)))
//
//let router = FileNode(data: .init(name: "Router", isDirectory: true))
//network.add(router)
//router.add(.init(data: .init(name: "Target1.swift", isDirectory: false)))
//router.add(.init(data: .init(name: "Target2.swift", isDirectory: false)))
//
//data.traverse()

//db.data = .init(name: "DataBase", isDirectory: true)
//data.traverse()

// MARK: - BFS, DFS
let hue = TreeNode(value: "Hue")
let jack = TreeNode(value: "Jack")
let hoo = TreeNode(value: "Hoo")
let bran = TreeNode(value: "Bran")
let ron = TreeNode(value: "Ron")
let den = TreeNode(value: "Den")

hue.add(jack)
hue.add(bran)

jack.add(hoo)

bran.add(ron)
bran.add(den)
//
//hue.bfs()
//print("-------")
//hue.bfs_vis()
//print("-------")
hue.dfs_vis()
