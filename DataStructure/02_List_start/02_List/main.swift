//
//  main.swift
//  02_List
//
//  Created by Bran on 3/20/25.
//

import Foundation

// MARK: - ArrayList / Capactiy
//checkCapacity()
//checkReserveCapacity()

//var arr =  [1, 2, 3, 4]
//arr.removeAll(keepingCapacity: true)
//arr.removeAll(keepingCapacity: false)
//print(arr.capacity)


// MARK: - Linked List
//var a = LinkedList<String>()
//a.append("Hue")
//a.append("Jack")
//
//print(a)
//
//a.insert("Bran", at: 2)
//print(a)
//
//a.insert("Den", at: 2)
//print(a)
//
//a.removeLast()
//print(a)
//
//a.removeFirst()
//print(a)
//
//print(a.count)


//배열: 두 수의 합
//https://www.acmicpc.net/problem/3273
/*
 9 = N
 5 12 7 10 9 1 2 3 11 = An
 13 = X
 */

/*
i < j (Ai, Aj)
 (12, 1) 12 -> x - 12와 동일한 값이 배열에 존재하니?
 (10, 3) 10 -> x - 10와 동일한 값이 배열에 존재하니?
 (2, 11)
 */

/*
 (ai, aj)
 n = 9
 arr = 5 12 7 10 9 1 2 3 11
 x = 13
 vis: [Bool] = [][v]v]v][]v][][v][][v][v][v][v]
 element in arr {
    if vis[x-element] { answer += 1 }
 }
 */

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }.sorted {$0<$1}
let x = Int(readLine()!)!

var vis: [Bool] = .init(repeating: false, count: 2000000 + 2)
var answer = 0

//vis: [Bool] = [][v]v]v][]v][][v][][v][v][v][v] // N
for element in arr {
    vis[x - element] = true
}

for element in arr {
    
    //element < x: vis[x-element] 했을 시 index의 음수가 나오는 것을 방지하기 위함
    if element < x && vis[x - element] { answer += 1 }
}


//i < j (Ai, Aj)
//(12, 1)
//(10, 3)
//(2, 11)

//위 예시에 arr의 배열을 돌면 12일 때 1를 찾기도 하지만, 1일 때 12를 찾기도 하니 answer은 한 쌍에 2개가 늘어나기에 answer/2 를 진행한 것.
print(answer/2)

/// 내 풀이 = 시간초과
//var minIndex = 0
//var maxIndex = arr.count-1
//var cnt = 0
//
//while minIndex != maxIndex {
//    if arr[minIndex] + arr[maxIndex] == x {
//        cnt += 1
//        minIndex += 1
//        maxIndex -= 1
//    } else {
//        for i in minIndex+1...maxIndex {
//            if arr[minIndex] + arr[i] == x {
//                cnt += 1
//                break
//            }
//        }
//        minIndex += 1
//    }
//}
//
//print(cnt)
//
//



