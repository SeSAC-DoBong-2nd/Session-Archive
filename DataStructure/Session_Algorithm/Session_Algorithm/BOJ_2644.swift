//
//  BOJ_2644.swift
//  Session_Algorithm
//
//  Created by 박신영 on 5/29/25.
//

import Foundation

func boj2644() {
    let n = Int(readLine()!)!
    let find = readLine()!.split(separator: " ").map { Int($0)! }
    let m = Int(readLine()!)!
    
    var adjList: [[Int]] = .init(repeating: [], count: n + 1)
    
    for _ in 0..<m {
        let edge = readLine()!.split(separator: " ").map { Int($0)! }
        adjList[edge[0]].append(edge[1])
        adjList[edge[1]].append(edge[0])
    }
    
    var queue: [Int] = []
    var front = 0
    
    // -1인경우, 아직 방문하지 않은 노드
    // find[0] 노드로 부터 거리를 저장
    var vis: [Int] = .init(repeating: -1, count: n + 1)
    
    // 시작하는 노드를 큐에 넣고 방문했다는 표시를 남긴다
    queue.append(find[0])
    vis[find[0]] = 0
    
    while queue.count >= front + 1 {
        let cur = queue[front]
        front += 1
        
        for degree in adjList[cur] {
            if vis[degree] != -1 { continue }
            vis[degree] = vis[cur] + 1
            queue.append(degree)
        }
    }
    
    print(vis[find[1]])
}
