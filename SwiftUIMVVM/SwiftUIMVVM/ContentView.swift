//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var nickname = ""
    //SwiftUI에서 사용되는 유저디폴츠 프로퍼티 레퍼 = AppStorage
//    @AppStorage("jack") var savedNickname: String?
    
    ///네비게이션 스택
    ///상위뷰에 하위뷰가 종속적이지 않은 형태로 값 전달, 화면 전환
    var body: some View {
        VStack {
            TextField("닉네임을 입력해 보세요", text: $nickname)
            
            Button("저장") {
                UserDefaults.standard.set(nickname, forKey: "Dobong")
                
                //AppGroup을 사용했다면 아래와 같이 사용해야한다!!
                UserDefaults.groupShared.set(nickname, forKey: "Dobong")
                //위젯이 보통 1시간 주기로 갱신되는데, 해당 코드를 사용하면 바로 갱신
                /*
                 1. 저장 버튼 클릭 시 위젯이 바로 렌더링 (시간과, emoji 숫자가 바뀌는게 보임)
                 2. userdefaults jack이 widget에 적용되지 않음
                 */
                WidgetCenter.shared.reloadTimelines(ofKind: "BasicWidget")
                
                WidgetCenter.shared.getCurrentConfigurations { widget in
                    switch widget {
                    case .success(let success):
                        print("success: ",success)
                    case .failure(let failure):
                        print("failure: ",failure)
                    }
                }
            }
            .padding()
            Text(UserDefaults.standard.string(forKey: "Dobong") ?? "없음")
            Text(UserDefaults.groupShared.string(forKey: "Dobong") ?? "없음")
            CountView()
        }
        .padding()
    }
}

/*
 # ObservableObject:
 - 클래스의 인스턴스를 관찰하고 있다가, @Published로 선언된 데이터가 변경이 되면 신호를 보내준다.
 # StateObject:
- @Published로 선언된 데이터가 변경되면 신호를 받는다.
- StateObject으로 선언된 인스턴스는 생성시점에 한번 초기화 되고, 이후 뷰의 렌더링 여부와 상관 없이 해당 변수는 뷰 내에서 재사용된다.
 
 # ObservedObject:
 - ObservedObject으로 선언된 인스턴스는 뷰가 렌더링될 때 인스턴스가 새롭게 생성되기 때문에 기존에 주입받은 값이 휘발될 수 있다.
 
 */

struct CountView: View {
    //body rendering > state
    @StateObject var viewModel = CountViewModel()
    
    /// 여기의 body는 @State가 아직 없어서 자기가 언제 렌더링 돼야하는지 모름
    /// vm을 @State 즉, SOT로 설정하여 렌더링의 기준이 되도록한다.
    var body: some View {
        Text("나의: \(viewModel.age)")
        Button("클릭") {
            viewModel.addAge()
        }
    }
}

//ObservableObject: @Published로 관찰을 하기위해 필요
class CountViewModel: ObservableObject {
    /// State는 View의 SOT로 VM에서는 사용될 수 없다.
    /// age가 변경되면 -> @State var viewModel 에게 신호를 전달해주어야 한다.
    @Published var age = 0
    
    func addAge() {
        age += 1
    }
    
}

#Preview {
    ContentView()
}
