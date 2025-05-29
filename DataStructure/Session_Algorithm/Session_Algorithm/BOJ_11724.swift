//
//  BOJ_11724.swift
//  Session_Algorithm
//
//  Created by 박신영 on 5/29/25.
//

import Foundation

/*
 문제
 - 방향 없는 그래프가 주어졌을 때, 연결 요소 (Connected Component)의 개수를 구하는 프로그램을 작성하시오.
 
 입력
 - 첫째 줄에 정점의 개수 N과 간선의 개수 M이 주어진다. (1 ≤ N ≤ 1,000, 0 ≤ M ≤ N×(N-1)/2)
 - 둘째 줄부터 M개의 줄에 간선의 양 끝점 u와 v가 주어진다.(1 ≤ u, v ≤ N, u ≠ v)
 - 같은 간선은 한 번만 주어진다.
 */

func boj11724() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0], m = input[1]
    
    var adjList: [[Int]] = .init(repeating: [], count: n + 1)
    
    for _ in 0..<m {
        let edge = readLine()!.split(separator: " ").map { Int($0)! }
        adjList[edge[0]].append(edge[1])
        adjList[edge[1]].append(edge[0])
    }
    
    // 0. 큐가 빌 때까지 반복
    // 1). 시작하는 노드를 큐에 넣고 방문했다는 표시를 남김
    // 2). 큐에서 노드를 빼면서, 해당 노드와 연결되어 있는 노드들 중
    // 2-1). 이미 방문한 노드면 스킵
    // 2-2). 방문하지 않은 노드면 방문했다는 표시를 남기고 큐에 넣어줌
    var queue: [Int] = []
    var front = 0
    var vis: [Bool] = .init(repeating: false, count: n + 1)
    
    /// BFS를 모든 노드에 대해 돌리자
    ///     왜냐하면 모든 노드가 연결돼있지 않으니까. 1-2-5 / 3-4-6
    var answer = 0
    for start in 1...n {
        if vis[start] { continue }
        
        // == 1)
        queue.append(start)
        vis[start] = true
        answer += 1 //연결 요소의 개수
        
        // == 0)
        while queue.count >= front + 1 {
            // == 2)
            let cur = queue[front]
            front += 1
            print(cur)
            
            for degree in adjList[cur] {
                if vis[degree] { continue }
                vis[degree] = true
                queue.append(degree)
            }
        }
        
    }
    
    print(answer)
}




