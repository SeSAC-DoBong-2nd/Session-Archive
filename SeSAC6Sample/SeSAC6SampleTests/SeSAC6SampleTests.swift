//
//  SeSAC6SampleTests.swift
//  SeSAC6SampleTests
//
//  Created by 박신영 on 4/7/25.
//

import XCTest
@testable import SeSAC6Sample

final class SeSAC6SampleTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    ///비동기
    ///로또 API. 1~45 테스트
    ///비동기는 서버가 다운되면 테스트 결과가 바뀔 수 있음
    
    //엄청 중요!!!
    ///네트워크 통신시 유의점
    ///네트워크 통신이 잘 되는 상황에 대해서만 일관적인 결과를 얻을 수 있음.
    ///통신 자체가 되지 않는 상황에서는 결과가 달라질 수 있음. 즉, 외부 환경에 영향을 받음.
    ///네트워크 통신과 무관한 상태로 테스트 코드를 작성하는 것이 중요! => MockData, DI, DIP
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
