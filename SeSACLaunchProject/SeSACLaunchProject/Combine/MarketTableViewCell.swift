//
//  MarketTableViewCell.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/26/25.
//

import UIKit

import SnapKit

final class MarketTableViewCell: UITableViewCell {
    
    private let koreanNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let marketLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    private let englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(koreanNameLabel)
        contentView.addSubview(marketLabel)
        contentView.addSubview(englishNameLabel)
        
        koreanNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        marketLabel.snp.makeConstraints { make in
            make.top.equalTo(koreanNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(koreanNameLabel)
        }
        
        englishNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }   
    }
    
    func configure(with market: Market) {
        koreanNameLabel.text = market.koreanName
        marketLabel.text = market.market
        englishNameLabel.text = market.englishName
    }
    
}
