//
//  SwiftUITCABasicApp.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/22/25.
//

import SwiftUI

import ComposableArchitecture

@main
struct SwiftUITCABasicApp: App {
    var body: some Scene {
        WindowGroup {
            RandomImageView(
                store: Store(
                    initialState: RandomImage.State(),
                    reducer: {
                        RandomImage()
                    }
                )
            )
        }
    }
}
