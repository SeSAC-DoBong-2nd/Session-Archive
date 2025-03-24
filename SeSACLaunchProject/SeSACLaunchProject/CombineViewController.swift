//
//  CombineViewController.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/24/25.
//

/*
 RxSwift vs Combine (애플 프레임워크)
 class - Protocol
 Observable - Publisher
 Observer - Subscriber
 Subscribe - sink
 Disposable - AnyCancellable / Cancellable
 dispose - store
 PublishSubject - PassThroughSubject
 BehaviorSubject - CurrentValueSubject
 
 
 bind, drive, relay  => 에러 생각 X. next 이벤트만 방출. 왜?? => UI에 해당 -> RxCocoa
 Combine : UI Rxcocoa 와 같은게 없음. 즉, UI에 즉각적으로 바인딩할 수 있는 수단이 없다.
 */


import Combine
import UIKit

final class CombineViewModel {
    
    //RxSwift DisposeBag
    var cancellables = Set<AnyCancellable>()
    
    struct Input {
        //Rx PublishSubject
        let viewDidLoadTrigger = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        //Rx BehaviorSubject
        let list = CurrentValueSubject<String, Never>("")
    }
    
    init() {
        let input = Input()
        input.viewDidLoadTrigger
            .sink { [weak self] _ in
                //callRequest
                self?.callRequest()
            }.store(in: &cancellables)
    }
    
    func callRequest() { //Network
        
    }
    
}


final class CombineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
