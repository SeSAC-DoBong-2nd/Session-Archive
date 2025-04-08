//
//  JackWidgetExtensionLiveActivity.swift
//  JackWidgetExtension
//
//  Created by 박신영 on 4/7/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct JackWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct JackWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: JackWidgetExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension JackWidgetExtensionAttributes {
    fileprivate static var preview: JackWidgetExtensionAttributes {
        JackWidgetExtensionAttributes(name: "World")
    }
}

extension JackWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: JackWidgetExtensionAttributes.ContentState {
        JackWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: JackWidgetExtensionAttributes.ContentState {
         JackWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: JackWidgetExtensionAttributes.preview) {
   JackWidgetExtensionLiveActivity()
} contentStates: {
    JackWidgetExtensionAttributes.ContentState.smiley
    JackWidgetExtensionAttributes.ContentState.starEyes
}
