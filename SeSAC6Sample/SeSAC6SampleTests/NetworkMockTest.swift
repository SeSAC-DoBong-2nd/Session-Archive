//
//  NetworkMockTest.swift
//  SeSAC6SampleTests
//
//  Created by 박신영 on 4/7/25.
//

import XCTest

@testable import SeSAC6Sample

final class NetworkMockTest: XCTestCase {
    
    var sut: NetworkProvider!

    override func setUpWithError() throws {
        //sut = Lotto mockdata를 갖고 있는 클래스
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //mockdata를 잘 구성해야 한다.
    //-> 테스트의 일관성을 위해서 외부 환경에 영향을 안 받도록 mockdata
    //
    func testExample() throws {
        sut.fetchLotto { <#Lotto#> in
            <#code#>
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
