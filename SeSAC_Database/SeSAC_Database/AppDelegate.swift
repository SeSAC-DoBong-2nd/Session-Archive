//
//  AppDelegate.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/4/25.
//

import UIKit

import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        migration()
        
        //현재 사용자가 쓰고 있는 DB의 Schema Version 체크
        let realm = try! Realm()
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print(version, "@")
        } catch {
            print("Schema Failed")
        }
        
        return true
    }
    
    //schemaVersion을 0부터 차근차근 업데이트 해야하기에 무조건 'if 문'만 사용한다
    func migration() {
        let config = Realm.Configuration(schemaVersion: 6) {
            migration, oldSchemaVersion in
            
            //단순히 테이블, 컬럼 추가 삭제에는 if문 속 코드가 필요 x
            
            //schemaVersion 0 -> 1: Folder에 like가 추가
            if oldSchemaVersion < 1 {
            }
            
            //schemaVersion 1 -> 2: Folder에 like가 제거
            if oldSchemaVersion < 2 {
            }
            
            //schemaVersion 2 -> 3: Folder에 like가 추가 + true
            if oldSchemaVersion < 3 {
                migration.enumerateObjects(ofType: Folder.className()) { oldObject, newObject in
                    guard let newObject else { return }
                    
                    newObject["like"] = true
                }
            }
            
            //schemaVersion 3 -> 4: Folder에 like calumn 이름 favorite으로 수정
            if oldSchemaVersion < 4 {
                migration.renameProperty(onType: Folder.className(), from: "like", to: "favorite")
            }
            
            //schemaVersion 4 -> 5: Folder에 nameDescription 추가
            //Folder name 필드 활용해서 값 넣어줄 예정
            if oldSchemaVersion < 5 {
                migration.enumerateObjects(ofType: Folder.className()) { oldObject, newObject in
                    guard let oldObject,
                          let newObject else { return }
                    
                    newObject["nameDescription"] = "\(oldObject["name"] ?? "")의 폴더입니다"
                }
            }
            
            //schemaVersion 5 -> 6: Folder에 'memo' 라는 EmbeddedObject 생성
            if oldSchemaVersion < 6 {
            }
        }
        Realm.Configuration.defaultConfiguration = config
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

