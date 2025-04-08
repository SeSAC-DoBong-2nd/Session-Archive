//
//  JackWidgetExtensionBundle.swift
//  JackWidgetExtension
//
//  Created by 박신영 on 4/7/25.
//

import WidgetKit
import SwiftUI

@main
struct JackWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        JackWidgetExtension()
        JackWidgetExtensionControl()
        JackWidgetExtensionLiveActivity()
    }
}
