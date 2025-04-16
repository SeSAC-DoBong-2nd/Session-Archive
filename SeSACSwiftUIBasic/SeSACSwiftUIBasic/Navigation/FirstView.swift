//
//  FirstView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/16/25.
//

import SwiftUI

struct FirstView: View {
    
    let number = Int.random(in: 1...100)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    jack
                    ForEach(0..<100) { item in
                        NavigationLink("클릭") {
                            LazyView(ThirdView())
                        }
                    }
                }
            }
        }
        
    }
    
    @ViewBuilder
    var jack: some View {
        if number < 50 {
            Text("Jack")
        } else {
            Image(systemName: "star")
        }
    }
    
    @ViewBuilder
    func bran() -> some View {
        if number < 50 {
            Text("Jack")
        } else {
            Image(systemName: "star")
        }
    }
}

#Preview {
    FirstView()
}
