//
//  BOJ.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

//https://www.acmicpc.net/problem/2480
///주사위
///같은눈 3개 = 만원+같은눈x천원
///같은눈 2개 = 1000원+같은눈x100원
///모두 다른 경우 = 가장 큰 눈 x 100
func boj2480() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()
    let (one, two, three) = (input[0], input[1], input[2])

    //3개 다 같음
    if one == three {
        print(10000 + one * 1000)
    } else if two == three || one == two {
        print(1000 + two * 100)
    } else {
        print(three * 100)
    }
}

/// https://www.acmicpc.net/problem/2164
/// 1번카드 제일위, N번이 제일 아래
/// 1. 제일 위 카드를 바닥에 버림,
/// 2. 이후 제일 위 카드를 제일 아래로 넣기
/// 3. 이게 1개 남을 때 까지
func boj_2164() {
    let input = Int(readLine()!)!
    
    var queue = QueueWithArrayPointer<Int>()
    queue.elements = Array(Array(1...input).reversed())
    
    while queue.count > 1 {
        queue.pop()
        queue.push(with: queue.pop()!)
    }
    print(queue.top()!)
}
