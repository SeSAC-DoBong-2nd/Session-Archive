//
//  PostViewController.swift
//  LSLPBasic
//
//  Created by jack on 2024/04/09.
//

import UIKit

final class PostViewController: BaseViewController {
    
    private let selfView = PostView()
    private let withDrawButton = UIBarButtonItem()
    private let postButton = UIBarButtonItem()
    
    private let viewModel = PostViewModel()

    override func loadView() {
        self.view = selfView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        
    }
    
    override func bind() {
        
    }
    
    private func setNavigation() {
      //  withDrawButton.image = UIImage(systemName: "heart")
        postButton.image = UIImage(systemName: "plus")
       // navigationItem.leftBarButtonItem = withDrawButton
        navigationItem.rightBarButtonItem = postButton
    }
}
