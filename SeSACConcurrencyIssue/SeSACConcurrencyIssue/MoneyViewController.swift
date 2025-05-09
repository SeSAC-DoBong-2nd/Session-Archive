//
//  MoneyViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by 박신영 on 5/9/25.
//

import UIKit

/**
 class를 actor로 변경: money에 여러 쓰레드가 동시에 접근하지 않게 됩니다.
    = 자동으로 격리가 되어있다.
 
 actor 안에 메서드를 정의하면 자동으로 async가 붙은 상태로 동작
    = actor 내 메서드는 다 비동기로 이루어지는 형태. async await
 */


///Sendable: 타입이 스레드 간에 안전하게 전달될 걸 보장해주는 프로토콜
final class Info: Sendable {
    let name: String
    let date: Date
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}

//actor = Isolated
//  = actor -> Actor -> Sendable 각 순서대로 프로토콜을 채택 중이기에.
actor Bank {
    private var money: Double
    private var info: Info
    
    init(money: Double, info: Info) {
        self.money = money
        self.info = info
    }
    
    //입금
    func deposit(amount: Double, info: Info) -> Bool {
        money += amount
        self.info = info
        return true
    }
    
    //출금
    func withdraw(amount: Double, info: Info) -> Bool {
        if money >= amount {
            money -= amount
            self.info = info
            return true
        }
        return false
    }
    
    //잔액 조회
    func getMoney(info: Info) -> Double {
        print(info)
        return money
    }
    
}

/**
 Data Race 방지 + 동시성 관련 오류를 컴파일 시점에 미리 확인 => actor
 => 컴파일 시점에 동시성 이슈를 확인할 수 있다.
 => 여러 쓰레드에서 접근하지 못하게 코드로 미리 사전 방지
 => 구조화된 동시성
 
 
 Thread Check가 켜져있다면 "런타임" 시점에만 확인이 가능.
 */

final class MoneyViewController: UIViewController {
    
    func sample() async {
        
    }
    
    //Task로 감싸는 ver
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        Task {
//            await sample()
//        }
//        
//        let account = Bank(money: 10000)
//        
//        for item in 1...100 {
//            Task {
//                if await account.withdraw(amount: 100) {
//                    print("\(item)번째 출금 완료")
//                }
//            }
//            
//            Task {
//                if await account.deposit(amount: 100) {
//                    print("\(item)번째 입금 완료")
//                }
//            }
//        }
//        
//        Task {
//            let final = await account.getMoney()
//            print("총 금액: \(final)")
//        }
//        
//    }
    
    //async로 감싸는 ver
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await checkAccount()
        }
    }
    
    
    func checkAccount() async {
        let info = Info(name: "Jack", date: Date())
        let account = Bank(money: 10000, info: info)
        
        await withTaskGroup(of: Void.self) { group in
            for item in 1...100 {
                group.addTask {
                    if await account.withdraw(amount: 100, info: info) {
                        print("\(item)번째 출금 완료")
                    }
                }
                
                group.addTask {
                    if await account.deposit(amount: 100, info: info) {
                        print("\(item)번째 입금 완료")
                    }
                }
            }
            
            let final = await account.getMoney(info: info)
            print("총 금액: \(final)")
        }
    }
    
}
