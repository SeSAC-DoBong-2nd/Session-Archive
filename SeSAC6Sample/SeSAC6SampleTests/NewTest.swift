//
//  NewTest.swift
//  SeSAC6SampleTests
//
//  Created by 박신영 on 4/9/25.
//

import Testing
/*
 struct
 setup / teardown X
 async throw
 
 17 macro
 @Test: 테스트 메서드이다
    - 이 친구가 setup, teardown 다 해줌
 
 xctest:
    -동기에 최적화 돼있어서, 혹 비동기가 필요하다면 이를 기다려주는 상황을 직접 만들어 주어야 했다.
    - ex) expectation, wait, fulfill
 
 testing:
    - Test 함수 자체가 비동기로 동작
    => asunc await (Swift Concurrency)
 
    
 */
struct NewTest {

    @Test
    func jack() async throws {
        let a = 2
        let b = 2
        
        //XCTAssert 와 동일
        #expect(a + b == 4)
    }
    
    @Test
    func jack1() async throws {
        let result = await fetchLotto()
        
        assert(result)
    }
    
    func fetchLotto() -> Bool {
        // 비동기 통신 코드
        return false
    }

}
