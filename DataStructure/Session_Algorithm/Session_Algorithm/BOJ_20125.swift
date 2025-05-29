//
//  BOJ_20125.swift
//  Session_Algorithm
//
//  Created by 박신영 on 5/13/25.
//

import Foundation

/**
 - 문제
 쿠키 신체 측정
 한 변의 길이가 N 정사각형 판위에 눕기. 어느 신체 부위도 판 밖으로 벗어나지 않음
 판의 x번째행, y번째 열에 위치한 곳을 xmy라 칭함.
 판의 맨 위쪽 칸을 1,1 오른쪽 아래 칸을 N,N이라 칭함
 머리는 심장 바로 윗칸에 1칸
 허리는 심장 바로 아래, 각 다리는 전부 아래로 뻗기
 
 */

func boj20125() {
    let N = Int(readLine()!)!
    
    var map = Array(repeating: Array(repeating: "", count: N), count: N)
    for i in 0..<N {
        let t = readLine()!.split(separator: "").map {String($0)}
        map[i] = t
    }
    var heart = (0, 0)
    var leftArm = 0
    var rightArm = 0
    
    loop: for y in 0..<map.count {
        for x in 0..<map[y].count {
            if map[y][x] == "*" {
                print(y, x)
                heart = (y+2, x+1) // 좌상단이 1,1이기에 각 +2, +1을 해줌
                break loop
            }
        }
    }
    
    for i in 0..<map[heart.0 - 1].count {
        print(map[heart.0 - 1][i])
        if map[heart.0][i] == "*" && i < heart.1 {
            leftArm += 1
        } else if map[heart.0][i] == "*" && i > heart.1 {
            rightArm += 1
        }
    }
    
    print(heart)
    print(leftArm)
    print(rightArm)
}


func boj20125_Bran() {
    let n = Int(readLine()!)!
    
    var board: [[String]] = []
    for _ in 1...n {
        let input = readLine()!.split(separator: "").map {String($0)}
        board.append(input)
    }
    
    var head = (0, 0)
    
    loop: for y in 0..<n {
        for x in 0..<n {
            if board[y][x] == "*" {
                head = (y, x)
                break loop
            }
        }
    }
    
    let heart = (head.0 + 1, head.1)
    var leftArm = 0
    var rightArm = 0
    
    // 왼팔
    for x in stride(from: head.1 - 1, through: 0, by: -1) {
        if board[heart.0][x] == "*" { leftArm += 1 }
    }
    
    // 오른팔
    for x in head.1 + 1..<n {
        if board[head.0 + 1][x] == "*" { rightArm += 1 }
    }
    
    var waist = 0 // 허리
    
    for y in head.0 + 2..<n {
        if board[y][head.1] == "*" { waist += 1 }
    }
    
    var leftLeg = 0
    
    for y in head.0 + 2 + waist..<n {
        if board[y][head.1 - 1] == "*" { leftLeg += 1 }
    }
    
    var rightLeg = 0
    
    for y in head.0 + 2 + waist..<n {
        if board[y][head.1 + 1] == "*" { rightLeg += 1 }
    }
    
    print(heart.0 + 1, heart.1 + 1)
    print(leftArm, rightArm, waist, leftLeg, rightLeg)
}


func boj_20125_Bran() {
  typealias Pos = (Int, Int)

  let n = Int(readLine()!)!

  var board: [[String]] = []
  for _ in 1...n {
    let input = readLine()!.map { String($0) }
    board.append(input)
  }

  var head: Pos = (0, 0)
  for y in 0..<n {
    var flag = false
    for x in 0..<n {
      if board[y][x] == "*" {
        head = (y, x)
        flag = true
        break
      }
    }
    if flag { break }
  }

  var leftArm = 0
  for x in stride(from: head.1 - 1, through: 0, by: -1) {
    if board[head.0 + 1][x] == "*" { leftArm += 1 }
  }

  var rightArm = 0
  for x in head.1 + 1..<n {
    if board[head.0 + 1][x] == "*" { rightArm += 1 }
  }

  var waist = 0
  for y in head.0 + 2..<n {
    if board[y][head.1] == "*" { waist += 1 }
  }

  var leftLeg = 0
  for y in head.0 + 2 + waist..<n {
    if board[y][head.1 - 1] == "*" { leftLeg += 1 }
  }

  var rightLeg = 0
  for y in head.0 + 2 + waist..<n {
    if board[y][head.1 + 1] == "*" { rightLeg += 1 }
  }

  print(head.0 + 2, head.1 + 1)
  print(leftArm, rightArm, waist, leftLeg, rightLeg)
}
