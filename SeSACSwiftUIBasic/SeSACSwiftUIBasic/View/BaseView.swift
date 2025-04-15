//
//  BaseView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/14/25.
//

import SwiftUI
//Swift Opaque Type, some. vs Swift Type Erasure (런타임 시점에 동작)
//body 옆에 왜 some?!
//  -> 연산 프로퍼티에서 return이 생략된 형태로 컴파일 타임에 이미 어떠한 타입인지 알고있으나, 이를 숨기기 위하여 some 키워드를 사용
//  왜냐하면 객체에 속성을 추가하는 등의 작업을 진행하면 타입이 복잡해지니 불투명하게 바꿔 숨겨두는 것. 이후 큰 틀은 어떤 것을 따라야하는지 뒤에 명시.

//Modifier: .padding(), .background() = 존재하는 객체에 대해 변화를 주는 것
//  -> 각 modifier 적용 때 마다 새로운 뷰를 반환하는 것이 line by line으로 적용되기에 설정 순서(우선순위)가 중요하다.
//  -> 과도하게 체이닝이 이루어지면, 계산 비용 커질 수 있음.
// 위를 해결하고자 Custom Modifier를 사용
// CustomModifier는 버전 관리도 가능
//  -> ViewModifier 프로토콜 활용

struct BaseView: View {
    var body: some View {
        Text("Hue")
            .asPointBorderText()
        Image(systemName: "star")
            .asPointBorderText()
    }
}

extension View {
    //Mirror: 런타임에 타입을 알 수 있는 것
    //  -> Swift Mirror
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

#Preview {
    BaseView()
}
