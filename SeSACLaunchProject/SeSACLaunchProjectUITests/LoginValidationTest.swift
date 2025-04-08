//
//  LoginValidationTest.swift
//  SeSACLaunchProjectTests
//
//  Created by 박신영 on 4/7/25.
//

import XCTest

//왜인지 firebase core import가 필요하다고 표시됩니다요..
//@testable import SeSACLaunchProject

// mvvm vs testable
// test해야하는 기능 대비 너무 많은 것들을 조회해야 하는 아쉬움


//final class LoginValidationTest: XCTestCase {
//
//    //system under test: 이 시스템에서 테스트를 하려는 대상
//    var sut: LoginViewController!
//    
//    //테스트 메서드가 실행되기 직전에 호출
//    override func setUpWithError() throws {
//        //LoginViewController 초기화
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        
//        sut = vc
//        sut.loadViewIfNeeded() // 뷰를 띄워주는 ㅔㅁ서드
//        print(#function)
//    }
//
//    //테스트 메서드가 실행된 직후에 호출
//    //리소스 정리, 상태 초기화 등 다음 테스트에 영향을 주지 않도록 설정
//    override func tearDownWithError() throws {
//        sut = nil
//        print(#function)
//    }
//
//    //id의 조건에 문제가 없는지
//    func testLoginViewController_ValidID_ReturnTrue() throws {
//        print(#function)
//        //Given
//        let value = "jack@jack.com"
//        //When
//        sut.idField.text = value
//        //Then
//        XCTAssertTrue(sut.isValidID(), "@가 없거나 6글자 미만임")
//    }
//    
//    //@가 없으면 실패하는 상황에 대한 테스트.
//    //실패 케이스를 테스트하고 싶음.
//    //테스트 결과는 성공으로 나오도록 해야함
//    //  -> 그렇기에 XCTAssertFalse를 사용함
//    func testLoginViewController_ValidID_ReturnFalse() throws {
//        print(#function)
//        let value = "jackjack.com" //@ 제거
//        sut.idField.text = value
//        
//        XCTAssertFalse(sut.isValidID())
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
//}
