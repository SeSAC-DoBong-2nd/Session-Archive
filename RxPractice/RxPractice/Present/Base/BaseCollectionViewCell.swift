//
//  BaseCollectionViewCell.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/16/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
