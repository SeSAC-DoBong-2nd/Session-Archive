//
//  main.swift
//  10_Graph_Start
//
//  Created by Bran on 5/27/25.
//

import Foundation

print("Hello, World!")

graphAdjMat(6, [[1, 2], [2, 3], [3, 4], [2, 6], [6, 4], [4, 5]])
//directedGraphAdjMat(6, [[1, 2], [3, 2], [2, 6], [4, 3], [6, 4], [4, 5]])
//weightedGraphAdjMat(6, [
//    [1, 2, 3], [3, 2, 1], [2, 6, 2],
//    [4, 3, 10], [6, 4, -3], [4, 5, 9]
//  ])
print("-------------------------------")
graphAdjList(6, [[1, 2], [3, 2], [2, 6], [4, 3], [6, 4], [4, 5]])
