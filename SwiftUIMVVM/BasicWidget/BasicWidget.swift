//
//  BasicWidget.swift
//  BasicWidget
//
//  Created by 박신영 on 4/21/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    ///위젯 최초 랜더링 시 더미 적용
    ///잠금화면에서 위젯등록. 위젯에 민감한 정보를 숨기고자 할 때 잠금해제하기 전까지 Placeholder를 표시하기도 가능
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    ///위젯 갤러리 미리보기 화면
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀😀😀")
        completion(entry)
    }

    ///위젯 상태 변경 시점
    ///미리 위젯 뷰를 그리고 있다가 시간에 맞춰 뷰를 업데이트하고, TimeLineEntry를 통해 특정 시간에 위젯을 업데이트 할 수 있도록 도와줌.
    ///위젯 뷰에 새로운 렌더링으로 업데이트 할 시기를 위젯킷에게 알려줌
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        ///타임라인 정책
        ///타임라인 마지막 날짜가 지난 뒤, 위젯킷이 새로운 타임라인을 요청할 수 있도록 설정
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

//Entry: TimeLineEntry
// 실제 위젯 구성 시 필요한 데이터
// 스택 최상단 유지하도록 하는 score 혹은 기타 등등을 기준으로 다룸
struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

//EntryView: 실제 위젯에 대한 뷰 담당
struct BasicWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(UserDefaults.standard.string(forKey: "Dobong") ?? "위젯: 없음")
            Text(UserDefaults.groupShared.string(forKey: "Dobong") ?? "위젯: 없음")
                .font(.title)
            Text(entry.date, style: .time)

            Text("Emoji: \(Int.random(in: 1...100))")
            Text(entry.emoji)
            
        }
    }
}

//최종적으로 구성됮는 WidgetConfiguration
struct BasicWidget: Widget {
    let kind: String = "BasicWidget" //고유한 위젯

    //위젯 편집이 없는 정적인 상태로 위젯 설정 = StaticConfiguration
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                BasicWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                BasicWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("케케몬")
        .description("나는야 케케몬This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemLarge) {
    BasicWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
