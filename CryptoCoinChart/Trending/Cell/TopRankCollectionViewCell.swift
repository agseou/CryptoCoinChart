//
//  TopRankCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/28.
//

import UIKit

class TopRankCollectionViewCell: BaseCollectionViewCell {
    
    let rank = UILabel()
    let coinInfo = CoinInfoBox()
    let stackView = UIStackView()
    let price = UILabel()
    let price_change_percentage = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(rank)
        contentView.addSubview(coinInfo)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(price)
        stackView.addArrangedSubview(price_change_percentage)
    }
    
    override func configureView() {
        rank.textColor = .secondLabel
        rank.font = .systemFont(ofSize: 30, weight: .black)
        rank.text = "1"
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.alignment = .trailing
        
        coinInfo.nameLabel.textColor = .mainLabel
     
        price.textColor = .secondLabel
        price.text = "$0.417"
        
        price_change_percentage.textColor = .redLabel
        price_change_percentage.font = .systemFont(ofSize: 14)
        price_change_percentage.text = "+2.123%"
    }
    
    override func setConstraints() {
        rank.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.left.equalTo(contentView)
        }
        coinInfo.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.left.equalTo(rank.snp.right).offset(10)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.left.equalTo(coinInfo.snp.right).offset(10)
            $0.right.equalTo(contentView)
        }
    }
}
