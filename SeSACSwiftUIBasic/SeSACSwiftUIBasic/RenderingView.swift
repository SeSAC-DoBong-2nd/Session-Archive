//
//  RenderingView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/14/25.
//

import SwiftUI
// 프로퍼티, 메서드, 구조체, 바디 내부
// struct Init
// 버튼 클릭 시 print는 뷰가 더 렌더링되지 않는다.

/// state Property가 변경되면, body 프로퍼티를 다시 그린다.
/// -> 그렇기에 자기자신을 제외한 안의 내용들을 다시 그리니 하위뷰의 init이 다 호출될 수 있다.
///     but, 20 -> 20 즉 같은 값으로 변경될 때에는 다시 그리지 않는다.
///     but, state Property 를 보여주고 있는 곳이 어느곳도 없다면 렌더링 X
///     but, state Property 를 한군데라도 뷰프로퍼티 안에 사용하고 있다면 body 렌더링 O
///     body 프로퍼티가 렌더링 되더라도 다른 구조체의 변경사항이 적용되지 않는다면 랜더링 되지 않는다. 단, init은 돌고있다
///         ex) 현재 Hue struct는 버튼을 누르더라도 색상이 변경되지 않지만 init은 계속 되고있다. 즉, init이 될 때 기존 body의 변화가 존재하지 않는다면 기존의 것을 그대로 사용한다.
///init -> body. init은 되는데 body를 렌더링하지 않는다.
struct RenderingView: View {
    
    //@State Property, Property Wrapper
    @State var age = 20
    
    //스유의 View 프로토콜의 규정상 body에 non-mutating 하도록 규약을 걸어뒀다. 그렇기에 데이터를 변경할게 있다면 '@State' 키워드를 걸어두면 바꿀 수 있도록 하게 해줌
    var body: some View {
        Hue()
        bran()
        den
        Text("Jack \(age)")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
        Button("버튼 클릭") {
            print("버튼이 클릭되었습니다.")
            age = Int.random(in: 1...100)
            //만약 age가 같은 값인 20이라면 다시 그리지 않는다.
        }
    }
    
    init() {
        print("RenderingView Init")
    }
    
    var den: some View {
        Text("Den")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    func bran() -> some View {
        Text("Bran")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
}

struct Hue: View {
    
//    let age: Int
    
    var body: some View {
        Text("Hue")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    init() {
        print("Hue Init")
    }
}



extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1)
        )
    }
}

#Preview {
    RenderingView()
}
