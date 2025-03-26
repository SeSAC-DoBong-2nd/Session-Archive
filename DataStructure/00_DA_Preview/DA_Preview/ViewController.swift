//
//  ViewController.swift
//  DA_Preview
//
//  Created by Bran on 3/17/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        measureTime {
            findBran(textFile)
        }
        
        measureTime {
            findBran2(textFile)
        }
    }
}

extension ViewController {
    /// 입력값 str에서 "Bran"이라는 값이 몇 번 등장하는지 작성하세요(대, 소문자를 정확하게 구분)
    /// - Parameter str: 임의의 텍스트값
    /// - Returns: "Bran"의 등장횟수
    func findBran(_ str: String) -> Int {
        // 여러분들만의 코드를 작성해보세요!
        var cnt = 0
        var arr = Array(str)
        for (index, char) in arr.enumerated() {
            if char == "B" && arr[index+1] == "r" && arr[index+2] == "a" && arr[index+3] == "n" {
                cnt += 1
            }
        }
        
        return cnt
    }
    
    func findBran2(_ str: String) -> Int {
        var count = 0
        var searchRange = str.startIndex..<str.endIndex
        
        while let range = str.range(of: "Bran", options: [], range: searchRange) {
            count += 1
            searchRange = range.upperBound..<str.endIndex
        }
        return count
    }
    
    func measureTime(_ operation: () -> Int) {
        let start = DispatchTime.now()
        let result = operation()
        let end = DispatchTime.now()
        
        let nanoseconds = end.uptimeNanoseconds - start.uptimeNanoseconds
        let milliseconds = Double(nanoseconds) / 1_000_000
        
        print("Bran 등장회수: \(result)회")
        print("⏱️ 실행 시간: \(milliseconds)ms")
    }
    
}

