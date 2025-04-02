//
//  OrderBookViewController.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/26/25.
//

import UIKit

final class WebSocketManager {
    
    static let shared = WebSocketManager()
    
    private var webSocket: URLSessionWebSocketTask?
    
    private init() {}
    
    
    func connect() {
        guard let url = URL(string: "wss://api.upbit.com/websocket/v1") else {
            return
        }
        let session = URLSession(configuration: .default)
        webSocket = session.webSocketTask(with: url)
        
        //터널 연결
        webSocket?.resume()
        
        receiveMessage()
    }
    
    //소켓 터널을 만든 이후 뭘 해야할지 명시
    func send() {
        webSocket?.send(.string("[{\"ticket\":\"test\"},{\"type\":\"orderbook\",\"codes\":[\"KRW-BTC\"]}]"), completionHandler: { error in
            if let error {
                print("Send Error", error)
            }
            print(#function)
        })
    }
    
    func receiveMessage() {
        webSocket?.receive(completionHandler: { result in
//            print("psy",result)
            
            switch result {
            case .success(let success):
                switch success {
                case .data(let value):
//                    print("Data Result: \(value)")
                    print("")
                case .string(let value):
//                    print("String Result: \(value)")
                    print("")
                @unknown default:
                    print("")
                }
            case .failure(let failure):
                print(failure)
            }
            
            self.receiveMessage()
        })
    }
    
    func disconnect() {
        //터널 해제
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
    }
    
}

final class OrderBookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        WebSocketManager.shared.connect()
        WebSocketManager.shared.send()
    }
    
}
