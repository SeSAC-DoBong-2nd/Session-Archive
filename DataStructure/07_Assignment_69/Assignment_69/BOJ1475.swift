//
//  BOJ1475.swift
//  Assignment_69
//
//  Created by Bran on 4/20/25.
//

import Foundation

func boj_1475() {
  let n = readLine()!.map { String($0) }
  var vis: [Int] = .init(repeating: 0, count: 9)

  for number in n {
    let index = Int(number) == 9 ? 6 : Int(number)!
    vis[index] += 1
  }

  vis[6] = vis[6] % 2 + vis[6] / 2

  var answer = 0
  for i in 0...8 {
    if vis[i] >= answer { answer = vis[i] }
  }

  print(answer)
}
