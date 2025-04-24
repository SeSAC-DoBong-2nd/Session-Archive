//
//  BOJ4396.swift
//  Assignment_69
//
//  Created by Bran on 4/21/25.
//

import Foundation

func boj_4396() {
    let n = Int(readLine()!)!
    
    var initalBoard: [[String]] = .init(repeating: [], count: n)
    for i in 0..<n {
        let input = readLine()!.map { String($0) }
        initalBoard[i] = input
    }
    
    var currentBoard: [[String]] = .init(repeating: [], count: n)
    for i in 0..<n {
        let input = readLine()!.map { String($0) }
        currentBoard[i] = input
    }
    
    var answer: [[String]] = .init(repeating: .init(repeating: ".",
                                                    count: n),
                                   count: n)
    let dy = [-1, -1, 0, 1, 1, 1, 0, -1]
    let dx = [0, 1, 1, 1, 0, -1, -1, -1]
    
    
    ///2차원 배열 도는 코드. 이해하자!
    for y in 0..<n {
        for x in 0..<n {
            if currentBoard[y][x] == "x" {
                var count = 0
                for dir in 0..<8 {
                    let ny = y + dy[dir], nx = x + dx[dir]
                    if ny < 0 || ny >= n || nx < 0 || nx >= n { continue }
                    if initalBoard[ny][nx] == "*" { count += 1 }
                }
                answer[y][x] = String(count)
            }
        }
    }
    
    var mines: [(Int, Int)] = []
    var flag = false
    for y in 0..<n {
        for x in 0..<n {
            if initalBoard[y][x] == "*" {
                mines.append((y, x))
                if currentBoard [y][x] == "x" { flag = true }
            }
        }
    }
    
    if flag {
        for mine in mines {
            answer[mine.0][mine.1] = "*"
        }
    }
    
    for y in 0..<n {
        for x in 0..<n {
            print(answer[y][x], terminator: "")
        }
        print("")
    }
}
