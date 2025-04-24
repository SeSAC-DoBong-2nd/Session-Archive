//
//  BOJ1244.swift
//  Assignment_69
//
//  Created by Bran on 4/21/25.
//

import Foundation

func boj_1244() {
  let t = Int(readLine()!)!
  var switches = readLine()!.split(separator: " ").map { Int($0)! }
  switches.insert(-1, at: 0)

  let n = Int(readLine()!)!
  for _ in 1...n {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    if input[0] == 1 {
      var index = input[1]
      while true {
        if index > t { break }
        let current = switches[index]
        switches[index] = current == 0 ? 1 : 0
        index += input[1]
      }
    } else {
      switches[input[1]] = switches[input[1]] == 0 ? 1 : 0
      var index = 1
      while true {
        if input[1] - index <= 0 || input[1] + index > t { break }
        if switches[input[1] - index] == switches[input[1] + index] {
          let current = switches[input[1] - index]
          switches[input[1] - index] = current == 0 ? 1 : 0
          switches[input[1] + index] = current == 0 ? 1 : 0
          index += 1
        } else {
          break
        }
      }
    }
  }

  for i in 1...t {
    print(switches[i], terminator: " ")
    if i % 20 == 0 { print("") }
  }
}
