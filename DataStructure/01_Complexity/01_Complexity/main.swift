//
//  main.swift
//  01_Complexity
//
//  Created by Bran on 3/24/25.
//

import Foundation

/// 1부터 n 까지의 합을 반환하는 메서드를 완성해주세요!
/// - Parameter n: 1이상의 양의 정수
/// - Returns: 1부터 n 까지의 합
func sum(_ n: Int) -> Int {
    //    return (1...n).reduce(0) {$0 + $1} // == reduce(0, +0
    
    return (n + 1) * n / 2
}

/// - 예시1:  [1, 10, 3, 9, 9] = 10 * 9 = 90
/// - 예시2:  [1, 10, 3, 9, 10] = 10 * 10 = 100
/// - Parameter numbers: 중복이 허용되는 길이 2 이상의 [Int] 배열
/// - Returns: numbers에서 가장 큰 값 * numbers에서 두번째로 큰 값
func findMaxValue(numbers: [Int]) -> Int {
    //    let sortedArr = numbers.sorted { $0 > $1 }
    //
    //    return sortedArr[0] + sortedArr[1]
    
    var firstValue = Int.min // 제일 큰 값
    var secondValue = Int.min // 두번째로 큰 값
    
    //[1, 2, 3]
    //n * 4 + 3
    for number in numbers {
        if number >= firstValue {
            secondValue = firstValue
            firstValue = number
        } else if number >= secondValue {
            secondValue = number
        }
    }
    
    return firstValue * secondValue
}


/// 1) 4로 나누어 떨어지는 해는 윤년
/// 2) 4와 100으로 나누어 떨어지는 해는 평년
/// 3) 4, 100, 400으로 나누어 떨어지는 해는 윤년
/// - Parameter year: year
/// - Returns: 윤년인 경우 true, 윤년이 아닌 경우 false반환
func isLeapYear(year: Int) -> Bool {
//    if year % 4 == 0 {
//        if year % 100 == 0 {
//            if year % 400 == 0 {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return true
//        }
//    } else {
//        return false
//    }
    
    if year % 400 == 0 { // 1번
        return true
    } else if year % 100 != 0 && year % 4 == 0 { // 2번
        return true
    } else {
        return false
    }
}


//연산
//-> cnt에 0을 대입하는 것도 연산으로 된다.
func complexity(arr: [Int]) -> Int {
    var cnt = 0
    for element in arr {
        if element % 2 == 0 { cnt += 1 }
    }
    return cnt
}

