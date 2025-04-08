//
//  LoginViewController.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 4/7/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var pwCheckField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        if isValidID() && isValidPassword() && isEqualPassword() {
            resultLabel.text = "성공"
        } else { resultLabel.text = "실패"}
    }
    
    func isValidID() -> Bool {
        guard let email = idField.text else { return false }
        return email.contains("@") && email.count  >= 6
    }
    
    func isValidPassword() -> Bool {
        guard let password = pwField.text else { return false }
        return password.count >= 6 && password.count < 10
    }
    
    func isEqualPassword() -> Bool {
        guard let password = pwField.text,
              let check = pwCheckField.text else {
            return false }
        return password == check
    }
    
}
