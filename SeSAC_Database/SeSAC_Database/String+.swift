//
//  String+.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/12/25.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
    
}
