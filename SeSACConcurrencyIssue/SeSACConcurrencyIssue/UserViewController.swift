//
//  UserViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by 김도형 on 5/7/25.
//

import UIKit

/// 싱글톤 Thread-safe 하지 않다
/// 결국 싱글톤 패턴은 모든 곳에서 접근할 수 있기에 문제 발생
/// => 한 번 접근할 때 하나의 쓰레드에서만 접근할 수 있게 만들어준 특징
actor UserManager {
    static let shared = UserManager()
    
    private init() { }
    
    private var user: [String: Int] = [:]
    
    func addUser(_ name: String) {
        user[name] = Int.random(in: 1...100)
    }
    
    func editUser(_ name: String) {
        guard user[name] == nil else { return }
        
        user[name] = Int.random(in: 1...100)
        print(user[name])
    }
    
    func readUser() -> [String: Int] {
        return user
    }
}

//class UserViewController: UIViewController {
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        UserManager.shared.addUser("Jack")
//        
//        UserManager.shared.addUser("Bran")
//        
//        DispatchQueue.global().async {
//            UserManager.shared.editUser("Jack")
//        }
//        
//        DispatchQueue.global().async {
//            UserManager.shared.editUser("Jack")
//        }
//        
//        DispatchQueue.global().async {
//            UserManager.shared.editUser("Jack")
//        }
//        
//        print(UserManager.shared.readUser())
//    }
//}
