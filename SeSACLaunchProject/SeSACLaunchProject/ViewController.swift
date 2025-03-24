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
    var nickname = "고래밥"
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
        
        //Task
            //동기 함수와 비동기 함수를 연결해주는 Task (== DispatchQueue.global.async 처럼 생각하자.)
            //비동기 코드의 응답을 어느정도 기다리다 이후 코드를 진행하도록 설정.
            //모든 것들을 비동기 코드로 동작시킬 수 없기에 Task를 사용. 즉, viewDidLoad에 async를 붙이는 걸 방지하기 위해 Task를 사용.
            //Task 안의 코드 순서는 result의 응답값이 오고 oneImageView의 image를 바꿔주는 순서가 보장된다.
        
        //질문: Task가 비동기 코드의 응답을 어느정도 기다리다 이후 코드를 진행하도록 설정해준다고 이해를 하였는데, 이해한 바가 맞다면 해당 비동기 코드가 끝까지 응답이 없다면 어느 시점을 기준으로 비동기 코드를 무시하고 진행하나요??
        //답변: 현재는 fetchAsyncAwait 함수 속 timeoutInterval로 시간에 제약을 주고 있기에 해당 부분이 기준이 됨.
        
//        Task { //Task 속에는 동기 코드처럼 동작
//            let one = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            oneImageView.image = one
//        }
//        
//        Task {
//            let two = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            twoImageView.image = two
//        }
//        
//        Task {
//            let three = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            threeImageView.image = three
//        }
        
        
        //4. 여러 비동기를 동시에 실행해줄 수 없을지? (= async let)
//        Task {
//            let result = try await ImageNetworkManager.shared.fetchAsyncLet()
//            oneImageView.image = result[0]
//            twoImageView.image = result[1]
//            threeImageView.image = result[2]
//        }
        
        //5. 여러 비동기를 동시에 실행해줄 수. ㅓㅂㅅ을지 ? 동적으로 당ㄹ라지는 경우 (TaskGroup)
        Task {
            let result = try await ImageNetworkManager.shared.fetchTaskGroup()
            oneImageView.image = result[0]
            twoImageView.image = result[1]
            threeImageView.image = result[2]
        }
        
        
        
        DispatchQueue.global().async {
            self.nickname = "호돌이"
        }
        
        DispatchQueue.global().async {
            self.nickname = "뚱이"
        }
        
        DispatchQueue.global().async {
            self.nickname = "시니"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        print(nickname)
    }


}



//기존 GCD로는 순차적으로 이미지를 보여주고 싶다면 기존의 방법으로는 아도겐을 써야했다.
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
