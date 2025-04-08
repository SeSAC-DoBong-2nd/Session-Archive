//
//  AppIntent.swift
//  JackWidgetExtension
//
//  Created by 박신영 on 4/7/25.
//

import WidgetKit
import AppIntents
//import SeSACLaunchProject //모듈을 임포트: Jack class만 사용하고 싶은데, import 안에 있는 것들을 전부 불러와야 해서 문제이다.

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
