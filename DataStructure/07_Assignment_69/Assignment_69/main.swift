//
//  main.swift
//  Assignment_69
//
//  Created by Bran on 4/20/25.
//



//boj_1475()
//boj_4396()
//boj_9375()
//boj_1244()
//boj_19941()

/**
 문제
 - 키순서 번호 부여 오름차순
 - 항상 20명, 중복x
 
 조건
 - 자기 앞에 자기보다 키큰 이가 없다면 그냥 그 자리에 서고 차례 끝
 - 자기 앞에 자기보다 키가 큰 이가 한 명 이상 있다면 그 중 뒤에서 가장 가까운 곳에 있는 학생 앞에 선다.

 
 
 */
func boj_10431() {
    let P = Int(readLine()!)!
    var textNum = 1
    
    for _ in 0..<P {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let studentNum = Array(input.dropFirst())
        var count = 0
        
        for (index, num) in studentNum.enumerated() {
//            print("index: \(index), studentNum: \(studentNum)")
            if index >= 1 {
                let maxPrevious = studentNum[0...index-1].max()!
                print("maxPrevious: \(maxPrevious)")
                if maxPrevious > num {
                    for i in stride(from: index - 1, through: 0, by: -1) {
                        if studentNum[i] > num {
                            count += 1
                        }
                    }
                }
            }
        }
        
        print("\(textNum) \(count)")
        textNum += 1
    }
}

//boj_10431()


import Foundation

func go() {
    let P = Int(readLine()!)!
    let textNum = 1
    for _ in 0..<P {
        var studentNum = Array(readLine()!.split(separator: " ").map { Int($0)! }.dropFirst())
        var count = 0
        
        for (index, num) in studentNum.enumerated() {
            
            if index >= 1  {
                let maxNum = (studentNum[0]...studentNum[index-1]).max()!
                if maxNum > num {
                    print("maxNum: \(maxNum)")
                    for i in stride(from: index-1, to: 0, by: -1) {
                        if i > num {
                            studentNum.insert(num, at: i-1)
                            count += 1
                        }
                    }
                }
            }
        }
        
        
        print("\(textNum) \(count)")
        
    }
}

go()



func boj_10431_Bran() {
    var tc = Array(readLine()!.split(separator: " ").map { Int($0)! }.dropFirst())
    var answer = ""
    var count = 0
    for i in 1..<20 {
        for j in stride(from: i, to: 0, by: -1) {
            if tc[j-1] > tc[j] {
                tc.swapAt(j-1, j)
                count += 1
            } else {
                break
            }
        }
        answer += "\(count)"
    }
}
