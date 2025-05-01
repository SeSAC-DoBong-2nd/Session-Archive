//
//  PostViewController.swift
//  LSLPBasic
//
//  Created by jack on 2024/04/09.
//

import UIKit

import Alamofire

final class PostViewController: BaseViewController {
    
    private let selfView = PostView()
    private let withDrawButton = UIBarButtonItem()
    private let postButton = UIBarButtonItem()
    
    private let viewModel = PostViewModel()

    override func loadView() {
        self.view = selfView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        fetchProfile()
        uploadProfileImage()
    }
    
    override func bind() {
        
    }
    
    private func fetchProfile() {
        let url = Config.baseURL + "/users/me/profile"
        print("url: \(url)")
        
        let headers: HTTPHeaders = [
            "SesacKey" : Config.sesacKey,
            "Content-Type" : "application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!
        ]
        
        AF.request(
            url,
            method: .get,
            headers: headers
        )
        .validate(statusCode: 200..<300)
//        .responseString { response in
//            dump(response)
//        }
        .responseDecodable(of: ProfileModel.self) { response in
            switch response.result {
                
            case .success(let value):
                dump(value)
                self.navigationItem.title = value.nick
            case .failure(let error):
                print("error: \(error)")
                print(response.response?.statusCode ?? "unknown")
                
                if response.response?.statusCode == 419 {
                    //엑세스 통신 갱신 플로우 필요
                    self.accessTokenRefresh {
                        self.fetchProfile()
                    }
                }
            }
        }
    }
    
    private func accessTokenRefresh(completionHandler: @escaping () -> Void) {
        let url = Config.baseURL + "/auth/refresh"
        print("url: \(url)")
        
        let headers: HTTPHeaders = [
            "SesacKey" : Config.sesacKey,
            "Content-Type" : "application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!,
            "Refresh" : UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        
        AF.request(
            url,
            method: .get,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TokenModel.self) { response in
            switch response.result {
                
            case .success(let value):
                print(value)
                UserDefaults.standard.set(value.accessToken, forKey: "accessToken")
                completionHandler()
            case .failure(let error):
                print("error: \(error)")
                print(response.response?.statusCode ?? "unknown")
            }
        }
    }
    
    private func uploadProfileImage() {
        let url = Config.baseURL + "/users/me/profile"
        
        let headers: HTTPHeaders = [
            "SesacKey" : Config.sesacKey,
            "Content-Type" : "application/json",
            "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!
        ]
        
        AF.upload(
            multipartFormData: { multipartFormdata in
                multipartFormdata.append(
                    //여기서 해당 파일이 용량을 넘는지 안넘는지 확인하는게 필요함
                    UIImage(resource: .zoomError).jpegData(compressionQuality: 0.6)!,
                    withName: "profile",
                    fileName: "sesacImage", //서버에서 url 만들 때 png 타입 앞에 붙는 이름
                    mimeType: "image/jpeg"
                )
            },
            to: url,
            method: .put,
            headers: headers)
        .responseString { response in
            dump(response)
        }
    }
    
    private func setNavigation() {
      //  withDrawButton.image = UIImage(systemName: "heart")
        postButton.image = UIImage(systemName: "plus")
       // navigationItem.leftBarButtonItem = withDrawButton
        navigationItem.rightBarButtonItem = postButton
    }
}
