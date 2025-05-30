//
//  BaseViewController.swift
//  LSLPBasic
//
//  Created by jack on 2024/04/09.
//
 
import UIKit

class BaseViewController: UIViewController {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        bind()
    }
    
    func bind() {
        
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
