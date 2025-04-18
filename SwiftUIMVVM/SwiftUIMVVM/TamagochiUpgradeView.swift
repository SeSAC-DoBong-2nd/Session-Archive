//
//  TamagochiUpgradeView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

//MARK: Combine 사용

import SwiftUI

import Combine

struct TamagochiUpgradeView: View {
    
    @StateObject var viewModel = TamagochiUpgradeViewModel()
    
    var body: some View {
        Text("밥알: \(viewModel.output.rice)개, 물방울 \(viewModel.output.water)개")
        HStack {
            TextField("밥알을 입력해주세요",
                      text: $viewModel.input.riceField)
            Button("밥알") {
                viewModel.action(.addRice)
            }
        }
        .padding()
        HStack {
            TextField("물방울을 입력해주세요",
                      text: $viewModel.input.waterField)
            Button("물방울") {
                viewModel.action(.addWater)
            }
        }
        .padding()
    }
}

// MARK: Input/Output
class TamagochiUpgradeViewModel: ViewModelType {
    
    var input = Input()
    
    //output이 바뀌면 body가 랜더링 되도록,,
    @Published var output = Output()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        transform()
    }
    
}


//MARK: Input/Output
extension TamagochiUpgradeViewModel {
    
    struct Input {
        var riceField = ""
        var waterField = ""
        var riceButtonTapped = PassthroughSubject<Void, Never>()
        var waterButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var rice = 0
        var water = 0
    }
    
    func transform() {
        input.riceButtonTapped
            .sink { [weak self] in
                self?.addRice()
            }
            .store(in: &cancellables)
        
        input.waterButtonTapped
            .sink { [weak self] in
                self?.addWatet()
            }
            .store(in: &cancellables)
    }
    
    private func addRice() {
        if let count = Int(input.riceField) {
            output.rice += count
        } else {
            output.rice += 1
        }
//        input.riceField = ""
    }
    
    private func addWatet() {
        if let count = Int(input.waterField) {
            output.water += count
        } else {
            output.water += 1
        }
//        input.waterField = ""
    }
    
}

//MARK: Action
extension TamagochiUpgradeViewModel {
    
    enum Action {
        case addRice
        case addWater
    }
    
    func action(_ action: Action) {
        switch action {
        case .addRice:
            input.riceButtonTapped.send(())
        case .addWater:
            input.waterButtonTapped.send(())
        }
    }
    
}

#Preview {
    TamagochiUpgradeView()
}
