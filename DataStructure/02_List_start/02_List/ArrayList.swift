//
//  ArrayList.swift
//  02_List
//
//  Created by Bran on 3/21/25.
//

import Foundation

func checkCapacity() {
  var 손님 = [13, 22] //capacity = 2
  for _ in 1...8 {
    손님.withUnsafeBytes {
      print("[Address]:", $0.baseAddress!)
    }
    print("[Capacity]:", 손님.capacity)
    print("[Value]:", 손님)
    print("")

    손님.append(.random(in: -100...100))
  }
}

func checkReserveCapacity() {
  let 손님1 = [1, 2] // 2
  var 손님2 = [1, 2] // 2
  손님2.reserveCapacity(100) // 100

  print(손님1.capacity)
  print(손님2.capacity)
}



