//
//  Graph.swift
//  10_Graph_Start
//
//  Created by Bran on 5/27/25.
//

import Foundation

// MARK: - Graph Expression
/**
 Directed [x] + Weighted [x] + AdjMatrix
 - Parameters:
 - node: node의 개수
 - edges: [ [1, 2], [2, 3] ] 2차원 배열로 표현된 각 노드간 연결 구성 정보
 */

/// 6
/// [[1, 2], [2, 3], [3, 4], [2, 6], [6, 4], [4, 5]]
func graphAdjMat(_ node: Int, _ edges: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1),
                                count: node + 1)
    
    for edge in edges {
        adjMat[edge[0]][edge[1]] = 1 // ex(1, 2) 연결되어있음
        adjMat[edge[1]][edge[0]] = 1 // ex(2, 1) 연결되어있음
    }
    
    for y in 1...node {
        for x in 1...node {
            print(adjMat[y][x], terminator: " ")
        }
        print("")
    }
}


/**
 Directed [o] + Weighted [x] + AdjMatrix
 - Parameters:
 - node: node의 개수
 - edges: [ [1, 2], [2, 3] ] 2차원 배열로 표현된 각 노드간 연결 구성 정보
 */
func directedGraphAdjMat(_ node: Int, _ edges: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0,
                                                 count: node + 1),
                                count: node + 1)
    
    for edge in edges {
        adjMat[edge[0]][edge[1]] = 1
    }
    
    for y in 1...node {
        for x in 1...node {
            print(adjMat[y][x], terminator: " ")
        }
        print("")
    }
}


/*
 let costs: [[Int]] = [
 [1, 2, 3], [3, 2, 1], [2, 6, 2],
 [4, 3, 10], [6, 4, -3], [4, 5, 9]
 ]
 */
func weightedGraphAdjMat(_ node: Int, _ cost: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1), count: node + 1)
    
    for edge in cost {
        adjMat[edge[0]][edge[1]] = edge[2]
        adjMat[edge[1]][edge[0]] = edge[2]
    }
    
    for y in 1...node {
        for x in 1...node {
            print(adjMat[y][x], terminator: " ")
        }
        print("")
    }
}

/// Directed [x] + Weighted [x] + AdjList
// 1 [2]
// 2 [1, 3, 6]
// 3 [2, 4]
// 4 [3, 6, 5]
// 5 [4]
// 6 [2, 4]
// edge = [4, 5]
func graphAdjList(_ node: Int, _ edges: [[Int]]) {
    var adjList: [[Int]] = .init(repeating: [], count: node + 1)
    
    for edge in edges {
        adjList[edge[0]].append(edge[1])
        adjList[edge[1]].append(edge[0])
    }
    
    for i in 1...node {
        print(adjList[i])
    }
}

// MARK: - Graph Search
// 6, [[1, 2], [3, 2], [2, 6], [4, 3], [6, 4], [4, 5]]
func bfsAdjMatrix(_ node: Int, _ edges: [[Int]]) {
    var adjMatrix: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1), count: node + 1)
    for edge in edges {
        adjMatrix[edge[0]][edge[1]] = 1
        adjMatrix[edge[1]][edge[0]] = 1
    }
    
    var vis: [Bool] = .init(repeating: false, count: node + 1)
    var queue: [Int] = []
    var front = 0
    
    queue.append(1)
    vis[1] = true
    
    //O(V^2)
    while queue.count >= front + 1 {
        // Queue에 있는 노드를 뽑아내고 (출력)
        let cur = queue[front]
        front += 1
        print(cur)
        
        // cur과 연결되어 있는 노드들을 어떻게 확인할 것인가?
        for degree in 1...node {
            if adjMatrix[cur][degree] == 0 { continue } // 연결되지 않은 노드
            if vis[degree] { continue }
            
            queue.append(degree)
            vis[degree] = true
        }
    }
}

func bfsAdjList(_ node: Int, _ edges: [[Int]]) {
    var adjList: [[Int]] = .init(repeating: [], count: node + 1)
    for edge in edges {
        adjList[edge[0]].append(edge[1])
        adjList[edge[1]].append(edge[0])
    }
    
    var vis: [Bool] = .init(repeating: false, count: node + 1)
    var queue: [Int] = []
    var front = 0
    
    queue.append(1)
    vis[1] = true
    
    while queue.count >= front + 1 {
        // Queue에 있는 노드를 뽑아내고 (출력)
        let cur = queue[front]
        front += 1
        print(cur)
        
        
        // 1 [2]
        // 2 [1, 3, 6]
        // ...
        for degree in adjList[cur] where !vis[degree] {
            queue.append(degree)
            vis[degree] = true
        }
    }
}
