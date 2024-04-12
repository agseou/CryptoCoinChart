//
//  MoreCollectionViewCell.swift
//  SeSACCoin
//
//  Created by 은서우 on 2024/03/04.
//

import UIKit

class MoreCollectionViewCell: BaseCollectionViewCell {
    
    let moreLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(moreLabel)
    }
    
    override func configureView() {
        self.layer.cornerRadius = 15
        backgroundColor = .subBackground
        
        moreLabel.text = "더보기"
        moreLabel.textColor = .mainLabel
        moreLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    override func setConstraints() {
        moreLabel.snp.makeConstraints {
            $0.center.equalTo(contentView)
        }
    }
}
