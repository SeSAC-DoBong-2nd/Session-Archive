//
//  TransitionView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/28/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct Transition {
    
    @ObservableState
    struct State {
        var isPresented = false
        var text = "" //텍스트필드
        
        //화면을 닫아줄지 말지에 대해 상세 화면의 state action 값을 가지고 있어야 핸들링이 가능.
        //상세뷰가 필요하지 않으면 nil의 방법을 사용
        @Presents var detail: DetailTransition.State?
    }
    
    ///PresentationAction
    ///- 자식 뷰에서 발생한 액션을 부모뷰에서 처리할 수 있도록 돕는 수단
    
    enum Action: BindableAction {
        case isSheetOn(status: Bool)
        case binding(BindingAction<State>)
        case showDetail(PresentationAction<DetailTransition.Action>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .isSheetOn(status: true):
                if state.text.count >= 5 {
                    state.detail = DetailTransition.State(field: state.text)
                    state.isPresented = true
                }
                return .none
                
            case .isSheetOn(status: false):
                state.isPresented = false
                return .none
                
            case .binding(_):
                return .none
                
            case .showDetail(.presented(.dismiss)):
                state.detail = nil
                state.isPresented = false
                return .none
                
            case .showDetail:
                return .none
            }
        }
        .ifLet(\.$detail, action: \.showDetail) {
            DetailTransition()
        }
    }
    
}

/**
 1. 앞화면에서 입력한 글자가 다음화면으로 전달
 2. 앞화면에서 5글자 이상 입력을 해야 sheet가 동작이되도록
 */
//Transition -> present(sheet) -> DetailTransition
struct TransitionView: View {
    
    @Bindable var store: StoreOf<Transition>
    
    var body: some View {
        VStack {
            Text("텍스트: \(store.text)\textCount: \(store.text.count)")
            TextField("케케몬", text: $store.text)
            Button("화면 전환하기") {
                //
                store.send(.isSheetOn(status: true))
            }
        }
        .sheet(item: $store.scope(state: \.detail, action: \.showDetail)) { store in
            DetailTransitionView(store: store)
        }
        
//        .sheet(isPresented: $store.isPresented.sending(\.isSheetOn)) {
//            DetailTransitionView(store: Store(initialState: DetailTransition.State(), reducer: {
//                DetailTransition()
//            }))
//        }
    }
    
}

@Reducer
struct DetailTransition {
    
    @ObservableState
    struct State {
        var field = ""
    }
    
    ///BindableAction
    ///BindingAction<State>
    ///case .binding
    ///@Bindable var
    
    enum Action: BindableAction {
        case okTap
        case binding(BindingAction<State>)
        case dismiss
    }
    
    var body: some ReducerOf<Self> {
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .okTap:
//                state.field = "케케몬"
                return .none
            case .binding:
                return .none
            case .dismiss:
                return .none
            }
        }
    }
    
}

struct DetailTransitionView: View {
    
    @Bindable var store: StoreOf<DetailTransition>
    
    var body: some View {
        VStack {
            Button("닫기") {
                store.send(.dismiss)
            }
            
            //DetailTransition.State.field.text
            Text("텍스트: \(store.field)\nfieldCount: \(store.field.count)")
            TextField("입력해주세요", text: $store.field)
            Button("확인") {
                //DetailTransition.Action.okTap
                print("확인 탭")
                store.send(.okTap)
            }
        }
        .padding()
        .font(.title)
    }
}

//#Preview {
//    DetailTransitionView(store: Store(initialState: DetailTransition.State(), reducer: {
//        DetailTransition()
//    }))
//}
