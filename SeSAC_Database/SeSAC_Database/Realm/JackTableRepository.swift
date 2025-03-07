//
//  JackTableRepository.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/5/25.
//

import Foundation

import RealmSwift

protocol JackRepository {
    func getFileURL()
    func fetchAll() -> Results<JackTable>
    func createItem()
    func deleteItem(data: JackTable)
    func updateItem(data: JackTable)
    func createItemInFolder(folder: Folder, data: JackTable)
}

// Realm CRUD
final class JackTableRepository: JackRepository {
    //TMI... get, fetch, request 각 키워드는 어떨 때 쓸까? 궁금하면 찾아보기
   
    //realm에 접근
    private let realm = try! Realm() //default.realm
    
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    func fetchAll() -> Results<JackTable> {
        return realm.objects(JackTable.self)
//            .where {$0.productName.contains("sesac", options: .caseInsensitive)}
            .sorted(byKeyPath: "money", ascending: false)
    }
    
    func createItem() { //Folder 테이블과 상관없이 JackTable에 레코드 바로 추가
        //Create
        do {
            try realm.write {
                let data = JackTable(
                    money: Int.random(in: 1000...100000),
                    category: ["생활비", "카페", "식비"].randomElement()!,
                    productName: ["린스", "커피", "과자", "칼국수"].randomElement()!,
                    isRevenue: false,
                    memo: nil
                )
                
                realm.add(data)
                print("realm 저장 성공한 경우")
            }
        } catch {
            print("realm 저장이 실패한 경우")
        }
    }
    
    func createItemInFolder(folder: Folder, data: JackTable) { //Folder 테이블과 상관없이 JackTable에 레코드 바로 추가
        //Create
        do {
            try realm.write {
                
                
                //어떤 폴더에 넣어줄 지
//                let folder = realm.objects(Folder.self).where {
//                    $0.name == "개인"
//                }.first!
                
                
                //realm에 직접적으로 add하는게 아닌, 또 다른 List 타입 레코드 속에 추가
                folder.detail.append(data)
//                realm.add(data)
                print("realm 저장 성공한 경우")
            }
        } catch {
            print("realm 저장이 실패한 경우")
        }
    }
    
    //삭제
    func deleteItem(data: JackTable) {
        do {
            //Realm의 CRUD와 같은 작업들은 write 트랜젝션이 보장돼야 하기에 그 안에 위치해야한다.
            try realm.write {
                
                //삭제
                realm.delete(data)
                print("realm 데이터 삭제 성공")
            }
        } catch {
            print("realm 데이터 삭제 실패")
        }
    }
    
    //수정
    func updateItem(data: JackTable) {
        do {
            try realm.write {
                realm.create(JackTable.self, value: ["id": data.id, "money": 1000000000, "productName": "케케몬"], update: .modified)
            }
        } catch {
            print("realm 데이터 삭제 실패")
        }
    }
    
}
