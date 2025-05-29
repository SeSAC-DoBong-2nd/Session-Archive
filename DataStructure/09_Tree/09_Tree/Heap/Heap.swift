//
//  Heap.swift
//  09_Tree
//
//  Created by Bran on 5/22/25.
//

import Foundation

// MARK: - MinHeap
struct MinHeap<T: Comparable> {
  private var elements: [T?] = [nil] // *1번 인덱스 부터 시작
  private var size = 0 // Heap의 원소 개수(=마지막 원소의 인덱스)

  var top: T? {
    size > 0 ? elements[1] : nil
  }

  /// 1) 완전이진트리 규칙을 만족하는 위치에 원소를 추가(append)
  /// 2) 최소힙의 조건을 만족할 때 까지 부모노드와 위치 변경 반복
  mutating func insert(with element: T) {
    elements.append(element)
    size += 1

    var index = size
    while index > 1 {
      let parent = index / 2
      if elements[parent]! <= elements[index]! { break }
      elements.swapAt(parent, index)
      index = parent
    }
  }

  /// 0) 루트노트(=1 인덱스)값 반환 및 삭제
  /// 1) 값을 제거해도 완전이진트리의 규칙성을 위배하지 않는 마지막 인덱스 값 루트노드 위치로 변경
  /// 2) 최소힙의 조건을 만족할 때 까지 자식노드와 위치 변경 반복
  ///   2 - 1) lc, rc 중 작은 값 선택
  @discardableResult
  mutating func delete() -> T? {
    if size == 0 {
      return nil
    } else {
      let pop = elements[1]
      var index = 1

      elements[1] = elements[size]
      elements.removeLast()
      size -= 1

      while index * 2 <= size {
        let lc = index * 2, rc = index * 2 + 1
        var c: Int
        if rc <= size && elements[lc]! > elements[rc]! {
          c = rc
        } else {
          c = lc
        }

        if elements[index]! <= elements[c]! { break }
        elements.swapAt(index, c)
        index = c
      }

      return pop
    }
  }
}
