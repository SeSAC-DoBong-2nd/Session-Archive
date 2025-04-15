//
//  TamagochiView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/15/25.
//

import SwiftUI

struct TamagochiView: View {
    /// 하위뷰에서 State 값의 변경을 하고 싶은 경우
    @State private var count = 100
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            //조건문에 따라 어떤 Text가 보일지 모르니 랜더링 시 계속 아래 Text가 나오더라도 조건문을 계속 랜더링 탄다.
//            if count < 100 {
//                Text("밥알 개수")
//            } else {
//                Text("밥알 개수 많음")
//            })
            CountView(count: count) //하위뷰
            
            //TextField의 text에 $사용이유: TextField 속 하위뷰에 text를 보여주려 전달해주는 느낌으로 이해하자
            TextField("밥알 갯수를 입력해주세요", text: $text)
                .padding()
            
            Text("직접 밥알 먹이기")
                .wrapToButton {
                    if let rice = Int(text) {
                        count += rice
                    } else {
                        count += 1
                    }
                }
            
            FoodButtonView(count: $count) //하위뷰
                //$(달러사인): 접두어 규칙
        }
    }
    
}

struct FoodButtonView: View {
    /// 상위 뷰의 SOT를 주입 및 참조받고 있음
    /// 값을 수정하면, State에 전달해줌
    @Binding var count: Int //Derived Value
    
    var body: some View {
        Text("밥알 먹이기")
            .wrapToButton {
                count += 1
            }
    }
    
}

struct CountView: View {
    
    let count: Int
    
    var body: some View {
        Text("\(count) 개")
            .font(.largeTitle)
            .asPointBorderText()
    }
    
}

#Preview {
    TamagochiView()
}
