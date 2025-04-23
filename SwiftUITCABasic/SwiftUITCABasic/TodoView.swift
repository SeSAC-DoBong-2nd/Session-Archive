//
//  TodoView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/23/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct TodoFeature {
    
    @ObservableState
    struct State {
        var todoText = ""
        var todoList = ["123", "456", "789"]
    }
    
    enum Action: BindableAction {
        case add
        case delete
        case done
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .add:
                
                guard !state.todoText.isEmpty else { return .none }
                
                state.todoList.append(state.todoText)
                state.todoText = ""
                return .none
            case .delete:
                state.todoList.remove(at: 0)
                return .none
            case .done: //할 일 완료에 대한 체크 기능 추가해야 함.
                print("tap done")
                return .none
            case .binding(_):
                return .none
            }
        }
    }
    
}

struct TodoView: View {
    
    @Bindable var store: StoreOf<TodoFeature>
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("할 일을 입력해주세요.", text: $store.todoText)
                    Button {
                        store.send(.add)
                    } label: { Image(systemName: "plus") }

                }
                .padding()
                List {
                    ForEach(store.todoList, id: \.self) { item in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text(item)
                                
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            store.send(.done)
                        }
                        .swipeActions {
                            Button("삭제", role: .destructive) {
                                store.send(.delete)
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("나의 할 일")
        }
    }
}

#Preview {
    TodoView(store: Store(initialState: TodoFeature.State(), reducer: {
        TodoFeature()
    }))
}
