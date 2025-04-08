//
//  NetworkTest.swift
//  SeSAC6SampleTests
//
//  Created by 박신영 on 4/7/25.
//

import XCTest
@testable import SeSAC6Sample

final class NetworkTest: XCTestCase {

    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager.shared
        print(#function)
    }

    override func tearDownWithError() throws {
        sut = nil
        print(#function)
    }

    //response lotto bonusNo 1 - 45 해당하면 성공
    //value를 바꿔 응답값이 이상할텐데 왜 아래 테스트케이스가 성공할까?
    //  -> 성공한 적 없음. 비동기라서 해당 응답값이 오기전에 함수가 종료된 것일 뿐
    //UnitTest는 동기에 최적화 되어있다. 비동기 매서드를 절대로 기다리지 않는다.
    //비동기를 기다려줄 수 있는 코드를 우리가 직접 작성을 해야 한다.
    //1) expectation 2) wait 3) fulfill
    func testExample() throws {
        print("111")
        
        // 1) expectation
        let promise = expectation(description: "로또 API CompletionHandler")
        sut.fetchLotto { lotto in
            let value = lotto.bnusNo
//            let value = 100
            XCTAssertLessThanOrEqual(value, 45, "45 이하의 번호가 아닙니다.")
            XCTAssertGreaterThan(value, 1, "1 이상의 번호가 아닙니다.")
            print("fetchLotto")
            // 3) fulfill: 정의해둔 expectation이 충족되는 시점에 호출해서, 비동기 작업을 마무리해도 된다고 알려줌.
            promise.fulfill()
        }
        
        print("222")
        // 2) wait: 비동기 작업이 끝날 때까지 기다리는 기능, 타임아웃 시간을 초과하면 실패로 간주
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
