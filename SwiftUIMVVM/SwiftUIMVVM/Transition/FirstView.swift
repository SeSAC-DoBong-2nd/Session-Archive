//
//  FirstView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/21/25.
//

import SwiftUI

/*
 NavigationLink, push -> @Environment(\.dismiss)
 isActive, State -> Binding
 */

struct FirstView: View {
    @State private var isPush = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                NavigationLink("PUSH") {
                    SecondView()
                }.padding()
                
                NavigationLink("Second PUSH", isActive: $isPush, destination: {
                    DetailView(isPush: $isPush)
                })
                
                    
            }
            .navigationTitle("View")
        }
    }
}

struct DetailView: View {
    @Binding var isPush: Bool
    
    var body: some View {
        Text("Detail View")
        Button("IsPush Change") {
            isPush = false
        }
    }
}

struct SecondView: View {
    
    @Environment(\.dismiss) //iOS15+
    private var pop
    
    var body: some View {
        Text("Second View")
        
        Button("Pop Button") {
            pop()
        }
    }
}

#Preview {
    FirstView()
}
