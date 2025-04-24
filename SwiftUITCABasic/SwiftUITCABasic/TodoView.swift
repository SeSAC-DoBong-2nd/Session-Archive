//
//  TodoView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/23/25.
//

import SwiftUI

import ComposableArchitecture

struct MyTodo: Hashable, Identifiable {
    let id = UUID()
    var content: String
    var isDone: Bool = false
}

///TCA 화면 전환 종류: transition
// @Presents, PresentationAction, ifLet

@Reducer
struct TodoFeature {
    
    @ObservableState
    struct State {
        var todoText = ""
        //IdentifiedArrayOf: UUID 기반으로 조회
        var todoList: IdentifiedArrayOf = [
            MyTodo(content: "123"),
            MyTodo(content: "456"),
            MyTodo(content: "789")
        ]
        @Presents var showDetail: DetailTodoFeature.State?
    }
    
    enum Action: BindableAction {
        case add
        case delete(id: MyTodo.ID)
        case done(id: MyTodo.ID) //체크박스 클릭
        case select(id: MyTodo.ID) //셀 클릭
        case binding(BindingAction<State>)
        case showDetail(PresentationAction<DetailTodoFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .add:
                guard !state.todoText.isEmpty else { return .none }
                
                state.todoList.append(MyTodo(content: state.todoText))
                state.todoText = ""
                return .none
            case .delete(let id):
                state.todoList.remove(id: id)
                return .none
            case .done(let id):
                print("tap done")
                guard let idx = state.todoList.index(id: id) else {
                    return .none
                }
                state.todoList[idx].isDone.toggle()
                return .none
            case .select(let id):
                //선택했을 때 다음 화면으로 넘어가도록
                //다음 화면으로 넘어갈 때 MyTodo 값 전달도 되도록
                if let list = state.todoList[id: id] {
                    //다음 화면으로 넘어갈 때 MyTodo 값도 전달되도록
                    state.showDetail =  DetailTodoFeature.State(myTodo: list)
                }
                return .none
            case .binding(_):
                return .none
            case .showDetail(_):
                return .none
            }
        }
        //ifLet: 키가되는 인스턴스가 없다면 무시하다가, 생길 때 곧바로 실행된다.
        .ifLet(\.$showDetail, action: \.showDetail) {
            DetailTodoFeature()
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
                    ForEach(store.todoList, id: \.id) { item in
                        HStack {
                            let imageName = item.isDone ? "checkmark.circle.fill" : "circle"
                            Image(systemName: imageName)
                                .onTapGesture {
                                    store.send(.done(id: item.id))
                                }
                            Text(item.content)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            store.send(.select(id: item.id))
                        }
                        .swipeActions {
                            Button("삭제", role: .destructive) {
                                store.send(.delete(id: item.id))
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("나의 할 일")
            .navigationDestination(
                store: store.scope(
                    state: \.$showDetail,
                    action: \.showDetail
                )
            ) { store in
                DetailTodoView(store: store)
            }
        }
    }
}

#Preview {
    TodoView(store: Store(initialState: TodoFeature.State(), reducer: {
        TodoFeature()
    }))
}
