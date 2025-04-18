//
//  ViewModelType.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/17/25.
//

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
