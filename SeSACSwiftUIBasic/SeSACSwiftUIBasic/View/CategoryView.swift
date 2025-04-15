//
//  CategoryView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/15/25.
//

import SwiftUI

struct CategoryView: View {
    /// State가 달라지면 다시 body Rendering
    /// View의 상태를 저장하고 변화를 관찰해 View를 업데이트 하는 것이 State의 역할
    
    /// @State가 쓰이는 곳이 아닌 다른 뷰에서 이를 관리하면 이는 모순이기에 private 처리
    ///     = Source Of Truth
    ///     사람이 해결해야하는 것에는 한계가 있으나, 해당 뷰에서 관리해야하는 것이 많아 지면 버그가 넘쳐날것
    ///     Source Of Truth를 두고 이가 바뀌면 UI를 바꿔주자
    ///     뷰가 바뀌는 것의 근거 = Source Of Truth인 @State의 변화
    ///     즉, Data와 UI 관리가 쉽도록 도와준다 (= Source Of Truth)
    @State private var genre = "로맨스"
    
    /// Body가 Rendering 될 때, SwiftUI에서 뷰 트리를 다시 게산해서, 변경된 부분만 효율적으로 업데이트(정적인 뷰들은 다시 그리지 않음)
    /// = SwiftUI Identity
    ///     - Structural Identity: 뷰 구조와 위치를 통해 변화하는 파트인지 파악
    ///     - Explicit Identity: 개발자가 명시적으로 id를 지정해서 해당 id로 뷰의 동일성을 판단하는 것
    
    /// 또한 body가 위치한 파일 자체는 다시 init되지 않지만, body 코드 속에 위치한 구조체 등은 새롭게 init됨
    var body: some View {
        VStack {
            
            /// 아래 if문의 경우 genre값이 바껴 렌더링 될 때 Structural Identity에 따라 뷰의 구조가 바뀌는 위치이기에 런타임 시에 계속 렌더링 한다.
            if genre == "로맨스" {
                Image(systemName: "star")
            } else {
                Text("로맨스 아님")
            }
            
            
            Text("선택 장르: \(genre)")
            
            HStack {
                HStack {
                    Image(systemName: "star")
                    Text("로맨스")
                }
                .wrapToButton {
                    genre = "로맨스"
                }
                
                HStack {
                    Image(systemName: "star")
                    Text("액션")
                }
                .wrapToButton {
                    genre = "액션"
                }
                
                HStack {
                    Image(systemName: "star")
                    Text("스릴러")
                }
                .wrapToButton {
                    genre = "스릴러"
                }
            }
        }
    }
    
}

//struct CategoryView: View {
//
//    @State var selectedCategory: String = "미정"
//    private let categoryList = ["로맨스", "액션", "스릴러"]
//
//    var body: some View {
//        Text("선택한 장르: \(selectedCategory)")
//            .contentTransition(.numericText())
//            .animation(.default, value: selectedCategory)
//
//        HStack {
//            Button {
//                self.selectedCategory = categoryList[0]
//            } label: {
//                Text("로맨스")
//            }
//
//            Button {
//                self.selectedCategory = categoryList[1]
//            } label: {
//                Text("액션")
//            }
//
//            Button {
//                self.selectedCategory = categoryList[2]
//            } label: {
//                Text("스릴러")
//            }
//        }
//    }
//}


#Preview {
    CategoryView()
}
