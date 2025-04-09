//
//  ContentView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/9/25.
//

import SwiftUI
/*
 iOS13+ 등장
 구조체 기반.
 View Protocol을 통해서 뷰를 구성
 오토레이아웃, addSubView, 계층..
 body 라는 친구가 뷰를 그려주는 형태
 */

//구조체 특성 상 프로퍼티가 변수이더라도 내부 프로퍼티의 변경이 불가능하다.
//  -> 단 mutating을 활용한다면 가능하다.
//연산 프로퍼티에서 get은 nonmutating 상태
//get -> mutating get, func -> mutating func으로 변경하면 프로퍼티의 값을 수정할 수 있음.
struct User {
    
    var nickname = "고래밥"
    
    var introduce: String {
        mutating get {
            nickname = "칙촉"
            return "안녕하세요 저는 \(nickname)입니다."
        }
    }
    
    mutating func change() {
        nickname = "칙촉"
    }
    
}

//문법적으로는 mutating get으로 프로퍼티 수정을 할 수 있으나!
//SwiftUI View를 구성하는 근간인 View Protocol은 nonmutatting get 특성을 가진 body를 사용하고 있기에 적용할 수 없다.
//  -> 위 상황에 대한 해결법 = @State
struct ContentView: View {
    
    var nickname = "고래밥"
    
    //body 역시 연산 프로퍼티 이기에 return 생략된 상태
    
    //컴파일 시점에 body 프로퍼티의 타입을 이미 알고 있는 상태
    //Opaque Type. 불투명 타입. 컴파일 타임에 이미 타입을 알고 있음에도, 일부러 숨기는 기능 = some
    var body: some View {
        get {
            Button("버튼") {
                let value = type(of: self.body)
                print(value)
            }
        }
    }
}

#Preview {
    ContentView()
}
