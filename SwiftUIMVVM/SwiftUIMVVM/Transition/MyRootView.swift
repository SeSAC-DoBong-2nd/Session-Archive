//
//  MyRootView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/21/25.
//

import SwiftUI

struct MyRootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                NavigationLink("Push") {
                    MyChildView(number: 1)
                }
                NavigationLink("Second Push", value: 5)
            }
            .navigationTitle("View")
            .navigationDestination(for: Int.self) { number in
                MyChildView(number: number)
            }
        }
    }
}

struct MyChildView: View {
    
    var number: Int
    
    var body: some View {
        Text("MyChildView: \(number)")
    }
}

#Preview {
    MyRootView()
}
