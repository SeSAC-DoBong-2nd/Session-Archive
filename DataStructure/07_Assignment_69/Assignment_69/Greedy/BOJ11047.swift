//
//  BOJ11047.swift
//  Assignment_69
//
//  Created by Bran on 4/22/25.
//

import Foundation

/// [동전0] https://www.acmicpc.net/problem/11047
func boj_11047() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, K) = (input[0], input[1])
    
    var coins = [Int]()
    var total = K
    var count = 0
    
    for _ in 0..<N {
        coins.append(Int(readLine()!)!)
    }
    
    for i in coins.reversed() {
        if total / i != 0 {
            count += total / i
            total %= i
        }
        
        if total == 0 { break }
    }
    
    print(count)
}


//MARK: - Bran님 풀이
func boj_11047_Bran() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
}
