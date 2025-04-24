//
//  BOJ11399.swift
//  Assignment_69
//
//  Created by Bran on 4/22/25.
//

import Foundation

/// [ATM] https://www.acmicpc.net/problem/11399
/*
 문제
 - n명의 줄, i번 사람이 돈 인출 하는데 걸리는 시간 pi분.
 - 즉, i번 사람이 총합으로 돈 인출하려면 p0~pi까지 다 합해야함
 
 풀이
 - sort 오름차순 정렬 및 재귀합으로 해결
 */

func boj_11399() {
    let _ = readLine()!
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    
    
}
