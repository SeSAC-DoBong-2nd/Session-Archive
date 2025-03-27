//
//  TimeComplexity.swift
//  01_Complexity
//
//  Created by Bran on 3/24/25.
//

import Foundation

/// 각 메서드들의 시간복잡도를 Big-O 표기법 기준으로 작성해보세요!

// MARK: - 1
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter arr: 길이 2 이상의 [Int] 타입의 배열
/// - Complexity:2N+2 -> O(N)
/// - Returns: arr 원소 중 최댓값
func question1(arr: [Int]) -> Int {
    var max = arr[0]
    for i in 1..<arr.count {
        if arr[i] > max {
            max = arr[i]
        }
    }
    return max
    
}

// MARK: - 2
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter matrix: n x n 형태의 이중 배열
/// - Complexity: N^2 + 2 -> O(n2)
/// - Returns: matrix의 모든 원소 더한 값
func question2(_ matrix: [[Int]]) -> Int {
    var sum = 0
    for y in 0..<matrix.count {
        for x in 0..<matrix[y].count {
            sum += matrix[y][x]
        }
    }
    return sum
}

// MARK: - 3
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter n: 1이상의 정수
/// - Complexity: 3 -> O(1)
/// - Returns: n이 2의 제곱수인지 여부
func question3(_ n: Int) -> Bool {
    n & (n - 1) == 0
    // 2^2 = 2 * 2 = 100
    // 2^2 - 1 = 011
    //100
    //011
    //000 = 0
    
    // 2^3 = 2 * 2 * 2 = 1000
    // 2^3 - 1 = 111
    //1000
    //0111
    //0000 = 0
    
    // 2^4 = 2 * 2 * 2 * 2 = 10000
    // 2^4 - 1 = 1111
    //10000
    //01111
    //00000 = 0
    
    //예시는 2의 거듭제곱과 해당 값에 -1을 한 값인데, 예시와 같이 각 비트를 & 로 연산하여 0이된다면 해당 값이 거듭제곱임을 알 수 있다.
    //즉, n이 2의 제곱수인지 여부를 판별
}

// MARK: - 4
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameter cube: n x m x k 형태의 삼중 배열
/// - Complexity: O(n * m * k) -> O(N^3)
/// - Returns: cube의 모든 원소 합
func question4(_ cube: [[[Int]]]) -> Int {
    var sum = 0
    for z in 0..<cube.count {
        for y in 0..<cube[z].count {
            for x in 0..<cube[z][y].count {
                sum += cube[z][y][x]
            }
        }
    }
    return sum
}

// MARK: - 5
/// 시간복잡도를 작성하고 어떤 값을 Return하고 있는지도 확인해보세요 :)
/// - Parameters:
///   - arr: 오름차순 정렬되어 있는 Int] 타입의 배열
///   - target: 찾고자 하는 값
/// - Complexity: O(logN)
/// - Returns: ?
func question5(arr: [Int], target: Int) -> Int {
    var left = 0
    var right = arr.count - 1
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        if arr[mid] == target {
            return mid
        } else if arr[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    return -1
}


//근데 sorted로 정렬을 하면 해당 배열을 이미 O(N)으로 순회하면서 정렬해둔 값이 나오는데, 이러고 이분탐색으로 찾더라도 이미 시간복잡도는 O(N)을 돈게 아닌가?
