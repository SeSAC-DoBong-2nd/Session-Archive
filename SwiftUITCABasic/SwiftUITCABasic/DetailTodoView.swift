//
//  DetailTodoView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/24/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct DetailTodoFeature {
    
    @ObservableState
    struct State {
        var myTodo: MyTodo
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
    
}

struct DetailTodoView: View {
    
    let store: StoreOf<DetailTodoFeature>
    
    var body: some View {
        HStack {
            let image = store.myTodo.isDone ? "checkmark.circle.fill" : "circle"
            Image(systemName: image)
            Text(store.myTodo.content)
        }
    }
}

#Preview {
    DetailTodoView(
        store: Store(
            initialState: DetailTodoFeature.State(myTodo: MyTodo(content: "케케몬", isDone: true)),
            reducer: { DetailTodoFeature() }
        )
    )
}
