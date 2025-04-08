//
//  UpgradeValidationTest.swift
//  SeSACLaunchProjectUITests
//
//  Created by 박신영 on 4/7/25.
//

import XCTest

//unittest >> 기능
//검색: 2글자 이상, 공백 등의 조건을 테스트할 때 활용해보자

final class UpgradeValidationTest: XCTestCase {
    
    var sut: Validator!
    let validUser = User(email: "jack@jack.com", password: "1234", check: "1234")
    let invalidUser = User(email: "jack", password: "123456", check: "1234")

    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testValidator_ValidID_ReturnTrue() throws {
        let value = validUser.email
        let valid = sut.isValidEmail(email: value)
        
        XCTAssertTrue(valid)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
