//
//  BOJ9375.swift
//  Assignment_69
//
//  Created by Bran on 4/21/25.
//

import Foundation

func boj_9375() {
  let t = Int(readLine()!)!
  var answer = ""

  for _ in 1...t {
    let n = Int(readLine()!)!
    if n == 0 { answer += "0\n"; continue }

    var dic: [String: Int] = [:]
    var count = 0

    for _ in 1...n {
      let input = readLine()!.split(separator: " ").map { String($0) }
      if let _ = dic[input[1]] {
        dic[input[1]]! += 1
      } else {
        dic[input[1]] = 2
      }
    }

    count = dic.reduce(1) { $0 * $1.value } - 1
    answer += "\(count)\n"
  }

  print(answer)
}
