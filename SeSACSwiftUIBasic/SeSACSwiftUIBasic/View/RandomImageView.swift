//
//  RandomImageView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/15/25.
//

import SwiftUI

struct RandomImageView: View {
    
    @State private var number = 50
    
    var body: some View {
        LoadButton(number: $number)
        PosterView()
    }
    
}

struct LoadButton: View {
    
    @Binding var number: Int
    
    var body: some View {
        Text("이미지 다시 가져오기")
            .wrapToButton {
                number = (1...237).randomElement()!
            }
    }
    
}

struct PosterView: View {
    
//    let number: Int
    let url = URL(string: "https://picsum.photos/200/300")!
    
    var body: some View {
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 100, height: 100)
            case .failure(_):
                Image(systemName: "star")
            @unknown default:
                Image(systemName: "star")
            }
        }
    }
    
}

#Preview {
    RandomImageView()
}
