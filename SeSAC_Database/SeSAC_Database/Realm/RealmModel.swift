//
//  RealmModel.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/4/25.
//

import Foundation

import RealmSwift

//Realm Table - to may relationship, to one relationshop, inverse
//정말 동일하다면 reponsemodel과 같이 써도되는데, 그냥 쓰지마.
// -> Table 내 선언되어 있는 모든 칼럼들이 decodable? 가능 (그러나 쓰지마.)
// -> Realm의 특성 중 decodable을 따르지 않는 타입을 사용하게 되면? 불가

final class JackTable: Object {
    //PrimaryKey: 기본키
    //중복 X, nil X
    @Persisted(primaryKey: true) var id: ObjectId //PK
    @Persisted var money: Int //금액
    @Persisted var category: String //카테고리명
    
    @Persisted(indexed: true)var productName: String //상품명
    
    @Persisted var isRevenue: Bool //수입지출여부
    @Persisted var regdate: Date //등록일
    @Persisted var memo: String? //메모
    
    //like는 이미 realm에서 다른 기능으로 쓰이는 네이밍이기에 사용하지 말아야 한다.
    @Persisted var isLike: Bool //좋아요
    
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<Folder>
    
    convenience init(money: Int,
                     category: String,
                     productName: String,
                     isRevenue: Bool,
                     memo: String? = nil)
    {
        self.init() //여기서 id에 realm이 알아서 겹치지 않는 id를 만들어 넣어준다.
        self.money = money
        self.category = category
        self.productName = productName
        self.isRevenue = isRevenue
        self.memo = memo
        self.isLike = false
    }
}
