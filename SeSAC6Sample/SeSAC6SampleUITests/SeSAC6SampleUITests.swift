//
//  SeSAC6SampleUITests.swift
//  SeSAC6SampleUITests
//
//  Created by 박신영 on 4/7/25.
//

import XCTest

final class SeSAC6SampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJack() throws {
        //1. 다이아몬드
        //2. 첫 화면을 로그인 화면으로 설정돼있는지 확인
        
        /// UITest는 기능과 상관 없음 == swift X
        /// TextField Button 같은 뷰객체의 프로퍼티 이름도 모름
            /// 그렇다면 유저가 선택한 텍스트 필드가 무엇인지는 어떻게 알 수 있을까?
            /// ObjectID, Placeholder
            /// 단순히 텍스트 정도로 판별
            /// => 같은 글자가 여러개라면 어떻게 되나?! 못 찾는다. 런타임 에러 발생
            /// => UITest + 접근성(accessbility)
                /// 즉 accessibilityIdentifier를 활용하여 해당 프로퍼티의 접근성identifier를 규정하고 해당 identifier로 호출
        
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["id_field"].tap()
        app.textFields["id_field"].typeText("hello")
        
        app.textFields["pw_field"].tap()
        app.textFields["pw_field"].typeText("123456")
        
        app.textFields["check_field"].tap()
        app.textFields["check_field"].typeText("123456")
        
        app.buttons["done_button"].tap()
        
        //테스트 성공 결과를 실패라는 글자가 있는지로 판별
        XCTAssertTrue(app.staticTexts["실패"].exists)
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
