//
//  ComponentView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/14/25.
//

import SwiftUI
// View가 받을 수 있는 뷰 갯수 10개 제한 -> Swift5.9 Generic prameter Pack
//  (Rx CombineLatest도 8개 제한)

/// Hashable. Identifiable. ForEach.
/// Swift Key Path = \.문법

/// LazyVStack vs VStack:
/// - 메모리 관점에서 차이 알아보기
/// - 스크롤뷰에 넣었을 때 어떤 차이가 있는 지
struct Genre: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}


struct ComponentView: View {
    
    // [String] -> [Genre]
    @State var list = [
        Genre(name: "스릴러", count: 4),
        Genre(name: "SF", count: 64),
        Genre(name: "액션", count: 10),
        Genre(name: "액션", count: 10),
        Genre(name: "로맨스", count: 34)
    ]
    
    /*
     Button
     - titleKey action
     - action Label
     */
    
    var body: some View {
        VStack {
            Button { //Action, Label
                print("버튼 클릭")
            } label: { //얘는 커스텀 영역
                EventView(image: "star", text: "하이")
                    .frame(width: 300, height: 200)
                    .background(.brown)
            }

            //아래 기존 버튼은 클릭 영역이 title영역만 가능하다
            Button("추가하기") { //titleKey, Action
                let genre = Genre(name: "테스트", count: .random(in: 1...100))
                list.append(genre)
            }
            .padding(50)
            .background(.green)
            ScrollView {
                LazyVStack {
                    //ForEach의 id: 앞의 객체의 고유성을 판별할 수 있는 기준이 되는 값만 오면 됨
                    ForEach(list, id: \.id) { item in
                        EventView(image: "star", text: "\(item.name): \(item.count)")
                    }
                }
            }
        }
    }
}

private struct EventView: View {
    
    let image: String
    let text: String
    
    var body: some View {
        
        HStack {
            Image(systemName: image)
            Text(text)
        }
        .padding()
    }
    
}

#Preview {
    ComponentView()
}
