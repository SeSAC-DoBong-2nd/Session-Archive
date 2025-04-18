//
//  Dictionary.swift
//  06_HashTable
//
//  Created by Bran on 4/14/25.
//

import Foundation

// MARK: - 공간의 비효율성 문제
struct PhoneBook {
  private var phoneBook: [String] = .init(repeating: "", count: 99999999 + 2)

  init() {
    phoneBook[31258728] = "Hue"
    phoneBook[68927321] = "Jack"
    phoneBook[32094412] = "Den"
    phoneBook[89210809] = "Bran"
  }


  func findNumber(_ number: String) -> String? {
    let number = Int(number.dropFirst(3))!
    let name = phoneBook[number]
    return name.isEmpty ? nil : name
  }
}

// MARK: - 공간의 비효율성 문제 해결
struct NewPhoneBook {
  private var phoneBook: [String] = .init(repeating: "", count: 9 + 2)

  init() {
    add("Hue", "01031258728")
    add("Jack", "01068927321")
    add("Den", "01032094412")
    add("Bran", "01089210809")
  }

  mutating func add(_ name: String, _ number: String) {
    let number = Int(String(number.last!))!
    phoneBook[number] = name
  }

  func findNumber(_ number: String) -> String? {
    let number = Int(String(number.last!))!
    let name = phoneBook[number]
    return name.isEmpty ? nil : name
  }
}
