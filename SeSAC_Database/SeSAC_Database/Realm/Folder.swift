//
//  Folder.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/5/25.
//

import Foundation

import RealmSwift

class Folder: Object {
    @Persisted var id: ObjectId //고유 id
    @Persisted var name: String //카테고리명
    
    //1:N, to many relationship
    @Persisted var detail: List<JackTable>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
