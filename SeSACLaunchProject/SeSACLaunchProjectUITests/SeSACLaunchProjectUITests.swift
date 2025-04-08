//
//  SeSACLaunchProjectUITests.swift
//  SeSACLaunchProjectUITests
//
//  Created by 박신영 on 4/2/25.
//
/// internal = 같은 모듈/타켓 내에서 접근 가능
/// 그래서 test: 다른 모듈/타켓 이라서 import가 필요하다.
/// 1. 타겟을 개별적으로 확장 Target Menbership Tests
/// 2. import [프로젝트 네임]
/*
 1. func 명 Prefix에 test를 추가하면 테스트 관련 함수로 인식
 */

import XCTest

final class SeSACLaunchProjectUITests: XCTestCase {
    
    var number = 3

    //테스트 이전에 다른 조건들이 변경되지 않도록, 테스트 전에 실행되는 메서드.
    override func setUpWithError() throws {
        print(#function)
        number = 3
    }

    //테스트 이후에 다른 조건들이 변경이 생기지 않도록, 테스트 후에 초기화 되는 메서드
    override func tearDownWithError() throws {
        print(#function)
    }
    
    // 테스트는 횟수에 제한 없이 결과가 일관되어야 그로써 사용하는 이유가 있다.
    // 아래 실행순서가 보장되는 이유는 setUpWithError와 tearDownWithError를 사용함으로써 조건들이 항상 일관되도록 보장한다.
    // 테스트의 독립성, 고유성, 일관성 등을 보장
    
    /// 실행 순서
    /// setUpWithError -> testPlus -> tearDownWithError
    func testPlus() throws {
        print(#function)
        
        let a = 2
        let b = 2
        
        number = 4
        
        ///반드시 test 이후 XCTAssert 구문이 추가됨
        ///messaging: 아래 결과가 잘못된 이율유를 반환
//        XCTAssertEqual(a + b, number, "덧셈 결과가 같지 않다.")
            //현재는 덧셈 결과가 달라서 무조건 테스트가 실패하는 케이스
    }
    
    /// setUpWithError -> testMinus -> tearDownWithError
    func testMinus() throws {
        print(#function)
        
        let a = 5
        let b = 2
        
        XCTAssertEqual(a - b, number, "뺄셈 결과가 같지 않다.")
            //현재는 뺄셈 결과가 같아서 무조건 테스트가 성공하는 케이스
    }

    func testExample() throws {
        print(#function)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
