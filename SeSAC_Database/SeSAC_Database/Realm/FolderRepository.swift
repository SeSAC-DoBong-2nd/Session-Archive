//
//  FolderRepository.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/5/25.
//

import Foundation

import RealmSwift

protocol FolderRepository {
    func createItem(name: String)
    func fetchAll() -> Results<Folder>
    func deleteItem(data: Folder)
    func createMemo(data: Folder)
}

final class FolderTableRepository: FolderRepository {
    
    private let realm = try! Realm()
    
    func createMemo(data: Folder) {
        let memo = Memo()
        memo.content = "폴더 메모를 작성해주세요"
        memo.regDate = Date()
        memo.editDate = Date()
        
        do {
            try realm.write {
                data.memo = memo
            }
        } catch {
            print("메모 추가 실패")
        }
    }
    
    //폴더 삭제 시 세부 항목도 지울 것인지? (세부항목을 지우면 부모에도 반영이 되지만 그 역은 자동으로 반영되지않음.)
        //그렇기에 세부 항목을 먼저 지우고, 이를 담고있는 폴더도 지워야함
    func deleteItem(data: Folder) {
        do {
            try realm.write {
                realm.delete(data.detail) //세부항목을 우선적으로 지우기
                realm.delete(data)
            }
        } catch {
            print("폴더 삭제 실패")
        }
    }
    
    func createItem(name: String) {
        do {
            try realm.write {
                let folder = Folder(name: name)
                realm.add(folder)
            }
        } catch {
            
        }
    }
    
    func fetchAll() -> Results<Folder> {
        return realm.objects(Folder.self)
    }
    
}
