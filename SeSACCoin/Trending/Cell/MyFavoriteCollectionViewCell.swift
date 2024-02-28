//
//  MyFavoriteCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class MyFavoriteCollectionViewCell: BaseCollectionViewCell {
    
    let coinInfo = CoinInfoBox()
    
    override func configureHierarchy() {
        contentView.addSubview(coinInfo)
    }
    
    override func configureView() {
        
        self.layer.cornerRadius = 15
        backgroundColor = .subBackground
    }
    
    override func setConstraints() {
        coinInfo.snp.makeConstraints {
            $0.left.top.equalTo(contentView).offset(10)
            $0.right.top.equalTo(contentView)
        }
    }
}
