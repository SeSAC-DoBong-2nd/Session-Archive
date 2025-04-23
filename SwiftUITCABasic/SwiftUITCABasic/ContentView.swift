//
//  ContentView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/22/25.
//

import SwiftUI

import ComposableArchitecture

/*
 Reducer
 /// Action과 State를 받아 새로운 State를 계산
 
 */

//매크로와 프로토콜채택 둘 다 적용 가능
@Reducer //Reducer protocol 대체
struct ContentFeature {
    
    //Equatable 채택 이유
    //  - State가 달라졌을 때에 View를 갱신해야 하는데 해당 프로토콜이 없으면, 달라졌는지 비교할 수 없다.
    @ObservableState //관찰 가능한 상태로 만들어주는 프로퍼티 레퍼
    struct State: Equatable { //SSOT
        var count = 0
    }
    
    enum Action: BindableAction {
        case add
        case minus
        case binding(BindingAction<State>)
    }
    
    //ReducerOf<self> == Reducer<R.State, R.Action>
    var body: some ReducerOf<Self> {
        
        BindingReducer() //check Start
        
        Reduce { state, action in
            switch action {
            case .add:
                state.count += 1
                return .none //비동기 작업이 없음을 나타냄
            case .minus:
                state.count -= 1
                return .none
            case .binding:
                return .none
            }
        }
    }
}

struct ContentView: View {
    
    @Bindable //state > stateobject > bindable
    var store: StoreOf<ContentFeature>
    // 이와 같은 코드를 typealias를 활용하여 위처럼 변경 == Store<ContentFeature.State, ContentFeature.Action>
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(store.count)")
                .font(.largeTitle)
            HStack {
                Button("-") {
                    store.send(.minus)
                }
                Button("+") {
                    store.send(.add)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}




#Preview {
    ContentView(
        store: Store(initialState: ContentFeature.State()) {
            ContentFeature()
        }
    )
}
