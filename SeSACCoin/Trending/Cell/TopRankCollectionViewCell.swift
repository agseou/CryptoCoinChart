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
        stackView.addSubview(price)
        stackView.addSubview(price_change_percentage)
    }
    
    override func configureView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.alignment = .trailing
     
        price.textColor = .mainLabel
        price.text = "$0.417"
        
        price_change_percentage.textColor = .redLabel
        price_change_percentage.text = "+2.123%"
    }
    
    override func setConstraints() {
        rank.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.left.equalTo(contentView)
        }
        coinInfo.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.left.equalTo(rank.snp.right)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.right.equalTo(contentView)
        }
    }
}
