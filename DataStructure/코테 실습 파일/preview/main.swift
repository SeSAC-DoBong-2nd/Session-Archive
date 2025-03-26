//
//  main.swift
//  preview
//
//  Created by 박신영 on 3/18/25.
//

import Foundation

let input = readLine()!
    .components(separatedBy: " ")
    .map { Int($0)! }

print(input[0] + input[1])

