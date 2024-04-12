//
//  MyFavoriteCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class MyFavoriteCollectionViewCell: BaseCollectionViewCell {
    
    let coinInfo = CoinInfoBox()
    let stackView = UIStackView()
    let price = UILabel()
    let price_change_percentage = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(coinInfo)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(price)
        stackView.addArrangedSubview(price_change_percentage)
    }
    
    override func configureView() {
        
        self.layer.cornerRadius = 15
        backgroundColor = .subBackground
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        price.text = "1234원"
        price.textColor = .secondLabel
        
        price_change_percentage.text = "100%"
        price_change_percentage.textColor = .redLabel
    }
    
    override func setConstraints() {
        coinInfo.snp.makeConstraints {
            $0.left.top.equalTo(contentView).offset(10)
            $0.right.equalTo(contentView)
        }
        stackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(coinInfo.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.bottom.equalTo(contentView).inset(15)
        }
    }
}
