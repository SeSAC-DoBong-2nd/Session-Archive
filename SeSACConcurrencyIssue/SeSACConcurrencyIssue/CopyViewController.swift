//
//  CopyViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by 박신영 on 5/14/25.
//

//Swift 5.9: Copyable. noncopyable. 제네릭 X
//  Swift 6.0 -> 제네릭도 같이 가능
import UIKit

struct User: ~Copyable {
    let name: String
    let age: Int
    
    // NonCopyable은 복사를 불가능하게 막고, 소유권을 이전하는 개념이기에 하나의 인스턴스만 추적하게 하고 따라서 Deinit 가능
    deinit {
        print("User Deinit", name, age)
    }
    
    consuming func test() {
        print("User Test")
    }
}

// 값 타입을 복사한다는 건 너무 당연한건데. -> 이걸 못하게 막을 수 없나?
//  -> 복사를 하지 못하게 하는 특성 = Noncopyable = ~Copyable
// ~Copyable: 컴파일러에서 값타입 복사를 못하게 막는 기능.
//  따라서 데이터의 무결성을 보장한다.

final class CopyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchUser()
        testConsume()
    }
    
//    func fetchUser() {
//        let user = User(name: "Jack", age: 22)
//        print(user.name)
//        print("1")
//        
//        // 담는건 문제 없는데, 값을 이전해준 이전 프로터티는 사용할 수 못한다.
//        let newUser = user // 소유권 이전 (Swift Onwership)
//        print(newUser.name)
//        // print(user.name) // 소유권이 바뀌어서 이건 안됨.
//        
//        let threeUser = newUser
//        print(threeUser.name)
//        // print(user.name) // 소유권이 바뀌어서 이건 안됨.
//    }
    
    
    // Move-Only Type. noncopyable. consume
    //  = Onwership을 적용한 프로퍼티
    // 복사가 불가능하고, 소유권에 대한 이동만 허용.
    // 데이터 무결성, 고유한 리소스 관리, 성능 최적화 등을 다룰 때에 활용
    
    // ARC: 힙 메모리 정리 가능.
    
    // 명시적으로 값 복사가 가능한 상태인지 아닌지 알 수 있는 방법.
    // ex) class 앞에 final 키워드
    //  -> 'consume': 복사는 안 되지만 소유권을 넘기는 타입 (5.9+ 등장)
    //      위 키워드를 명시하지 않아도 소유권 넘기는 기능은 똑같이 동작하지만, 직관적으로 알 수 있음. like Convention
    func fetchUser() {
        let user = User(name: "Jack", age: 22)
        print(user.name)
        
        let newUser = consume user
        print(newUser.name)
        
        introduce2(user: newUser)
        print(#function, newUser.name, newUser.age)
    }
    
    // User 구조체 자체가 nonCopyable이기에 매개변수로도 사용할 수 없다.
    //  but 'consuming' 키워드를 사용하면 가능하다.
    // consuming: 매개변수가 소유권을 가져감. 기존변수는 유효X
    func introduce(user: consuming User) {
        print("이름은 \(user.name)이고, 나이는 \(user.age)이다.")
        print(#function)
    }
    
    // Read-Only = borrowing
    //  소유권을 넘기지 않고, 값 복사도 없이 단순히 읽고만 싶을 때 사용.
    func introduce2(user: borrowing User) {
        print("이름은 \(user.name)이고, 나이는 \(user.age)이다.")
        print(#function)
        
//        let jack = user : borrowing을 썼기에 소유권이 없어서 다른 프로퍼티에 소유권을 넘겨줄 수 없다.
    }
    
    func testConsume() {
        let user = User(name: "Jack", age: 22)
        print(#function)
        print(user.name)
        print(#function)
        print(user.age)
        print(#function)
        user.test()
        print(#function)
    }
    
    // NSCopying
    // Deep copy (깊은 복사) vs Shallow copy (얕은 복사): 복사본도 영향 받음.
    
    // 값 참조: 강의자료 찾아보기..
    class User1 {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    func testcopy() {
        //배열이 구조체, 안의 원소가 클래스라면 이를 복사할 시 얕은 복사로 동작한다.
        let c = [User1(name: "a")]
        let d = c //얕은? 깊은? = 얕은! 이유는 위에~
        
        let a = User1(name: "Jack")
        print(a.name) //Jack
        
        var b = a //깊은 복사
        b.name = "Bran"
        print(b.name, a.name) //Bran, Jack
        
        //깊은복사: 원본 값과 복사한 값이 서로 독립적 메모리에 존재하는 것
    }
    
    
    //MARK: Copy On Write, COW
    // 수정될 때 복사되는 것
    func test() {
        //NSCopying
        let a = Array(repeating: "ㅁ", count: 1000000)
        var b = a
        //b[0] = 1 //이 때 메모리가 바뀌며 추가되는 느낌
    }
    
}



