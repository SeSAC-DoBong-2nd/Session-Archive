//
//  HorizontalScrollView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/15/25.
//

import SwiftUI

struct HorizontalScrollView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<7) { item in
                    PosterView()
                }
            }
        }
        .padding()
    }
}

#Preview {
    HorizontalScrollView()
}
