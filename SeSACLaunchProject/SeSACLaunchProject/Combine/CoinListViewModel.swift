//
//  CoinListViewModel.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/26/25.
//

import Combine
import Foundation

//RxSwift -> Rxcocoa있어서, Error를 방출하지 않는 Relay, bind, drive 같은 에러가 없는 경우를 다룰 수 있지만 combine은 해당사항이 없기에 옵저버블과 같은 퍼블리셔 선언 시 에러타입을 함께 다뤄야 한다.

//반환 타입 복잡. 로직이 변경되면 반환 타입도 변경
//구체적으로 명시해야하는 Publisher
//어떤 타입인지는 알아. 근데 다 쓰기 귀찮아.
// -> Swift 5.1 Type Eraser: ex)some, any, AnyView, AnyPublisher..
//이는 역제네릭 타입!


//제네릭: 선언할 당시에는 타입이 뭐가 들어올 지 모름. 실제로 실행할 때 어떤 타입인 지 알 수 있음.
func a<T: Numeric>(b: T) {
    print(b)
}

//Type Eraser. Reverse Generic. Opaque Type: 선언할 당시에는 탕비이 뭐가 들어올지 안다. 근데 안 보이게 숨기는 것.
func test() -> AnyPublisher<String, Never> {
    return Just("Jack").eraseToAnyPublisher()
}



final class CoinListViewModel {
    
    private let marketService: UpbitMarketService
    
    //Observable - Publisher(pr) - AnyPublisher(struct)
    struct Input {
        let viewOnTask: AnyPublisher<Void, Never>
    }
    
    struct Outnput {
        let markets: AnyPublisher<Markets, Never>
        let error: AnyPublisher<String?, Never>
        let isLoading: AnyPublisher<Bool, Never>
    }
    
    init(marketService: UpbitMarketService) {
        self.marketService = marketService
    }
    
    
    func transform(input: Input) -> Outnput {
        let loadingSubject = CurrentValueSubject<Bool, Never>(false)
        let errorSubject = CurrentValueSubject<String?, Never>(nil)
        
        let marketPublisher = input.viewOnTask
        // Observer 어떻게 처리할지
            .handleEvents(receiveSubscription: { _ in
                // onNext
                loadingSubject.send(true)
            })
        // Combine에는 with: self나 withUnretain 같은게 없다. 일일이 weak self 써야함
            .flatMap { [weak self] _ -> AnyPublisher<Markets, Never> in
                guard let self = self else {
                    return Empty().eraseToAnyPublisher()
                }
                
                return self.marketService.fetchMarkets()
                    .handleEvents(
                        receiveCompletion: { completion in
                            loadingSubject.send(false)
                            
                            if case .failure(let error) = completion {
                                errorSubject.send(error.localizedDescription)
                            }
                        }
                    )
                    .catch { _ -> AnyPublisher<Markets, Never> in
                        return Just([]).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        
        
        //이벤트를 받으면 로딩을 띄워주는 기능 (false > true)
        //네트워크 통신으로 성공하면 market 정보 담기.
        //에러가 발생했다면 error에 문자열 보내기.
        //최종으로 마무리되면 로딩을 다시 false로
        
        return Outnput(
            markets: marketPublisher,
            error: errorSubject.eraseToAnyPublisher(),
            isLoading: loadingSubject.eraseToAnyPublisher()
        )
    }
    
}
