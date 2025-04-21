//
//  ViewModelType.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

/*
 오늘 목표
 - WidgetKit -> 출시 앱에 위젯을 녹이기
 - NavigationView vs NavigationStack
 
 위젯  언제 사용?!
 - 배터리, 날씨, 주식 등
 - small, medium, large, ipad 크기 등
 - SmartStack
 - 오늘 보기
 - iOS16+ 잠금화면, 라이브 액티비티
 - iOS17+ Interactive Wiget (대화형 위젯)
 - iOS18+ Control Widget (잠금화면 위젯)
 - App intent = 위젯 편집기능 다룰지 말지
 
 - 위젯 편집 기능
 - 라이브 엑티비티
 
 - WidgetKit (iOS14+, SwiftUI) vs Today Extension(iOS 18에서는 완전히 Deprecated)
 */

import Foundation

import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get set }
    
    var input: Input { get set }
    var output: Output { get set }
    
    func transform()
}
