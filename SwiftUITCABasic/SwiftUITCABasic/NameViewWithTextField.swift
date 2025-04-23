//
//  NameViewWithTextField.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/23/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct NameFeature {
    
    @ObservableState
    struct State { //앱 상태
        var name = "로맨스"
        var genreText = ""
    }
    
    //BindableAction이 가끔 채택되는 이유 >>
    //  @State <-> @Binding의 역할을 TCA가 가지고 있지 않다.
    //  즉, $를 통해 양방향 바인딩을 사용하는 경우 채택
    enum Action: BindableAction { //상태를 변경할 수 있는 액션
        case romance
        case thriller
        case family
        case binding(BindingAction<State>) //@State <-> @Binding
    }
    
    //액션에 따라 상태를 어떻게 변경할지 정의
    //State, Action -> Effect
    var body: some ReducerOf<Self> {
        
        //bindable 했을 때 꼭 필요
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .romance:
                state.name = "로맨스"
                return .none
            case .thriller:
                state.name = "스릴러"
                return .none
            case .family:
                state.name = "가족"
                return .none
            case .binding:
                return .none
            }
        }
    }
    
}

struct NameView: View {
    
    @Bindable
    var store: StoreOf<NameFeature> //state, action
    
    var body: some View {
        VStack {
            TextField("장르를 입력해주세요", text: $store.genreText)
            Text("TF에 입력한 내용: \(store.genreText)")
            HStack {
                Button("로맨스") { store.send(.romance) }
                Button("스릴러") { store.send(.thriller) }
                Button("액션") { store.send(.family) }
            }
            .buttonStyle(.borderedProminent)
            Text(store.name)
                .font(.largeTitle)
        }
    }
}

#Preview {
    NameView(
        store: Store(
            initialState: NameFeature.State(),
            reducer: {NameFeature()}
        )
    )
    
}

