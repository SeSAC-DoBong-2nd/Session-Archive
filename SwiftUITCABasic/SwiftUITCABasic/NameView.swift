//
//  NameView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/23/25.
//

//import SwiftUI
//
//import ComposableArchitecture
//
//@Reducer
//struct NameFeature {
//    
//    @ObservableState
//    struct State { //앱 상태
//        var name = "로맨스"
//    }
//    
//    enum Action: String { //상태를 변경할 수 있는 액션
//        case romance = "로맨스"
//        case thriller = "스릴러"
//        case family = "가족"
//    }
//    
//    //액션에 따라 상태를 어떻게 변경할지 정의
//    //State, Action -> Effect
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            state.name = action.rawValue
//            return .none
//            switch action {
//            case .romance:
//                state.name = action.rawValue
//                return .none
//            case .thriller:
//                state.name = action.rawValue
//                return .none
//            case .family:
//                state.name = action.rawValue
//                return .none
//            }
//        }
//    }
//    
//}
//
//struct NameView: View {
//    
//    let store: StoreOf<NameFeature> //state, action
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Button("로맨스") { store.send(.romance) }
//                Button("스릴러") { store.send(.thriller) }
//                Button("액션") { store.send(.family) }
//            }
//            .buttonStyle(.borderedProminent)
//            Text(store.name)
//                .font(.largeTitle)
//        }
//    }
//}
//
//#Preview {
//    NameView(
//        store: Store(
//            initialState: NameFeature.State(),
//            reducer: {NameFeature()}
//        )
//    )
//    
//}
//
