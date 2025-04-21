//
//  ListView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/21/25.
//

import SwiftUI

struct ListView: View {
    
    let array = ["고래밥", "아메리카노", "호올스", "칙촉ㅍ"]
    
    @Namespace private var jack
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(array, id: \.self) { item in
                        NavigationLink(value: item) {
                            HStack {
                                Image(systemName: "star")
                                Text(item)
                            }
                            .frame(height: 100)
                            .background(.gray.opacity(0.3))
                        }
                    }
                }
            }
            .navigationTitle("title")
            .navigationDestination(for: String.self) {
                ListDetailView(name: $0)
                //iOS18+
                    .navigationTransition(.zoom(sourceID: $0, in: jack))
            }
        }
    }
}

struct ListDetailView: View {
    
    var name: String
    
    var body: some View {
        Text("List Detail View")
    }
}

#Preview {
    ListView()
}
