//
//  SecondView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/16/25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    private let content: () -> Content
    
    var body: some View {
        content()
    }
    
    /// @autoclosure: 클로저 문을 () 소괄호로 사용할 수 있다.
    ///     ex) LazyView(ThirdView()) 이와 같이 호출할 수 있음
    init(_ content: @autoclosure @escaping () -> Content) {
        self.content = content
    }
}

struct ThirdView: View {
    var body: some View {
        Text("hellow world")
    }
    
    init() {
        print("ThirdView Init")
        //서버통신
    }
}

