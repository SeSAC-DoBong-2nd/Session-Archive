//
//  Bran's Solves.swift
//  04_Queue
//
//  Created by 박신영 on 4/3/25.
//

import Foundation

//https://www.acmicpc.net/problem/2480
///주사위
///같은눈 3개 = 만원+같은눈x천원
///같은눈 2개 = 1000원+같은눈x100원
///모두 다른 경우 = 가장 큰 눈 x 100
func boj_2480() {
    ///분기처리는 많아지지만 직관적으로 조건을 해독할 수 있도록 하는 걸 선호한다.
    ///코드를 줄이는 것도 좋지만 위를 수행하며 조건을 놓치는게 없는지 파악하는 것 역시 중요
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    
    var answer = 0
    // 숫자 세개가 다 같은 경우
    if input[0] == input[1] && input[1] == input[2] {
        answer = 10000 + input[0] * 1000
        // 숫자 두개가 같은 경우
    } else if input[0] == input[1] || input[0] == input[2] {
        answer = 1000 + input[0] * 100
    } else if input[1] == input[2] {
        answer = 1000 + input[1] * 100
        // 숫자 세개가 다 다른 경우
    } else {
        answer = input.max()! * 100
    }
    
    print(answer)
}


/// https://www.acmicpc.net/problem/2164
func boj_2164_bran() {
    struct QueueWithArrayPointer<T> {
        var elements: [T] = []
        private var front = 0
        
        var isEmpty: Bool {
            count < 1
        }
        
        var count: Int {
            elements.count - front
        }
        
        mutating func push(with element: T) {
            elements.append(element)
        }
        
        @discardableResult
        mutating func pop() -> T? {
            if isEmpty {
                return nil
            } else {
                defer { front += 1 }
                return elements[front]
            }
        }
        
        func top() -> T? {
            return isEmpty ? nil : elements[front]
        }
    }
    
    let n = Int(readLine()!)!
    var queue = QueueWithArrayPointer<Int>()
    // 1...n 카드 생성
    for i in 1...n {
        queue.push(with: i)
    }
    while queue.count > 1 {
        queue.pop()
        queue.push(with: queue.pop()!)
    }
    
    print(queue.top()!)
}

//QueueWithArrayPointer 사용하지 않는 방법
func boj_2164_bran2() {
    let n = Int(readLine()!)!
    var queue: [Int] = []
    var front = 0
    
    for i in 1...n {
        queue.append(i)
    }
    
    while queue.count - front > 1 {
        front += 1 // pop
        queue.append(queue[front]) // push
        front += 1
    }
    
    print(queue[front])
}
