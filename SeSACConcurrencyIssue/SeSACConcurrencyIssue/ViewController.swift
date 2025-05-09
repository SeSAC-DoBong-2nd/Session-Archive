//
//  ViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by 김도형 on 5/7/25.
//

import UIKit

/// nickname에 다른 쓰레드가 접근하면 안되게 설정되어 있어야 한다.
/// -> nickname을 특정 쓰레드가 보유하고 있는 상태에서, 다른 age에 접근하려고 대기하는 상태가 있어야 한다
/// 강제로 뺏을 수 는 없다.
/// 도르마무

/// Mutax (NSLock)
/// Semaphore
/// 직렬로 해결
//class ViewController: UIViewController {
//    /// 공유자원
//    /// 동시에는 접근 못하게 만들자 Critical Section => 상호 배제
//    /// => 1. Mutax => GCD NSLock
//    /// => 2. Semaphore => GCD DispatchSemaphore
//    var nickname = "고래밥"
//    
////    private let lock = NSLock()
//    /// 세마포어 생성: 한번에 하나의 스레드만 접근 허용
//    private let semaphore = DispatchSemaphore(value: 1)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        print("1: \(nickname)")
//        
//        DispatchQueue.global().async {
//            self.semaphore.wait() /// 세마포어를 통한 자원 접근 요청 (대기)
//            self.nickname = "칙촉"
//            print("닉네임이 칙촉으로 변경됨")
//            self.semaphore.signal() /// 세마포어에 시그널 보내기 (작업완료)
//        }
//        
//        DispatchQueue.global().async {
//            self.semaphore.wait()
//            self.nickname = "카스타드"
//            print("닉네임이 카스타드로 변경됨")
//            self.semaphore.signal()
//        }
//        
//        DispatchQueue.global().async {
//            /// 두 작업이 완료될 때까지 대기
//            Thread.sleep(forTimeInterval: 0.5)
//            
//            DispatchQueue.main.async {
//                print("최종 닉네임이 \(self.nickname)입니다.")
//            }
//        }
//    }
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        
////        print("1: \(nickname)")
////        
////        DispatchQueue.global().async {
////            self.lock.lock()
////            self.nickname = "칙촉"
////            print("닉네임이 칙촉으로 변경됨")
////            self.lock.unlock()
////        }
////        
////        DispatchQueue.global().async {
////            self.lock.lock()
////            self.nickname = "카스타드"
////            print("닉네임이 카스타드로 변경됨")
////            self.lock.unlock()
////        }
////        
////        DispatchQueue.global().async {
////            /// 두 작업이 완료될 때까지 대기
////            Thread.sleep(forTimeInterval: 0.5)
////            
////            DispatchQueue.main.async {
////                print("최종 닉네임이 \(self.nickname)입니다.")
////            }
////        }
////    }
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        
////        print("1: \(nickname)")
////        
////        DispatchQueue.global().async {
////            self.nickname = "칙촉"
////        }
////        
////        DispatchQueue.global().async {
////            self.nickname = "카스타드"
////        }
////        
////        print("2: \(nickname)")
////        
////        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
////            print("3: \(self.nickname)")
////        }
////    }
//}

