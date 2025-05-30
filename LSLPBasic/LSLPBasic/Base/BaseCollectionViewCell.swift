//
//  BaseCollectionViewCell.swift
//  LSLPBasic
//
//  Created by jack on 2024/04/09.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setHierarchy()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() { }
    func configure() { }
    func setConstraints() { }
    
}
