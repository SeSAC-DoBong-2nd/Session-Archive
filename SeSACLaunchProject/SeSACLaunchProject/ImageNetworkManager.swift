//
//  ImageNetworkManager.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/19/25.
//

import UIKit

/*
  GCD vs Swift Concurrency
  - completion handler
  - 비동기를 동기처럼
  
  - Thread Explosion
  - Context Switching
  -> 코어의 수와 쓰레드의 수를 같게
  -> 같은 쓰레드 내에서 Continuation 전환 형식으로 방식을 변경
  
  - async throws / try await : 비동기를 동기처럼
  - Task : 비동기 함수와 동기 함수를 연결 (== DispatchQueue.global.async 와 같은 환경을 만들어 주는 친구)
  - async let. taskGroup :  (ex. dispatchGroup)
*/

enum JackError: Error {
    case invalidResponse
    case unknown
    case invalidImage
}

class ImageNetworkManager {
    
    static let shared = ImageNetworkManager()
    
    private init() {}
    
    static let url = URL(string: "https://picsum.photos/200/300")!
    
    func fetchThumbnail(completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: ImageNetworkManager.url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
    func fetchThumbnailURLSession(completion: @escaping (Result<UIImage, JackError>) -> Void) {
        
        let request = URLRequest(url: ImageNetworkManager.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data else {
                completion(.failure(.unknown))
                return
            }
            
            guard error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.invalidImage))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
    
    
    //3. Swift Concurrency
    func fetchAsyncAwait1() async throws -> UIImage { //반환 값으로 받아오는 데이터는 오로지 성공의 데이터만 받음, 에러인 경우에는 throws를 던짐으로써 해결
        
        let request = URLRequest(url: ImageNetworkManager.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        print("===1===", Thread.isMainThread)
        //async: data~~ 함수는 비동기로 동작할 함수입니다. 라는 뜻
        //즉 GCD에 글로벌, async랑 같음 (DispatchQueue.global.async)
        //await: 비동기 함수가 동작할 예정이니, 응답이 올 때 까지 이 코드에서 기다리세요.
        let (data, response) = try await URLSession.shared.data(for: request)
        //async와 await을 사용함으로써 URLSession data의 통신이 끝나서 data와 response에 값이 대입되기 전까지는 78번 line에서 await으로 기다린다는 뜻.
        
        print("===2===", Thread.isMainThread)
        //에러를 throw로 던져주고있기에, 위 try 역시 함께 사용함
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw JackError.invalidResponse
        }
        guard let image = UIImage(data: data) else {
            throw JackError.invalidImage
        }
        
        return image
    }
    
    //3. URLSession + Swift Concurrency
    //async = 내가 비동기 코드를 가지고 있음을 명시. 이는 코드를 바로 끝내지 않고, 비동기의 답변이 올 때 까지 기다림.
    func fetchAsyncAwait() async throws -> UIImage {
        let request = URLRequest(url: ImageNetworkManager.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        //상단에 throws를 선언하였기에 do try catch를 통해 throws를 던진 것처럼 아래 try가 사용된 것
        //즉, throws 와 try는 concurrency와 연관이 없다. (throws - try)
        //해당 await 파트에서 답변이 오기까지 기다리니, 잠재적으로 중단이 생긴 것.
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw JackError.invalidResponse
        }
        guard let image = UIImage(data: data) else {
            throw JackError.invalidImage
        }
        
        return image
    }
    
    
    func fetchAsyncLet() async throws -> [UIImage] {
        //async let: 상수인 let에 값이 담기는 과정이 비동기로 동작해도 된다.
        //
        async let one = ImageNetworkManager.shared.fetchAsyncAwait()
        async let two = ImageNetworkManager.shared.fetchAsyncAwait()
        async let three = ImageNetworkManager.shared.fetchAsyncAwait()
        
        //return할 값들이 다 모일 때 까지 대기 (await)
        return try await [one, two, three] //async let (DispatchGroup enter leave)
    }
    
    //DispatchGroup.. 그룹 안에 통신 수가 정해져 있지 않을 때. (= 통신 수가 동적 개수일 때)
    func fetchTaskGroup() async throws -> [UIImage] {

        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            for item in 0..<10 {
                group.addTask {
                    try await self.fetchAsyncAwait()
                }
            }
            
            var resultImages: [UIImage] = []
            
            for try await item in group {
                resultImages.append(item)
            }
            
            return resultImages
        }
        
    }
}
