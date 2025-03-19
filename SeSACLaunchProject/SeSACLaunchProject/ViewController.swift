//
//  ViewController.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/19/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var oneImageView: UIImageView!
    @IBOutlet var twoImageView: UIImageView!
    @IBOutlet var threeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. Data
//        ImageNetworkManager.shared.fetchThumbnail { image in
//            self.oneImageView.image = image
//        }
        
        //2. URLSession + GCD
        ImageNetworkManager.shared.fetchThumbnailURLSession { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    self.oneImageView.image = success
                case .failure(_):
                    self.oneImageView.image = UIImage(systemName: "star")
                }
            }
        }
        
        //3. URLSession + Swift Concurrency (async await)
        /**
         1. ViewDidLoad에서 async가 왜 붙어?
            -
         2. Task가 global 스레드라면 ui 바꾸는 부분에서 보라색 오류 나야하는데 왜 안 나?
           - @MainActor 덕분에 알아서 돌아옴!
            @MainActor: Swift Concurrency를 작성한 코드에서 다시 메인스레드로 돌려주는 역할을 수행
         */
        
        //Task == DispatchQueue.global.async 처럼 생각하자.
        Task {
            print("==3==", Thread.isMainThread)
            let result = try await ImageNetworkManager.shared.fetchAsyncAwait()
            print("==4==", Thread.isMainThread)
            oneImageView.image = result
        }
        
        
    }


}



//순차적으로 이미지를 보여주고 싶다면 기존의 방법으로는 아도겐을 써야했다.
//        ImageNetworkManager.shared.fetchThumbnail { image in
//            self.oneImageView.image = image
//
//            ImageNetworkManager.shared.fetchThumbnail { image in
//                self.twoImageView.image = image
//
//                ImageNetworkManager.shared.fetchThumbnail { image in
//                    self.threeImageView.image = image
//                }
//            }
//        }
