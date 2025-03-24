import Foundation
//Testing ?? Testable ??
//DI, DIP, Testing, Testable, XCTest, SwiftTesting ??!!

protocol NetworkManagerProvider {
    func callRequest()
}

class NetworkManager: NetworkManagerProvider {
    func callRequest() {
        //Alamofire
    }
}

class MockManager: NetworkManagerProvider {
    func callRequest() {
        //가짜 더미데이터 통신
    }
}

//생성 사용 분리
class LottoViewModel {
    
    let manager: NetworkManagerProvider
    
    init(manager: NetworkManagerProvider) {
        self.manager = manager
    }
    
    func transform() {
        manager.callRequest()
    }
    
}

import UIKit

class LottoViewController {
    let viewModel: LottoViewModel
    
    init(viewModel: LottoViewModel) {
        self.viewModel = viewModel
    }
    
    
}

/*
 status 로 분기처리
 - false: mock 데이터
 - true: 실제 통신 데이터
*/

// 현재 네트워크를 상태를 진단하고 해당 진단 결과를 status 변수에 연결 여부를 확인하며 분기처리 한다.
  // 빌드 될 때의 상황을 조금 더 유연하게 대처 가능.
func makeLottoViewController(status: Bool) -> LottoViewController {
    
    let network: NetworkManagerProvider = status ? NetworkManager() : MockManager()
    
    let viewModel = LottoViewModel(manager: network)
    
    return LottoViewController(viewModel: viewModel)
}

let network = NetworkManager()
let mock = MockManager()
//아래 manager에 위 network, mock 둘다 NetworkManagerprovider 프로토콜을 채택하고 있기에 다 들어갈 수 있다.
let viewModel = LottoViewModel(manager: network)
viewModel.transform()

/*
 # 아래 용어 정리하기
 DI, DIP
 Interface
 Concrete Type
 구현체, 추상체
 의존 관계
*/
