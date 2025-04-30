//
//  PostCollectionViewCell.swift
//  LSLPBasic
//
//  Created by jack on 2024/04/09.
//

import UIKit
import SnapKit

final class PostCollectionViewCell: BaseCollectionViewCell {
    private let postImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    override func draw(_ rect: CGRect) {
        postImageView.layer.cornerRadius = 8
    }
    
    override func configure() {
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
    }
    
    override func setConstraints() {
        postImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(postImageView).inset(8)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
}
 
