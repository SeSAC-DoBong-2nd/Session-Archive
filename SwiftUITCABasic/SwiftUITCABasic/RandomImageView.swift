//
//  RandomImageView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/29/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct RandomImage {
    
    @ObservableState
    struct State {
        var imageURL = URL(string: "https://picsum.photos/id/245/200/300")!
    }
    
    enum Action {
        case loadButtonTapped
        case imageLoad(URL)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadButtonTapped:
                let num = Int.random(in: 1...500)
                let url = URL(string: "https://picsum.photos/id/\(num)/200/300")!
                
                return .run { send in
                    try await Task.sleep(for: .seconds(1))
                    await send(.imageLoad(url))
                }
            case .imageLoad(let url):
                state.imageURL = url
                return .none
            }
        }
    }
    
}

struct RandomImageView: View {
    
    let store: StoreOf<RandomImage>
    
    var body: some View {
        VStack {
            photo(store.imageURL)
            Button("랜덤 이미지 로드") {
                store.send(.loadButtonTapped)
            }
        }
    }
    
    func photo(_ url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 200, height: 200)
            case .empty, .failure(_):
                Rectangle()
                    .fill(.gray)
                    .frame(width: 200, height: 200)
            @unknown default:
                Rectangle()
                    .fill(.gray)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

#Preview {
    RandomImageView(
        store: Store(
            initialState: RandomImage.State(),
            reducer: {
                RandomImage()
            }
        )
    )
}

