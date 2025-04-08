//
//  Sort.swift
//  05_Search_Sort
//
//  Created by Bran on 4/8/25.
//

import Foundation

/**
 버블 정렬 - 오름차순
 - Complexity: O(N^2)
 - Stable:  O
 Stable일 수도, 아닐수도 있지만 조건이 아래와 같기에 Stable
 if arr[j - 1] > arr[j] (>= 등호가 있었다면 UnStable)
 - In-Place:  O
 inout을 사용함으로써 새로운 메모리 공간을 생성하지 않기에 In-Place (이를 사용하지 않는다면 CopyOnWrite 발생으로 Not In-Place
 */
func bubbleSort<T: Comparable>(_ arr: inout [T]) {
    let size = arr.count
    // i = 정렬된 데이터의 개수
    for i in 0..<size {
        // j = 데이터 순회 Index
        for j in 1..<size - i {
            if arr[j - 1] > arr[j] {
                arr.swapAt(j - 1, j)
            }
        }
    }
}

/**
 삽입정렬 - 오름차순
 - Complexity: O(N^2)
 - Stable: O
 - 둘 다 가능하지만 현재 조건으로는 Stable
 -> arr[j - 1] > arr[j]
 -> 위 조건이 >= 였다면 UnStable
 - In-Place: O
 - inout을 사용하였기에 In-Place (Copy On Write가 발생하지 않음)
 - array의 크기에 따라 공간복잡도가 비례하게 증가하지 않기에 In-Place
 */
func insertionSort<T: Comparable>(_ arr: inout [T]) {
    let size = arr.count
    // i = 정렬된 데이터 개수(=정렬된 영역의 데이터 개수)
    for i in 1..<size {
        for j in stride(from: i, to: 0, by: -1) {
            if arr[j - 1] > arr[j] {
                arr.swapAt(j - 1, j)
            } else { break }
        }
    }
}


/**
 정렬된 두 배열을 합쳐서 정렬하는 방법 - 오름차순
 - Complexity: O(N + M)
 - Parameters:
 - arr1: 오름차순으로 정렬된 임의 배열
 - arr2: 오름차순으로 정렬된 임의 배열
 */
func mergeArr<T: Comparable>(_ arr1:[T], _ arr2: [T]) -> [T] {
    let n = arr1.count, m = arr2.count
    var index1 = 0, index2 = 0
    var temp: [T] = []
    temp.reserveCapacity(n + m)
    
    for _ in 0..<n + m {
        if index1 == n {
            temp.append(arr2[index2])
            index2 += 1
        } else if index2 == m {
            temp.append(arr1[index1])
            index1 += 1
        } else if arr1[index1] >= arr2[index2] {
            temp.append(arr2[index2])
            index2 += 1
        } else {
            temp.append(arr1[index1])
            index1 += 1
        }
    }
    
    return temp
}

/**
 병합정렬 - 오름차순
 - Complexity: O(NlogN)
 - Stable: O
 - In-Place: X
    합치는 과정에서 비어있는 공간이 발생하기에 not in-place
 */
func mergeSort<T: Comparable>(_ arr: inout [T],
                              _ start: Int,
                              _ end: Int) {
    
    //(end == 마지막 index + 1) == 시작 인덱스 + 1
    if end == start + 1 { return } // base condition(개수 1)
    let mid = (start + end) / 2
    mergeSort(&arr, start, mid)
    mergeSort(&arr, mid, end)
    merge(arr: &arr, start, end)
    
    
    // 정렬되어 있는 두 배열을 합쳐서 정렬하는 메서드 mergeArr
    func merge(arr: inout [T], _ start: Int, _ end: Int) {
        let mid = (start + end) / 2
        var lIndex = start, rIndex = mid
        
        var temp: [T] = []
        temp.reserveCapacity(end - start)
        for _ in start..<end {
            if lIndex == mid {
                temp.append(arr[rIndex])
                rIndex += 1
            } else if rIndex == end {
                temp.append(arr[lIndex])
                lIndex += 1
            } else if arr[lIndex] <= arr[rIndex] {
                temp.append(arr[lIndex])
                lIndex += 1
            } else {
                temp.append(arr[rIndex])
                rIndex += 1
            }
        }
        
        for i in start..<end {
            arr[i] = temp[i - start]
        }
    }
}


/**
 퀵소드 - 오름차순
 임시배열을 만들지 않고 Cache Hit Rate이 높게 만들어야 QuickSort의 의미가 있음
 - Complexity: O(NlogN) ~ O(N^2)
 - Stable: X
 - In-Place: O
 */
func quickSort<T: Comparable>(_ arr: inout [T],
                              _ start: Int,
                              _ end: Int) {
    if end <= start + 1 { return }
    let pivot = arr[start]
    var left = start + 1, right = end - 1
    
    while true {
        while left <= right && arr[left] <= pivot { left += 1 } // pivot 보다 큰 값
        while left <= right && arr[right] > pivot { right -= 1 } // pivot 보다 작거나 작은 값
        if left > right { break }
        arr.swapAt(left, right)
    }
    arr.swapAt(start, right)
    
    quickSort(&arr, start, right)
    quickSort(&arr, right + 1, end)
}

/**
 카운팅 소트 - 오름차순
 - Complexity: O(N + K)
 - Stable: X
 - In-Place: X
 */
func countingSort(_ arr: inout [Int]) {
    let maxValue = arr.max()!
    var dic: [Int: Int] = [:]
    // O(N)
    for element in arr {
        if let _ = dic[element] {
            dic[element]! += 1
        } else {
            dic[element] = 1
        }
    }
    
    var temp: [Int] = []
    // O(K)
    for i in 0...maxValue {
        if let count = dic[i] {
            for _ in 0..<count { temp.append(i) }
        }
    }
    
    for i in 0..<arr.count {
        arr[i] = temp[i]
    }
}
