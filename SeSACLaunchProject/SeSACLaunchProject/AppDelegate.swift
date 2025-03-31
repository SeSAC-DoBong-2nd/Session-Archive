//
//  AppDelegate.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/19/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        return true
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

//권한 받기 > [알림 내용, 알림 시기] > 시스템 등록

//UNUserNotificationCenterDelegate: 로컬 알람 때
//생명주기 시점을 활용해서 뱃지 숫자 관리

//사용자 클릭: 알림이 전달됐는 지는 알 수 없음. 사용자가 클릭한 건 알 수 있음.
//특정 화면에서 푸시 안 받기: 포그라운드에서 알림이 안 오는게 디폴트.
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //디바이스 토큰 얻기
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        print("deviceToken:\(deviceTokenString)"
        )
    }
    
}

//첫 빌드 시 디바이스 토큰
//7B094416AFFBD9A0B329E386B4821F143CC243581322E56BDFEB034C1F290602

//삭제 후 재빌드 시 디바이스 토큰
//4854C2EC3E57DA3AC03DE3FB860078D7E7DA67CB19DBD90FB96C8E1C11B13085
