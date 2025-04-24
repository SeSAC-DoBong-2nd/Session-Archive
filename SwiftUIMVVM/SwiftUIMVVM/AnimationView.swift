//
//  AnimationView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

import SwiftUI

struct CardModel: Hashable {
    let color = Color.random()
    let name: String
    let number: Int
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

var cardlist = [
    CardModel(name: "신한카드", number: 0),
    CardModel(name: "우리카드", number: 1),
    CardModel(name: "국민카드", number: 2),
    CardModel(name: "대구카드", number: 3),
    CardModel(name: "카카오카드", number: 4)
]

struct AnimationView: View {
    
    var cardlist = [
        CardModel(name: "신한카드", number: 0),
        CardModel(name: "우리카드", number: 1),
        CardModel(name: "국민카드", number: 2),
        CardModel(name: "대구카드", number: 3),
        CardModel(name: "카카오카드", number: 4)
    ]
    
    @State private var isExpandable = false
    @State private var showdetail = false
    @State private var currentCard = CardModel(name: "", number: 0)
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            topTitle()
            cardSpace()
            Spacer()
            Button("Animation ON") {
                withAnimation(.bouncy) {
                    isExpandable = true
                }
            }
            Button("Animation OFF") {
                withAnimation(.bouncy) {
                    isExpandable = false
                }
            }
        }
        .overlay {
            if showdetail {
                DetailAnimationView(
                    showDetail: $showdetail,
                    currentCard: currentCard,
                    animation: animation
                )
            }
        }
    }
    
    func cardSpace() -> some View {
        ScrollView {
            ForEach(cardlist, id: \.self) { item in
                cardView(item)
            }
        }
        .overlay {
            Rectangle() //HitTest 1%: iOS는 1퍼센트 미만으로 내려가면 터치가 안된다.
                .fill(.black.opacity(isExpandable ? 0 : 0.01))
                .onTapGesture {
                    withAnimation(.easeOut) {
                        isExpandable = true
                    }
                }
        }
    }
    
    //didselectRowAt 셀을 선택 했을 때 화면 전환 + 탭 제스처
    //  위 2개는 동시에 구현하기 어려울 것이다.
    //  이에 대한 방안으로 위에 투명 view하나깔고 이친구로 열고닫고 진행하고 펼쳐지면 투명뷰 isHidden로 대응하는 것과,isExpandable 상태에 따라 다른 함수를 가지도록 할 수도 있다.
    
    //1. 카드 선택시 디테일뷰로 넘어가는 기능
    //2. 카드가 접혀있다면 펼쳐주는 기능
    
    func cardView(_ card: CardModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(card.color)
            .frame(height: 130)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .offset(y: CGFloat(card.number) * (isExpandable ? 0 : -100))
            .matchedGeometryEffect(id: card, in: animation)
            .onTapGesture {
                currentCard = card
                withAnimation(.easeInOut) {
                    showdetail = true
                }
            }
    }
    
    func topTitle() -> some View {
        Text("Hello world")
            .font(.largeTitle)
            .bold()
            .frame(
                maxWidth: .infinity,
                alignment: isExpandable ?.leading : .center
            )
            .overlay(alignment: .trailing) {
                    topOverlayButton()
                
            }
            .padding()
    }
    
    func topOverlayButton() -> some View {
        Button {
            print("plus 버튼 눌림")
            withAnimation(.bouncy) {
                isExpandable = false
            }
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
                
        }
        .rotationEffect(.degrees(isExpandable ? 225 : 45))
        .opacity(isExpandable ? 1 : 0)
    }
    
}

struct DetailAnimationView: View {
    
    @Binding var showDetail: Bool
    let currentCard: CardModel
    let animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(currentCard.color)
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .matchedGeometryEffect(id: currentCard, in: animation)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showDetail = false
                        }
                    }
            }
        }
    }
}

#Preview {
    AnimationView()
}
