//
//  TamagochiView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

import SwiftUI

struct TamagochiView: View {
    
    @StateObject var viewModel = TamagochiViewModel()

    var body: some View {
        Text("밥알: \(viewModel.rice)개, 물방울 \(viewModel.water)개")
        HStack {
            TextField("밥알을 입력해주세요",
                      text: $viewModel.riceField)
            Button("밥알") {
                viewModel.addRice()
            }
        }
        .padding()
        HStack {
            TextField("물방울을 입력해주세요",
                      text: $viewModel.waterField)
            Button("물방울") {
                viewModel.addWatet()
            }
        }
        .padding()
    }
}

class TamagochiViewModel: ObservableObject {
    
    @Published var riceField = ""
    @Published var rice = 0
    @Published var waterField = ""
    @Published var water = 0
    
    func addRice() {
        if let count = Int(riceField) {
            rice += count
        } else {
            rice += 1
        }
        riceField = ""
    }
    
    func addWatet() {
        if let count = Int(waterField) {
            water += count
        } else {
            water += 1
        }
        waterField = ""
    }
    
}

#Preview {
    TamagochiView()
}
