//
//  AppDelegate.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/19/25.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        //메세지 대리자 설정
        Messaging.messaging().delegate = self
        
        //현재 토큰 정보 가져오기 (보통 appdelegate가 아닌 다른 파일들에서 쓰임)
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
        
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

extension AppDelegate: MessagingDelegate {
    
    //APNs Token 과 FCM 토큰은 서로 다른 것
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
}


//권한 받기 > [알림 내용, 알림 시기] > 시스템 등록

//UNUserNotificationCenterDelegate: 로컬 알람 때
//생명주기 시점을 활용해서 뱃지 숫자 관리

//사용자 클릭: 알림이 전달됐는 지는 알 수 없음. 사용자가 클릭한 건 알 수 있음.
//특정 화면에서 푸시 안 받기: 포그라운드에서 알림이 안 오는게 디폴트.
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //포그라운드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification)
        print(notification.request.content.title)
        print(notification.request.content.userInfo)
        
        ///1. 무조건 특정 화면에서는 푸시가 안 뜨도록 topVC 관리
        ///2. 톡방에 있는 상대방의 알람은 안 뜨도록
        guard let user = notification.request.content.userInfo["user"] as? String else { return }
        //user 비교해서 같은 유저라면 아래 handler 실행없이 return으로 탈출..
        
        completionHandler([.list, .banner, .badge, .sound])
    }
    
    //푸시 클릭 시
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification)
        print(response.notification.request.content.title)
        print(response.notification.request.content.userInfo)
        
        //광고 여부로 핸들링
        guard let ad = response.notification.request.content.userInfo["ad"] as? Bool else { return }
        
        if ad {
            //광고 페이지로 이동
        } else {
            //일반 페이지로 이동
        }
        
        //content에 들어있는 user 확인
        guard let user = response.notification.request.content.userInfo["user"] as? String else { return }
    }
    
    //디바이스 토큰 얻기
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        print("애플 APNs 디바이스 토큰:\(deviceTokenString)")
        
        //애플 디바이스 토큰을 파이어베이스로 보내기
        Messaging.messaging().apnsToken = deviceToken
    }
    
}

//첫 빌드 시 디바이스 토큰
//7B094416AFFBD9A0B329E386B4821F143CC243581322E56BDFEB034C1F290602

//삭제 후 재빌드 시 디바이스 토큰
//4854C2EC3E57DA3AC03DE3FB860078D7E7DA67CB19DBD90FB96C8E1C11B13085
