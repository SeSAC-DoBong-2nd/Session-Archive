//
//  Folder.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/5/25.
//

//struct의 경우 Hashable 문제X
//  struct면 아래 코드들을 따르지 않아도 된다.
//  그렇기에 model을 다룰 때에는 struct를 사용하는 것
//class의 경우 Equatable을 따르지 않고 있기에, Hashable을 사용불가
//  +@ Hashable, Equatable 두 개를 채택한다 하더라도 추가적인 hash 함수와 == 함수를 사용하지 않으면 사용 불가
//class User: Hashable, Equatable {
//    
//    let id = UUID()
//    let name: String
//    let age: Int
//    
//    //Hashable 요구 함수
//    func hash(into hasher: inout Hasher) {
//        <#code#>
//    }
//    
//    //Equatable 요구 함수
//    static func == (lhs: User, rhs: User) -> Bool {
//        lhs.id == rhs.id
//    }
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}


import Foundation

import RealmSwift

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
}

class Folder: Object {
    @Persisted var id: ObjectId //고유 id
    @Persisted var name: String //카테고리명
    @Persisted var favorite: Bool
    @Persisted var nameDescription: String
    
    //1:1, to one Relationship: Optional
    @Persisted var memo: Memo? //임베디드를 해도, 안해도 되기에 늘상 옵셔널로 지정
    
    //1:N, to many relationship
    @Persisted var detail: List<JackTable>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
