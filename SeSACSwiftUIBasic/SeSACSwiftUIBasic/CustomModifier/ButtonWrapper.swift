//
//  ButtonWrapper.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/15/25.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(
            action: action,
            label: { content }
        )
    }
    
}

extension View {
    
    func wrapToButton(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
    
}
