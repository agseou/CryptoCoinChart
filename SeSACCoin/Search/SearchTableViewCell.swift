//
//  SearchTableViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/02/27.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {

    let coininfo = CoinInfoBox()
    let favoriteBtn = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(coininfo)
        contentView.addSubview(favoriteBtn)
    }
    
    override func configureView() {
        favoriteBtn.setImage(.btnStar, for: .normal)
    }

    override func setConstraints() {
        coininfo.snp.makeConstraints {
            $0.left.equalTo(contentView).offset(15)
            $0.centerY.equalTo(contentView)
            $0.verticalEdges.equalTo(contentView).inset(10)
            $0.right.equalTo(favoriteBtn.snp.left).inset(10)
        }
        favoriteBtn.snp.makeConstraints {
            $0.right.equalTo(contentView).inset(20)
            $0.centerY.equalTo(contentView)
        }
    }
}
