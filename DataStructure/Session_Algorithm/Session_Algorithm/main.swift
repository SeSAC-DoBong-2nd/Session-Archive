//
//  main.swift
//  Session_Algorithm
//
//  Created by 박신영 on 5/13/25.
//

import Foundation

print("Hello, World!")

func graph() {
    // 컴퓨터 수
    let n = Int(readLine()!)!
    // 네트워크 상 직접 연결된 컴터 쌍의 수
    let m = Int(readLine()!)!
    
    var adjList: [[Int]] = Array(repeating: [], count: n + 1)
    for _ in 0..<m {
        let edge = readLine()!.split(separator: " ").map { Int($0)! }
        adjList[edge[0]].append(edge[1])
        adjList[edge[1]].append(edge[0])
    }
    
    var queue: [Int] = []
    var front = 0
    var vis: [Bool] = .init(repeating: false, count: n + 1)
//    var answer = 0
    
    queue.append(1)
    vis[1] = true
    
    while queue.count >= front + 1 {
        let cur = queue[front]
        front += 1
        
        for degree in adjList[cur] {
            if vis[degree] { continue }
            vis[degree] = true
            queue.append(degree)
//            answer += 1
        }
    }
    
    print(vis.filter { $0 }.count - 1)
//    print(answer)
}

graph()
