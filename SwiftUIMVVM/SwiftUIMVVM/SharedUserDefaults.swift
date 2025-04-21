//
//  SharedUserDefaults.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/21/25.
//

import Foundation

extension UserDefaults {
    
    static var groupShared: UserDefaults {
        let appID = "group.SwiftUIMVVM"
        return UserDefaults(suiteName: appID)!
    }
    
}
