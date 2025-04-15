//
//  PointBorderText.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/14/25.
//

import SwiftUI

//ViewModifier Protocol
//.modifier()
private struct PointBorderText: ViewModifier {
    
    //View 프로퍼티인 content를 매개변수로 받음
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10) //수치를 입력하지 않으면 iOS 버전 별로 다른 값이 적용됨
            .asForeground(.white)
            .background(.purple)
            .clipShape(.capsule)
    }
    
}


//위를 private으로 막고, 아래 extension에서 modifier를 직접호출한다면, PointBorderText는 같은 파일안에서만 알면 되고 다른 곳에서 접근할 수 없도록 최적화 시킨다.
extension View {
    
    //내가 직접 만든 modifier를 바로 호출
    func asPointBorderText() -> some View {
        modifier(PointBorderText())
    }
    
}
