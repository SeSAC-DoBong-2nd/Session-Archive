//
//  SimpleView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/29/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct Simple {
    
    @ObservableState
    struct State {
        var count = 0
        var isProgressing = false
    }
    
    enum Action {
        case plusButtonTapped // 1s wait > +1
        case plusCount
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .plusButtonTapped:
                state.isProgressing = true
                
                return .run { send in
                    try await Task.sleep(for: .seconds(1))
                    await send(.plusCount)
                }
            case .plusCount:
                state.count += 1
                state.isProgressing = false
                return .none
            }
        }
    }
    
}

struct SimpleView: View {
    
    let store: StoreOf<Simple>
    
    var body: some View {
        VStack {
            Text("Count: \(store.count)")
            Button("Plus") {
                store.send(.plusButtonTapped)
            }
            if store.isProgressing {
                ProgressView()
            }
        }
    }
}

#Preview {
    
    SimpleView(
        store: Store(
            initialState: Simple.State(),
            reducer: {Simple()}
        )
    )
}
