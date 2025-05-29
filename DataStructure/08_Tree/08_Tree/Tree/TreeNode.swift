//
//  TreeNode.swift
//  08_Tree
//
//  Created by Bran on 5/20/25.
//

import Foundation

final class TreeNode<T: Equatable> {
    var value: T
    var children: [TreeNode] = []
    
    init(value: T) {
        self.value = value
    }
    
    func add(_ child: TreeNode) {
        children.append(child)
    }
}

// MARK: - Traverse
extension TreeNode {
    func bfs() {
        var queue: [TreeNode] = []
        var front = 0
        
        queue.append(self)
        
        while queue.count >= front + 1 {
            
        }
    }
    
    
    /// 구현의 편의를 위해서 Tree의 Value는 중복되지 않는다고 가정
    func bfs_vis() where T: Hashable {
        var queue: [TreeNode] = []
        var front = 0
        
        // Void가 다루는 데이터가 제일 작기에 Void로 설정
        var vis: [T: Void] = [:] // 방문 여부를 확인하기 위한 변수
        
        queue.append(self)
        vis[self.value] = ()
        
        while queue.count >= front + 1 {
            // 큐에서 노드를 빼고(뺀 노드 출력)
            let curNode = queue[front]
            front += 1
            print(curNode.value)
            
            // 해당 노드와 연결된 노드들을 돌면서,
            for child in curNode.children {
                // 이미 방문한 노드면 skip,
                if let _ = vis[child.value] { continue }
                // 첫 방문이면 방문 표시 이후 queue에 추가
                vis[child.value] = ()
                queue.append(child)
            }
        }
    }
    
    func dfs_vis() where T: Hashable {
        var stack: [TreeNode] = []
        
        // 방문 여부를 확인하기 위한 변수
        var vis: [T: Void] = [:]
        
        stack.append(self)
        vis[self.value] = ()
        
        while !stack.isEmpty {
            let curNode = stack.removeLast()
            print(curNode.value)
            
            for child in curNode.children {
                if let _ =  vis[child.value] { continue }
                vis[child.value] = ()
                stack.append(child)
            }
        }
    }
    
    func recursive_dfs() {
        
    }
}
