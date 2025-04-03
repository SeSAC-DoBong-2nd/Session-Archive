//
//  QueueWithCircularArray.swift
//  04_Queue
//
//  Created by Bran on 4/3/25.
//

import Foundation

struct QueueWithCirculrArray<T> {
    private var elements: [T?]
    private var front = 0 // 제일 먼저 들어온 인덱스
    private var rear = 0 // 제일 마지막에 들어온 인덱스 + 1
    private let size: Int
    
    init(size: Int) {
        self.size = size
        self.elements = .init(repeating: nil, count: size)
    }
    
    private var count: Int {
        rear - front
    }
    
    private var isEmpty: Bool {
        count == 0
    }
    
    // size = 원형큐의 크기
    // count = 실제 큐에 들어있는 원소의 개수
    private var isFull: Bool {
        (size - count) == 0
    }
    
    // 0) 만약 원형큐에 공간이 있다면 (isFull로 판단)
    // 1) Rear라는 포인터가 가리키는 인덱스에 원소를 추가하고,
    // 2) Rear를 1 증가시킵니다.
    //   2-1) 만약, size에 도달했다면 다시 처음으로 돌아갑니다. (% 연산을 활용)
    mutating func push(with element: T) {
        if !isFull {
            elements[rear % size] = element
            rear += 1
        }
    }
    
    // 0) 원형큐가 비어있지 않다면, (isEmpty로 판단)
    // 1) front가 가리키는 원소를 반환하고
    // 2) front를 1 증가시킨다
    //   2-1) 만약, size에 도달했다면 다시 처음으로 돌아갑니다. (% 연산을 활용)
    @discardableResult //return 값을 사용하지 않고 버릴 수 있음
    mutating func pop() -> T? {
        if !isEmpty {
            let element = elements[front % size]
            defer { front += 1 }
            return element
        } else {
            return nil
        }
    }
}



