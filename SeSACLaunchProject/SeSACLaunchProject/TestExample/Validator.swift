//
//  Validator.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 4/7/25.
//

//Validator == VM 으로 생각하자

import Foundation

//VC
struct User {
    let email: String
    let password: String
    let check: String
}

struct Validator {
    
    func isValidEmail(email: String) -> Bool {
        return email.contains("@") && email.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 10
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {
        return password == check
    }
    
}
