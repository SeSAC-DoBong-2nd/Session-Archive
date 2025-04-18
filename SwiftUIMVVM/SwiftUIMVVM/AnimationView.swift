//
//  AnimationView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

import SwiftUI

struct AnimationView: View {
    
    @State private var isExpandable = false
    
    var body: some View {
        VStack {
            topTitle()
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

#Preview {
    AnimationView()
}
