//
//  ViewController.swift
//  SeSAC6Sample
//
//  Created by 박신영 on 4/7/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var checkField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idField.accessibilityIdentifier = "id_field"
        pwField.accessibilityIdentifier = "pw_field"
        checkField.accessibilityIdentifier = "check_field"
        doneButton.accessibilityIdentifier = "done_button"
        resultLabel.accessibilityIdentifier = "result_label"
        // Do any additional setup after loading the view.
        
        // accessibilityHint: 접근성 다룬 메서드이기에 이를 잘 다루자
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
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
              let check = checkField.text else {
            return false }
        return password == check
    }

}

