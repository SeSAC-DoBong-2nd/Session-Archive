//
//  NavigationBarWrapper.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/16/25.
//

import SwiftUI

private struct NavigationBarWrapper<Leading: View, Trailing: View>: ViewModifier {
    private let leading: Leading
    private let trailing: Trailing
    
    init(
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: { leading })
                    ToolbarItem(placement: .topBarTrailing, content: { trailing })
                }
        } else {
            content
                .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
}


extension View {
    func navigationBar(
        @ViewBuilder leading: () -> some View = { EmptyView() },
        @ViewBuilder trailing: () -> some View = { EmptyView() }
    ) -> some View {
        modifier(NavigationBarWrapper(leading: leading, trailing: trailing))
    }
}
